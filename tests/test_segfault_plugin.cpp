#include <gtest/gtest.h>

#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <string>

TEST(SegfaultPluginTest, WritesSegfaultReport) {
    std::filesystem::remove("segfault_report.txt");

#ifdef _WIN32
    const std::string command = "segfault_helper.exe plugin_segfault.dll";
#else
    const std::string command = "./segfault_helper ./libplugin_segfault.so";
#endif

    const int result = std::system(command.c_str());

    EXPECT_NE(result, 0);
    ASSERT_TRUE(std::filesystem::exists("segfault_report.txt"));

    std::ifstream file("segfault_report.txt");

    const std::string contents{std::istreambuf_iterator<char>{file},
                               std::istreambuf_iterator<char>{}};

    EXPECT_NE(contents.find("Stack trace:"), std::string::npos);
}