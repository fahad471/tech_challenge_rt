# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/challenge_project-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${challenge_project_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${challenge_project_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET challenge_project::challenge_project)
    add_library(challenge_project::challenge_project INTERFACE IMPORTED)
    message(${challenge_project_MESSAGE_MODE} "Conan: Target declared 'challenge_project::challenge_project'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/challenge_project-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()