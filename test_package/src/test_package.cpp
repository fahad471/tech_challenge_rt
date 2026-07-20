#include "plugin/plugin.h"

#include <cstring>

int main() {
    if (plugin_init() != 0) {
        return 1;
    }

    const char *name = plugin_get_name();

    if (name == nullptr || std::strlen(name) == 0) {
        return 1;
    }

    return plugin_add(2, 3) == 5 ? 0 : 1;
}