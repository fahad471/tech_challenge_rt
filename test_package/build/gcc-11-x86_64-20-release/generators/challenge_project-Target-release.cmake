# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(challenge_project_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(challenge_project_FRAMEWORKS_FOUND_RELEASE "${challenge_project_FRAMEWORKS_RELEASE}" "${challenge_project_FRAMEWORK_DIRS_RELEASE}")

set(challenge_project_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET challenge_project_DEPS_TARGET)
    add_library(challenge_project_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET challenge_project_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${challenge_project_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${challenge_project_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:Boost::log>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### challenge_project_DEPS_TARGET to all of them
conan_package_library_targets("${challenge_project_LIBS_RELEASE}"    # libraries
                              "${challenge_project_LIB_DIRS_RELEASE}" # package_libdir
                              "${challenge_project_BIN_DIRS_RELEASE}" # package_bindir
                              "${challenge_project_LIBRARY_TYPE_RELEASE}"
                              "${challenge_project_IS_HOST_WINDOWS_RELEASE}"
                              challenge_project_DEPS_TARGET
                              challenge_project_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "challenge_project"    # package_name
                              "${challenge_project_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${challenge_project_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Release ########################################

    ########## COMPONENT challenge_project::segfault_plugin #############

        set(challenge_project_challenge_project_segfault_plugin_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(challenge_project_challenge_project_segfault_plugin_FRAMEWORKS_FOUND_RELEASE "${challenge_project_challenge_project_segfault_plugin_FRAMEWORKS_RELEASE}" "${challenge_project_challenge_project_segfault_plugin_FRAMEWORK_DIRS_RELEASE}")

        set(challenge_project_challenge_project_segfault_plugin_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET challenge_project_challenge_project_segfault_plugin_DEPS_TARGET)
            add_library(challenge_project_challenge_project_segfault_plugin_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET challenge_project_challenge_project_segfault_plugin_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_DEPENDENCIES_RELEASE}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'challenge_project_challenge_project_segfault_plugin_DEPS_TARGET' to all of them
        conan_package_library_targets("${challenge_project_challenge_project_segfault_plugin_LIBS_RELEASE}"
                              "${challenge_project_challenge_project_segfault_plugin_LIB_DIRS_RELEASE}"
                              "${challenge_project_challenge_project_segfault_plugin_BIN_DIRS_RELEASE}" # package_bindir
                              "${challenge_project_challenge_project_segfault_plugin_LIBRARY_TYPE_RELEASE}"
                              "${challenge_project_challenge_project_segfault_plugin_IS_HOST_WINDOWS_RELEASE}"
                              challenge_project_challenge_project_segfault_plugin_DEPS_TARGET
                              challenge_project_challenge_project_segfault_plugin_LIBRARIES_TARGETS
                              "_RELEASE"
                              "challenge_project_challenge_project_segfault_plugin"
                              "${challenge_project_challenge_project_segfault_plugin_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET challenge_project::segfault_plugin
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_LIBRARIES_TARGETS}>
                     )

        if("${challenge_project_challenge_project_segfault_plugin_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET challenge_project::segfault_plugin
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         challenge_project_challenge_project_segfault_plugin_DEPS_TARGET)
        endif()

        set_property(TARGET challenge_project::segfault_plugin APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_LINKER_FLAGS_RELEASE}>)
        set_property(TARGET challenge_project::segfault_plugin APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_INCLUDE_DIRS_RELEASE}>)
        set_property(TARGET challenge_project::segfault_plugin APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_LIB_DIRS_RELEASE}>)
        set_property(TARGET challenge_project::segfault_plugin APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_COMPILE_DEFINITIONS_RELEASE}>)
        set_property(TARGET challenge_project::segfault_plugin APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_segfault_plugin_COMPILE_OPTIONS_RELEASE}>)


    ########## COMPONENT challenge_project::plugin #############

        set(challenge_project_challenge_project_plugin_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(challenge_project_challenge_project_plugin_FRAMEWORKS_FOUND_RELEASE "${challenge_project_challenge_project_plugin_FRAMEWORKS_RELEASE}" "${challenge_project_challenge_project_plugin_FRAMEWORK_DIRS_RELEASE}")

        set(challenge_project_challenge_project_plugin_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET challenge_project_challenge_project_plugin_DEPS_TARGET)
            add_library(challenge_project_challenge_project_plugin_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET challenge_project_challenge_project_plugin_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_DEPENDENCIES_RELEASE}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'challenge_project_challenge_project_plugin_DEPS_TARGET' to all of them
        conan_package_library_targets("${challenge_project_challenge_project_plugin_LIBS_RELEASE}"
                              "${challenge_project_challenge_project_plugin_LIB_DIRS_RELEASE}"
                              "${challenge_project_challenge_project_plugin_BIN_DIRS_RELEASE}" # package_bindir
                              "${challenge_project_challenge_project_plugin_LIBRARY_TYPE_RELEASE}"
                              "${challenge_project_challenge_project_plugin_IS_HOST_WINDOWS_RELEASE}"
                              challenge_project_challenge_project_plugin_DEPS_TARGET
                              challenge_project_challenge_project_plugin_LIBRARIES_TARGETS
                              "_RELEASE"
                              "challenge_project_challenge_project_plugin"
                              "${challenge_project_challenge_project_plugin_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET challenge_project::plugin
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_LIBRARIES_TARGETS}>
                     )

        if("${challenge_project_challenge_project_plugin_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET challenge_project::plugin
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         challenge_project_challenge_project_plugin_DEPS_TARGET)
        endif()

        set_property(TARGET challenge_project::plugin APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_LINKER_FLAGS_RELEASE}>)
        set_property(TARGET challenge_project::plugin APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_INCLUDE_DIRS_RELEASE}>)
        set_property(TARGET challenge_project::plugin APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_LIB_DIRS_RELEASE}>)
        set_property(TARGET challenge_project::plugin APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_COMPILE_DEFINITIONS_RELEASE}>)
        set_property(TARGET challenge_project::plugin APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${challenge_project_challenge_project_plugin_COMPILE_OPTIONS_RELEASE}>)


    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET challenge_project::challenge_project APPEND PROPERTY INTERFACE_LINK_LIBRARIES challenge_project::segfault_plugin)
    set_property(TARGET challenge_project::challenge_project APPEND PROPERTY INTERFACE_LINK_LIBRARIES challenge_project::plugin)

########## For the modules (FindXXX)
set(challenge_project_LIBRARIES_RELEASE challenge_project::challenge_project)
