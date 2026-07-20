########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(challenge_project_FIND_QUIETLY)
    set(challenge_project_MESSAGE_MODE VERBOSE)
else()
    set(challenge_project_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/challenge_projectTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${challenge_project_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(challenge_project_VERSION_STRING "1.0.0")
set(challenge_project_INCLUDE_DIRS ${challenge_project_INCLUDE_DIRS_RELEASE} )
set(challenge_project_INCLUDE_DIR ${challenge_project_INCLUDE_DIRS_RELEASE} )
set(challenge_project_LIBRARIES ${challenge_project_LIBRARIES_RELEASE} )
set(challenge_project_DEFINITIONS ${challenge_project_DEFINITIONS_RELEASE} )


# Definition of extra CMake variables from cmake_extra_variables


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${challenge_project_BUILD_MODULES_PATHS_RELEASE} )
    message(${challenge_project_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


