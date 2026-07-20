########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND challenge_project_COMPONENT_NAMES challenge_project::plugin challenge_project::segfault_plugin)
list(REMOVE_DUPLICATES challenge_project_COMPONENT_NAMES)
if(DEFINED challenge_project_FIND_DEPENDENCY_NAMES)
  list(APPEND challenge_project_FIND_DEPENDENCY_NAMES Boost)
  list(REMOVE_DUPLICATES challenge_project_FIND_DEPENDENCY_NAMES)
else()
  set(challenge_project_FIND_DEPENDENCY_NAMES Boost)
endif()
set(Boost_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(challenge_project_PACKAGE_FOLDER_RELEASE "/home/fahad471/.conan2/p/b/chall47cf0ddfe6c88/p")
set(challenge_project_BUILD_MODULES_PATHS_RELEASE )


set(challenge_project_INCLUDE_DIRS_RELEASE "${challenge_project_PACKAGE_FOLDER_RELEASE}/include")
set(challenge_project_RES_DIRS_RELEASE )
set(challenge_project_DEFINITIONS_RELEASE )
set(challenge_project_SHARED_LINK_FLAGS_RELEASE )
set(challenge_project_EXE_LINK_FLAGS_RELEASE )
set(challenge_project_OBJECTS_RELEASE )
set(challenge_project_COMPILE_DEFINITIONS_RELEASE )
set(challenge_project_COMPILE_OPTIONS_C_RELEASE )
set(challenge_project_COMPILE_OPTIONS_CXX_RELEASE )
set(challenge_project_LIB_DIRS_RELEASE "${challenge_project_PACKAGE_FOLDER_RELEASE}/lib")
set(challenge_project_BIN_DIRS_RELEASE "${challenge_project_PACKAGE_FOLDER_RELEASE}/bin")
set(challenge_project_LIBRARY_TYPE_RELEASE SHARED)
set(challenge_project_IS_HOST_WINDOWS_RELEASE 0)
set(challenge_project_LIBS_RELEASE plugin_segfault plugin)
set(challenge_project_SYSTEM_LIBS_RELEASE )
set(challenge_project_FRAMEWORK_DIRS_RELEASE )
set(challenge_project_FRAMEWORKS_RELEASE )
set(challenge_project_BUILD_DIRS_RELEASE )
set(challenge_project_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(challenge_project_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${challenge_project_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${challenge_project_COMPILE_OPTIONS_C_RELEASE}>")
set(challenge_project_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${challenge_project_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${challenge_project_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${challenge_project_EXE_LINK_FLAGS_RELEASE}>")


set(challenge_project_COMPONENTS_RELEASE challenge_project::plugin challenge_project::segfault_plugin)
########### COMPONENT challenge_project::segfault_plugin VARIABLES ############################################

set(challenge_project_challenge_project_segfault_plugin_INCLUDE_DIRS_RELEASE "${challenge_project_PACKAGE_FOLDER_RELEASE}/include")
set(challenge_project_challenge_project_segfault_plugin_LIB_DIRS_RELEASE "${challenge_project_PACKAGE_FOLDER_RELEASE}/lib")
set(challenge_project_challenge_project_segfault_plugin_BIN_DIRS_RELEASE "${challenge_project_PACKAGE_FOLDER_RELEASE}/bin")
set(challenge_project_challenge_project_segfault_plugin_LIBRARY_TYPE_RELEASE SHARED)
set(challenge_project_challenge_project_segfault_plugin_IS_HOST_WINDOWS_RELEASE 0)
set(challenge_project_challenge_project_segfault_plugin_RES_DIRS_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_DEFINITIONS_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_OBJECTS_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_COMPILE_DEFINITIONS_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_COMPILE_OPTIONS_C_RELEASE "")
set(challenge_project_challenge_project_segfault_plugin_COMPILE_OPTIONS_CXX_RELEASE "")
set(challenge_project_challenge_project_segfault_plugin_LIBS_RELEASE plugin_segfault)
set(challenge_project_challenge_project_segfault_plugin_SYSTEM_LIBS_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_FRAMEWORK_DIRS_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_FRAMEWORKS_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_DEPENDENCIES_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_SHARED_LINK_FLAGS_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_EXE_LINK_FLAGS_RELEASE )
set(challenge_project_challenge_project_segfault_plugin_NO_SONAME_MODE_RELEASE FALSE)

# COMPOUND VARIABLES
set(challenge_project_challenge_project_segfault_plugin_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${challenge_project_challenge_project_segfault_plugin_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${challenge_project_challenge_project_segfault_plugin_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${challenge_project_challenge_project_segfault_plugin_EXE_LINK_FLAGS_RELEASE}>
)
set(challenge_project_challenge_project_segfault_plugin_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${challenge_project_challenge_project_segfault_plugin_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${challenge_project_challenge_project_segfault_plugin_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT challenge_project::plugin VARIABLES ############################################

set(challenge_project_challenge_project_plugin_INCLUDE_DIRS_RELEASE "${challenge_project_PACKAGE_FOLDER_RELEASE}/include")
set(challenge_project_challenge_project_plugin_LIB_DIRS_RELEASE "${challenge_project_PACKAGE_FOLDER_RELEASE}/lib")
set(challenge_project_challenge_project_plugin_BIN_DIRS_RELEASE "${challenge_project_PACKAGE_FOLDER_RELEASE}/bin")
set(challenge_project_challenge_project_plugin_LIBRARY_TYPE_RELEASE SHARED)
set(challenge_project_challenge_project_plugin_IS_HOST_WINDOWS_RELEASE 0)
set(challenge_project_challenge_project_plugin_RES_DIRS_RELEASE )
set(challenge_project_challenge_project_plugin_DEFINITIONS_RELEASE )
set(challenge_project_challenge_project_plugin_OBJECTS_RELEASE )
set(challenge_project_challenge_project_plugin_COMPILE_DEFINITIONS_RELEASE )
set(challenge_project_challenge_project_plugin_COMPILE_OPTIONS_C_RELEASE "")
set(challenge_project_challenge_project_plugin_COMPILE_OPTIONS_CXX_RELEASE "")
set(challenge_project_challenge_project_plugin_LIBS_RELEASE plugin)
set(challenge_project_challenge_project_plugin_SYSTEM_LIBS_RELEASE )
set(challenge_project_challenge_project_plugin_FRAMEWORK_DIRS_RELEASE )
set(challenge_project_challenge_project_plugin_FRAMEWORKS_RELEASE )
set(challenge_project_challenge_project_plugin_DEPENDENCIES_RELEASE Boost::log)
set(challenge_project_challenge_project_plugin_SHARED_LINK_FLAGS_RELEASE )
set(challenge_project_challenge_project_plugin_EXE_LINK_FLAGS_RELEASE )
set(challenge_project_challenge_project_plugin_NO_SONAME_MODE_RELEASE FALSE)

# COMPOUND VARIABLES
set(challenge_project_challenge_project_plugin_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${challenge_project_challenge_project_plugin_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${challenge_project_challenge_project_plugin_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${challenge_project_challenge_project_plugin_EXE_LINK_FLAGS_RELEASE}>
)
set(challenge_project_challenge_project_plugin_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${challenge_project_challenge_project_plugin_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${challenge_project_challenge_project_plugin_COMPILE_OPTIONS_C_RELEASE}>")