#=======================================================================
#helper functions for version patching
#This file requires the following command to be called:
#set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
#=======================================================================

#-----------------------------------------------------------------------
#Patches the dll with some version information
#-----------------------------------------------------------------------
function(patch_version_info)
	if (MSVC_IDE)
		#for windows we use a default resource file to patch in version info
		add_definitions(-DVER_FILEVERSION=${VERSION_MAJOR},${VERSION_MINOR},${VERSION_PATCH},${BUILD_NUMBER})
		add_definitions(-DVER_PRODUCTVERSION=${PRODUCT_VERSION_COMMA},${BUILD_NUMBER})
		add_definitions(-DVER_COMPANYNAME_STR="${COMPANY_NAME}")
		add_definitions(-DVER_LEGALCOPYRIGHT_STR="${COPYRIGHT}")
		add_definitions(-DVER_FILEVERSION_STR="${VERSION}.${BUILD_NUMBER}")
		add_definitions(-DVER_FILEDESCRIPTION_STR="${USED_PLATFORM}")
		add_definitions(-DVER_PRODUCTNAME_STR="${PRODUCT_NAME}")
		add_definitions(-DVER_PRODUCTVERSION_STR="${VERSION_PRODUCT}.${BUILD_NUMBER}")
		add_definitions(-DVER_ORIGINALFILENAME_STR="${PROJECT_NAME}.dll")
		add_definitions(-DVER_INTERNALNAME_STR="${PROJECT_NAME}")
	endif ()
	#version information for Linux:
	#ToDo:
endfunction(patch_version_info)

#eof