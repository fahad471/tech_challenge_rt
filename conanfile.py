import os

from conan import ConanFile
from conan.tools.cmake import CMakeDeps, CMakeToolchain, cmake_layout


class RuntimePluginChallengeConan(ConanFile):
    settings = "os", "arch", "compiler", "build_type"

    default_options = {
        "boost/*:shared": True,
        "boost/*:without_cobalt": True,
        "gtest/*:shared": True,
    }

    def requirements(self):
        self.requires("boost/1.91.0")
        self.test_requires("gtest/1.17.0")

    def build_requirements(self):
        # Conan installs Ninja for the current build machine.
        self.tool_requires("ninja/1.13.1")

    def layout(self):
        cmake_layout(self)

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()

        toolchain = CMakeToolchain(self)
        toolchain.generator = "Ninja"

        # Point CMake directly to Conan's Ninja executable.
        # This avoids requiring conanbuild.bat/conanbuild.sh.
        ninja = self.dependencies.build["ninja"]
        ninja_bin = ninja.cpp_info.bindirs[0]

        executable = "ninja.exe" if self.settings_build.os == "Windows" else "ninja"

        toolchain.cache_variables["CMAKE_MAKE_PROGRAM"] = os.path.join(
            ninja_bin,
            executable,
        )

        toolchain.generate()