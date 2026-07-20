import os

from conan import ConanFile
from conan.tools.cmake import CMake, CMakeDeps, CMakeToolchain, cmake_layout


class RuntimePluginChallengeConan(ConanFile):
    name = "challenge_project"
    version = "1.0.0"
    package_type = "shared-library"
    settings = "os", "arch", "compiler", "build_type"
    exports_sources = (
        "CMakeLists.txt",
        "app/*",
        "plugin/*",
        "tests/*",
    )

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
        
    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        plugin = self.cpp_info.components["plugin"]
        plugin.libs = ["plugin"]
        plugin.requires = ["boost::log"]
        plugin.set_property(
            "cmake_target_name",
            "challenge_project::plugin",
        )

        segfault_plugin = self.cpp_info.components["segfault_plugin"]
        segfault_plugin.libs = ["plugin_segfault"]
        segfault_plugin.set_property(
            "cmake_target_name",
            "challenge_project::segfault_plugin",
        )