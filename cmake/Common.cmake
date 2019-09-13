#=======================================================================
#Commonly used helper functions
#This file requires the following command to be called:
#set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
#=======================================================================

#-----------------------------------------------------------------------
#Add include directories for a spec. Library in a spec. project-dir which does NOT have an API
# param[in] project_dir ... name of the project directory where to find the library
# param[in] lib_name    ... name of the desired library
#-----------------------------------------------------------------------
function(include_directories_noapi project_dir lib_name)
    include_directories(${CMAKE_INCLUDE_OUTPUT_DIRECTORY}/${lib_name})	                    #version-patched interface headers are here
    include_directories(${CMAKE_SOURCE_DIR}/${project_dir}/${lib_name}/${USED_SOURCE_DIR})	#if we use an API this folder should not be included to avoid missuse of code
    include_directories(${CMAKE_BINARY_DIR}/${project_dir}/${lib_name})	                    #generated files (e.g.: proto-compiles) are here, version-patched interface headers are also here)
endfunction(include_directories_noapi)

#-----------------------------------------------------------------------
#Add include directories for a spec. Library in a spec. project-dir which does have an API
# param[in] project_dir ... name of the project directory where to find the library
# param[in] lib_name    ... name of the desired library
#-----------------------------------------------------------------------
function(include_directories_api project_dir lib_name)
    include_directories(${CMAKE_INCLUDE_OUTPUT_DIRECTORY}/${lib_name})	                    #version-patched interface headers are here
    include_directories(${CMAKE_SOURCE_DIR}/${project_dir}/${lib_name}/${USED_INCLUDE_DIR})	#directoy where all the API interface headers are located
    include_directories(${CMAKE_BINARY_DIR}/${project_dir}/${lib_name})	                    #generated files (e.g.: proto-compiles) are here, version-patched interface headers are also here)
endfunction(include_directories_api)

#-----------------------------------------------------------------------
#Add include directories for a spec. (header-only) Libraries
# param[in] project_dir ... name of the project directory where to find the library
# param[in] lib_name    ... name of the desired library
#-----------------------------------------------------------------------
function(include_directories_headeronly project_dir lib_name)
    include_directories(${CMAKE_SOURCE_DIR}/${project_dir}/${lib_name}/${USED_SOURCE_DIR})	#if we use an API this folder should not be included to avoid missuse of code
endfunction(include_directories_headeronly)

#-----------------------------------------------------------------------
#Sets the platform name (x86/x64)
#This is actually only necessary when using QtCreator,
#but we do it even if we use VS just for fun.
#-----------------------------------------------------------------------
function(set_platform_name)
    #win32/x64 (for Creator)
    if ("${CMAKE_SIZEOF_VOID_P}" EQUAL "8")
        message(STATUS "Target: x64")
        set (USED_PLATFORM "x64" PARENT_SCOPE)
    else ("${CMAKE_SIZEOF_VOID_P}" EQUAL "8")
        message(STATUS "Target: x86")
        set (USED_PLATFORM "x86" PARENT_SCOPE)
    endif ()
endfunction(set_platform_name)

#-----------------------------------------------------------------------
#Sets the config name (Debug/Release)
#-----------------------------------------------------------------------
function(set_config_name)
    if (MSVC_IDE)
        set(CMAKE_BUILD_TYPE "${CMAKE_CONFIGURATION_TYPES}" PARENT_SCOPE)
        message(STATUS "Configuration: " ${CMAKE_CONFIGURATION_TYPES})

        if ("${CMAKE_CONFIGURATION_TYPES}" STREQUAL "Debug")
            set(CMAKE_BUILD_TYPE "debug" PARENT_SCOPE)
            set(CMAKE_BUILD_TYPE_IS_RELEASE false CACHE BOOL "is_release")
            message(STATUS "Compile flags: " ${CMAKE_CXX_FLAGS_DEBUG})
        else ()
            set(CMAKE_BUILD_TYPE "release" PARENT_SCOPE)
            set(CMAKE_BUILD_TYPE_IS_RELEASE true CACHE BOOL "is_release")
            message(STATUS "Compile flags: " ${CMAKE_CXX_FLAGS_RELEASE})
        endif ()
    else ()
        if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
            set(CMAKE_BUILD_TYPE "debug" PARENT_SCOPE)
            set(CMAKE_BUILD_TYPE_IS_RELEASE false CACHE BOOL "is_release")
        else ()
            set(CMAKE_BUILD_TYPE "release" PARENT_SCOPE)
            set(CMAKE_BUILD_TYPE_IS_RELEASE true CACHE BOOL "is_release")
        endif ()
        message(STATUS "Compile flags: " ${CMAKE_BUILD_TYPE})
    endif ()
endfunction(set_config_name)

#-----------------------------------------------------------------------
#Includes a global header file containing start error codes for all subprojects
#-----------------------------------------------------------------------
function(set_global_error_codes)
    add_subdirectory(inc)
    include_directories(inc)
    add_definitions(-DUSE_GLOBAL_START_ERROR_CODES)
endfunction()

#-----------------------------------------------------------------------
#Includes a global inc directory
#-----------------------------------------------------------------------
function(set_global_include_path)
    include_directories(${CMAKE_INCLUDE_OUTPUT_DIRECTORY})
endfunction()
