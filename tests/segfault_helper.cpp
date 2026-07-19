#include <cstdlib>
#include <iostream>
#ifdef _WIN32
#include <windows.h>
#else
#include <dlfcn.h>
#endif

using plugin_init_fn = int (*)();

int main(int argc, char **argv)
{
    if (argc != 2)
    {
        return 1;
    }

#ifdef _WIN32
    HMODULE library = LoadLibraryA(argv[1]);

    if (library == nullptr)
    {
        return 2;
    }

    auto plugin_init = reinterpret_cast<plugin_init_fn>(
        GetProcAddress(library, "plugin_init"));
#else
    void *library = dlopen(argv[1], RTLD_NOW);

    if (library == nullptr)
    {
        return 2;
    }

    auto plugin_init =
        reinterpret_cast<plugin_init_fn>(dlsym(library, "plugin_init"));
#endif

    if (plugin_init == nullptr || plugin_init() != 0)
    {
        return 3;
    }

    volatile int *pointer = nullptr;
    *pointer = 1;

    return 0;
}