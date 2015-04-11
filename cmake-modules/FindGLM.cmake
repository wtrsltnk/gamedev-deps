find_path(GLM_INCLUDE_DIR glm.hpp
	PATH_SUFFIXES include/glm include
)

mark_as_advanced(GLM_INCLUDE_DIR)

if(GLM_INCLUDE_DIR)
    set(GLM_FOUND TRUE)
endif()

if(GLM_FOUND)
    if(NOT GLM_FIND_QUIETLY)
        message(STATUS "Found GLM")
    endif()
else()
    if(GLM_FIND_REQUIRED)
        message(FATAL_ERROR "Could not find GLM")
    endif()
endif()
