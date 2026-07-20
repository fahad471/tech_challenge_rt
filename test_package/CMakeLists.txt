cmake_minimum_required(VERSION 3.21)

project(challenge_test_package LANGUAGES CXX)

find_package(challenge_project CONFIG REQUIRED)

add_executable(
    test_package
    src/test_package.cpp
)

target_link_libraries(
    test_package
    PRIVATE
        challenge_project::plugin
)

target_compile_features(
    test_package
    PRIVATE
        cxx_std_20
)