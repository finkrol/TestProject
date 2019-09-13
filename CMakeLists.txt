#=======================================================================
#TestProject
#=======================================================================
cmake_minimum_required(VERSION 3.10.0)

#-----------------------------------------------------------------------
#product-version
file(STRINGS product_version.txt VERSION_PRODUCT)
string(REPLACE "." "," PRODUCT_VERSION_COMMA ${VERSION_PRODUCT})
message(STATUS "VERSION_PRODUCT: " ${VERSION_PRODUCT})

#-----------------------------------------------------------------------
#build-number
file(STRINGS build_number.txt BUILD_NUMBER)
math(EXPR BUILD_NUMBER "${BUILD_NUMBER} + 1")
message(STATUS "BUILD_NUMBER: " ${BUILD_NUMBER})
file(WRITE build_number.txt ${BUILD_NUMBER})	

#-----------------------------------------------------------------------
#build date/time
string(TIMESTAMP BUILD_DATE_TIME "%Y-%m-%d/%H:%M:%S")
string(TIMESTAMP BUILD_YEAR "%Y")
message(STATUS "BUILD_DATE_TIME: " ${BUILD_DATE_TIME})
message(STATUS "-------------------------")

#-----------------------------------------------------------------------
#project
set(PROJECT_NAME TestProject)
set(BRIEF "This is the TestProject to show that VS2017 in combination with Git shows files with build errors all-lower-case in Build-output window.")
set(AUTHOR "Fink Roland")
set(COAUTHOR "-")
set(VERSION_MAJOR 0)
set(VERSION_MINOR 1)
set(VERSION_PATCH 0)
set(VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH})
set(PRODUCT_NAME "TestProject")
set(COMPANY_NAME "-")
set(COPYRIGHT "Copyright (C) ${BUILD_YEAR} by ${AUTHOR}")
project(${PROJECT_NAME})

#-----------------------------------------------------------------------
#build-settings
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(USED_SOURCE_DIR "src")
set(USED_INCLUDE_DIR "inc")
set(USED_RESOURCE_DIR "res")
set(USED_DOC_DIR "doc")
set(USED_ARCHIVE_DIR "bin")	#.lib (-static and import-libs)
set(USED_LIBRARY_DIR "bin")	#.dll
set(USED_RUNTIME_DIR "bin")	#.exe
set(USED_DATA_DIR "data")	#.*

#-----------------------------------------------------------------------
#includes
include(Common)
include(Version)

#-----------------------------------------------------------------------
#version information for windows:
patch_version_info()

#-----------------------------------------------------------------------
#set platform (win32/x64)
set_platform_name()

#-----------------------------------------------------------------------
#packages

#-----------------------------------------------------------------------
#include the source folder's CMakeList (*.cpp, *.h, *.proto)
include(${USED_SOURCE_DIR}/CMakeLists.txt)
foreach (FILE ${SOURCE_FILES})
    set (TESTPROJ_SOURCE_FILES ${TESTPROJ_SOURCE_FILES} ${USED_SOURCE_DIR}/${FILE})	
endforeach (FILE)
foreach (FILE ${HEADER_FILES})
    set (TESTPROJ_HEADER_FILES ${TESTPROJ_HEADER_FILES} ${USED_SOURCE_DIR}/${FILE})	
endforeach (FILE)

#-----------------------------------------------------------------------
#create executable
add_executable(${PROJECT_NAME} ${GUI_TYPE}
    ${TESTPROJ_SOURCE_FILES}
    ${TESTPROJ_HEADER_FILES} 	
    ${TESTPROJ_RESOURCE_FILES}
)
target_link_libraries(${PROJECT_NAME}
)
#add_dependencies(${PROJECT_NAME}
#)

#-----------------------------------------------------------------------
#install targets
install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets								# for downstream dependencies	
    ARCHIVE DESTINATION ${USED_ARCHIVE_DIR} COMPONENT libs		# lib
    RUNTIME DESTINATION ${USED_RUNTIME_DIR} COMPONENT libs		# binaries
    LIBRARY DESTINATION ${USED_LIBRARY_DIR} COMPONENT libs		# dll	
)
