cmake_minimum_required(VERSION 3.21)

project(
    runtime_plugin_challenge
    VERSION 1.0.0
    LANGUAGES CXX
)

option(ENABLE_SANITIZERS "Enable AddressSanitizer" OFF)

if(ENABLE_SANITIZERS)
    if(CMAKE_SYSTEM_NAME STREQUAL "Linux"
       AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")

        add_compile_options(
            -fsanitize=address
            -fno-omit-frame-pointer
        )

        add_link_options(
            -fsanitize=address
        )
    else()
        message(FATAL_ERROR
            "ENABLE_SANITIZERS is only supported with GCC or Clang on Linux"
        )
    endif()
endif()

# Apply C++20 consistently to all targets.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
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
# segfault detection plugin
# ---------------------------------------------------------------------------

add_library(segfault_plugin SHARED
    plugin/src/segfault_plugin.cpp
)



# ---------------------------------------------------------------------------
# Main application
# ---------------------------------------------------------------------------

add_executable(challenge
    app/src/main.cpp
    app/src/segfault_autoload.cpp
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
add_dependencies(
    challenge
    plugin
    segfault_plugin
)

# ---------------------------------------------------------------------------
# Tests
# ---------------------------------------------------------------------------

include(CTest)

if(BUILD_TESTING)
    find_package(GTest CONFIG REQUIRED)

    # Original plugin tests
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

    add_dependencies(plugin_tests plugin)

    add_test(
        NAME plugin_tests
        COMMAND plugin_tests
    )

    set_tests_properties(plugin_tests PROPERTIES
        WORKING_DIRECTORY "$<TARGET_FILE_DIR:plugin_tests>"
    )

    # Helper process that intentionally crashes
    add_executable(segfault_helper
        tests/segfault_helper.cpp
    )

    target_link_libraries(segfault_helper
        PRIVATE
            ${CMAKE_DL_LIBS}
    )

    add_dependencies(segfault_helper segfault_plugin)

    # segfault plugin test
    add_executable(segfault_plugin_tests
        tests/test_segfault_plugin.cpp
    )

    target_link_libraries(segfault_plugin_tests
        PRIVATE
            GTest::gtest_main
    )

    add_dependencies(
        segfault_plugin_tests
        segfault_helper
        segfault_plugin
    )

    add_test(
        NAME segfault_plugin_tests
        COMMAND segfault_plugin_tests
    )

    set_tests_properties(segfault_plugin_tests PROPERTIES
        WORKING_DIRECTORY "$<TARGET_FILE_DIR:segfault_plugin_tests>"
    )
endif()

# ---------------------------------------------------------------------------
# Installation
# ---------------------------------------------------------------------------

set_target_properties(segfault_plugin PROPERTIES
    OUTPUT_NAME plugin_segfault
)

if(UNIX AND NOT APPLE)
    set_target_properties(challenge PROPERTIES
        INSTALL_RPATH "$ORIGIN/../lib"
    )

    set_target_properties(plugin PROPERTIES
        INSTALL_RPATH "$ORIGIN"
    )

    target_link_options(plugin PRIVATE
        "-Wl,--disable-new-dtags"
    )
endif()

install(
    TARGETS
        challenge
        plugin
        segfault_plugin

    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

if(WIN32)
    install(
        DIRECTORY "${boost_BIN_DIRS_RELEASE}/"
        DESTINATION bin
        FILES_MATCHING
        PATTERN "*.dll"
    )
else()
    install(
        DIRECTORY "${boost_LIB_DIRS_RELEASE}/"
        DESTINATION lib
        FILES_MATCHING
        PATTERN "*.so*"
    )
endif()