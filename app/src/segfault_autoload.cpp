#include <filesystem>
#include <iostream>

#ifdef _WIN32
#include <windows.h>
#else
#include <dlfcn.h>
#include <unistd.h>
#endif

using plugin_init_fn = int (*)();

namespace {

#ifdef _WIN32

HMODULE handle = nullptr;

std::filesystem::path executable_directory() {
    char path[MAX_PATH]{};
    GetModuleFileNameA(nullptr, path, MAX_PATH);
    return std::filesystem::path(path).parent_path();
}

void load_segfault_plugin() {
    const auto path = executable_directory() / "plugin_segfault.dll";

    std::cout << "Loading plugin from: " << path << '\n';

    handle = LoadLibraryA(path.string().c_str());

    if (handle == nullptr) {
        std::cerr << "Failed to load segfault plugin\n";
        return;
    }

    const auto init = reinterpret_cast<plugin_init_fn>(GetProcAddress(handle, "plugin_init"));

    if (init != nullptr && init() == 0) {
        std::cout << "Segfault plugin loaded successfully!\n";
    }
}

#else

void *handle = nullptr;

std::filesystem::path executable_directory() {
    return std::filesystem::canonical("/proc/self/exe").parent_path();
}

void load_segfault_plugin() {
    const auto path = executable_directory() / ".." / "lib" / "libplugin_segfault.so";

    std::cout << "Loading plugin from: " << path << '\n';

    handle = dlopen(path.c_str(), RTLD_NOW);

    if (handle == nullptr) {
        std::cerr << "Failed to load segfault plugin: " << dlerror() << '\n';
        return;
    }

    const auto init = reinterpret_cast<plugin_init_fn>(dlsym(handle, "plugin_init"));

    if (init != nullptr && init() == 0) {
        std::cout << "Segfault plugin loaded successfully!\n";
    }
}

#endif

struct SegfaultPluginAutoload {
    SegfaultPluginAutoload() { load_segfault_plugin(); }
};

SegfaultPluginAutoload autoload;

} // namespace