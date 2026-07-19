#include <cstdio>

#ifdef _WIN32
#include <dbghelp.h>
#include <windows.h>

namespace {

LONG WINAPI segfault_handler(EXCEPTION_POINTERS *) {
    FILE *file = nullptr;
    fopen_s(&file, "segfault_report.txt", "w");

    if (file != nullptr) {
        void *frames[32]{};
        const USHORT count = CaptureStackBackTrace(0, 32, frames, nullptr);

        std::fprintf(file, "Access violation\nStack trace:\n");

        for (USHORT i = 0; i < count; ++i) {
            std::fprintf(file, "%p\n", frames[i]);
        }

        std::fclose(file);
    }

    return EXCEPTION_EXECUTE_HANDLER;
}

} // namespace

extern "C" __declspec(dllexport) int plugin_init() {
    SetUnhandledExceptionFilter(segfault_handler);
    return 0;
}

#else

#include <csignal>
#include <execinfo.h>
#include <fcntl.h>
#include <unistd.h>

namespace {

void segfault_handler(int signal) {
    const int file = open("segfault_report.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);

    if (file >= 0) {
        constexpr char message[] = "Segmentation fault\nStack trace:\n";

        const auto written = write(file, message, sizeof(message) - 1);
        (void)written;

        void *frames[32]{};
        const int count = backtrace(frames, 32);
        backtrace_symbols_fd(frames, count, file);

        close(file);
    }

    _exit(128 + signal);
}

} // namespace

extern "C" int plugin_init() {
    std::signal(SIGSEGV, segfault_handler);
    return 0;
}

#endif