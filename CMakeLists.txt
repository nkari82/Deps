cmake_minimum_required(VERSION 3.15)
project(Deps)

set(ZLIB_COMPAT TRUE)
set(VULKAN TRUE)
set(BUILD_GMOCK FALSE)

add_subdirectory(cmake/The-Forge)
#add_subdirectory(zlib-ng)
