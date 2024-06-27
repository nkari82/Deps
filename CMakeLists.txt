cmake_minimum_required(VERSION 3.15)
project(Deps)

IF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  SET(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/Bin CACHE PATH "Directory for sbnw installation" FORCE)
ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

set(ZLIB_COMPAT TRUE)
set(VULKAN TRUE)
set(BUILD_GMOCK FALSE)

add_subdirectory(cmake/The-Forge)
#add_subdirectory(zlib-ng)
