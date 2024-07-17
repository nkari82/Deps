cmake_minimum_required(VERSION 3.15)
#set(CMAKE_SYSTEM_NAME WindowsStore)
#set(CMAKE_SYSTEM_VERSION 10.0)
project(Deps)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

IF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/Bin CACHE PATH "Directory for sbnw installation" FORCE)
ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

set(ZLIB_COMPAT ON)
set(VULKAN ON)
set(DX11 ON)
set(DX12 ON)
set(BUILD_GMOCK OFF)
set(BUILD_MODULE OFF) #luv
set(BUILD_SHARED_LIBS ON) #luv

set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)

#if(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
#WINAPI_FAMILY=WINAPI_FAMILY_DESKTOP_APP

#add_subdirectory(cmake/The-Forge)
add_subdirectory(luv)
#add_subdirectory(zlib-ng)


