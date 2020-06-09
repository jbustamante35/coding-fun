# define version number
cmake_minimum_required(VERSION 2.6)
project(TestCMake)

set (TestCMake_VERSION_MAJOR 1)
set (TestCMake_VERSION_MINOR 0)

# configure header file to pass CMake settings to source code
configure_file(
    "${PROJECT_SOURCE_DIR}/TestCMakeConfig.h.in"
    "${PROJECT_BINARY_DIR}/TestCMakeConfig.h"
)

# add binary tree to search path for include files
include_directories("${PROJECT_BINARY_DIR}")

# add executable
add_executable(TestCMake testcmake.cxx)

