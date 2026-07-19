cmake_minimum_required(VERSION 3.21)

project(
    runtime_plugin_challenge
    VERSION 1.0.0
    LANGUAGES CXX
)

# Apply C++20 consistently to all targets.
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Keep executables and shared libraries together.
# This allows challenge and plugin_tests to find the plugin at runtime,
# especially on Windows where the DLL must normally be beside the executable.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

# Required for multi-configuration generators such as Visual Studio.
foreach(configuration Debug Release RelWithDebInfo MinSizeRel)
    string(TOUPPER "${configuration}" configuration_upper)

    set(
        CMAKE_RUNTIME_OUTPUT_DIRECTORY_${configuration_upper}
        "${CMAKE_BINARY_DIR}/bin"
    )
    set(
        CMAKE_LIBRARY_OUTPUT_DIRECTORY_${configuration_upper}
        "${CMAKE_BINARY_DIR}/bin"
    )
    set(
        CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${configuration_upper}
        "${CMAKE_BINARY_DIR}/lib"
    )
endforeach()

# ---------------------------------------------------------------------------
# Runtime plugin
# ---------------------------------------------------------------------------
find_package(
    Boost CONFIG REQUIRED
    COMPONENTS log
)

add_library(plugin SHARED
    plugin/src/plugin.cpp
)

target_compile_definitions(plugin
    PRIVATE
        PLUGIN_BUILDING
)

target_include_directories(plugin
    PUBLIC
        "${CMAKE_CURRENT_SOURCE_DIR}/plugin/include"
)

target_link_libraries(plugin
    PRIVATE
        Boost::log
)

# set_target_properties(plugin PROPERTIES
#     WINDOWS_EXPORT_ALL_SYMBOLS ON
# )
# ---------------------------------------------------------------------------
# Main application
# ---------------------------------------------------------------------------

add_executable(challenge
    app/src/main.cpp
)

target_include_directories(challenge
    PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/plugin/include"
)

# CMAKE_DL_LIBS evaluates to the dynamic-loader library where required,
# normally "dl" on Linux and an empty value on Windows.
target_link_libraries(challenge
    PRIVATE
        ${CMAKE_DL_LIBS}
)

# challenge intentionally does not link against the plugin target.
# This dependency only guarantees that the plugin is built first.
add_dependencies(challenge plugin)

# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

include(CTest)

if(BUILD_TESTING)
    find_package(GTest CONFIG REQUIRED)

    add_executable(plugin_tests
        tests/test_plugin.cpp
    )

    target_include_directories(plugin_tests
        PRIVATE
            "${CMAKE_CURRENT_SOURCE_DIR}/plugin/include"
    )

    target_link_libraries(plugin_tests
        PRIVATE
            GTest::gtest_main
            ${CMAKE_DL_LIBS}
    )

    # The tests load the plugin at runtime rather than linking against it.
    add_dependencies(plugin_tests plugin)

    add_test(
        NAME plugin_tests
        COMMAND plugin_tests
    )

    set_tests_properties(plugin_tests PROPERTIES
        WORKING_DIRECTORY "$<TARGET_FILE_DIR:plugin_tests>"
    )
endif()