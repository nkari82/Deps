cmake_minimum_required(VERSION 3.15)
#set(CMAKE_SYSTEM_NAME WindowsStore)
#set(CMAKE_SYSTEM_VERSION 10.0)
project(Deps)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

IF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/Bin CACHE PATH "Directory for sbnw installation" FORCE)
ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

set(CMAKE_INSTALL_INCLUDEDIR "include")

set(ZLIB_COMPAT ON) #the-forge
set(VULKAN ON) # the-forge
set(DX11 ON) # the-forge
set(DX12 ON) # the-forge
set(LUAJIT_DIR ${CMAKE_SOURCE_DIR}/LuaJIT)
#set(BUILD_GMOCK OFF) #luv
#set(BUILD_MODULE OFF) #luv
#set(BUILD_SHARED_LIBS ON) #luv


#if(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
#WINAPI_FAMILY=WINAPI_FAMILY_DESKTOP_APP

add_subdirectory(cmake/The-Forge)
#set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)
#add_subdirectory(luv)
#set(CMAKE_POLICY_DEFAULT_CMP0077 OLD)
#add_subdirectory(zlib-ng)

#set(CMAKE_POLICY_DEFAULT_CMP0077 NEW)
#add_subdirectory(luajit-cmake)
#set(CMAKE_POLICY_DEFAULT_CMP0077 OLD)
#add_subdirectory(Lumo)

# unused
#install(TARGETS luajit-5.1 DESTINATION lib)
#install(
#	FILES 
#	${CMAKE_SOURCE_DIR}/luv/deps/luajit/src/lua.h
#	${CMAKE_SOURCE_DIR}/luv/deps/luajit/src/lauxlib.h
#	${CMAKE_SOURCE_DIR}/luv/deps/luajit/src/lualib.h
#	${CMAKE_SOURCE_DIR}/luv/deps/luajit/src/luajit.h
#	${CMAKE_SOURCE_DIR}/luv/deps/luajit/src/lua.hpp
#	DESTINATION include/lua)
	

