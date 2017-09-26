
# Specify the minimum version for CMake
cmake_minimum_required(VERSION 3.5.1)

#add necessary flags to build passes out-of-source
add_definitions(-Wall -fno-rtti)

# Project's name
project(OXiGen)

find_package(LLVM REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "LLVM include dirs: ${LLVM_INCLUDE_DIRS}")
message(STATUS "LLVM Definitions: ${LLVM_DEFINITIONS}")

set(INCLUDE_DIR "${PROJECT_SOURCE_DIR}/include")
set(SOURCES_DIR "${PROJECT_SOURCE_DIR}/src")

set(CMAKE_C_COMPILER "/usr/bin/clang")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++")
set(CMAKE_CXX_STANDARD "11")

include_directories(${LLVM_INCLUDE_DIRS} ${INCLUDE_DIR})
add_definitions(${LLVM_DEFINITIONS})

file (GLOB SOURCES
        ${INCLUDE_DIR}/*.h
        ${INCLUDE_DIR}/*/*.h
        ${SOURCES_DIR}/*.cpp
        )

# The executable to build
add_executable(main ${SOURCES})

# Set the path for binaries
set( EXECUTABLE_OUTPUT_PATH "${PROJECT_SOURCE_DIR}/bin" )

# Build a compilation database for YouCompleteMe
set( CMAKE_EXPORT_COMPILE_COMMANDS ON )

# Find the libraries that correspond to the LLVM components
# that we wish to use
llvm_map_components_to_libnames(llvm_libs support core passes)

message(STATUS "LLVM Libraries: ${llvm_libs}")


# Link against LLVM libraries
target_link_libraries(main ${llvm_libs})

# LLVM Flags
#execute_process(COMMAND llvm-config --cxxflags OUTPUT_VARIABLE LLVM_CXXFLAGS)
#execute_process(COMMAND llvm-config --ldflags --libs --system-libs OUTPUT_VARIABLE LLVM_LDFLAGS)


#set( CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} ${LLVM_CXXFLAGS} ${LLVM_LDFLAGS})

# Link Clang/LLVM dynamic libraries
#target_link_libraries(full_visitor ${CLANG_LIBS})
#target_link_libraries(bb_toposort_sccs ${CLANG_LIBS} )
