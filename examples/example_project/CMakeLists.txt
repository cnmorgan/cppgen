cmake_minimum_required(VERSION 3.1)

#-----------------#
# CMake Variables #
#-----------------#

set(TARGET_NAME helloworld)

# Add all src/*.cpp files
set(SOURCES
    src/example.cpp
)

project(${TARGET_NAME} VERSION 1.0.0 LANGUAGES CXX)

# include files
# TODO: Add 3rd party includes here e.g. ./libs/LIB_NAME/include
include_directories(./include ./libs/example/include)

# Create Library
add_library(${TARGET_NAME} ${SOURCES})

# Create Executable
add_executable(main app/main.cpp)
target_link_libraries(main PRIVATE ${TARGET_NAME})

# external libraries
# TODO: Add library references when needed
add_subdirectory(libs/example)
target_link_libraries(${TARGET_NAME} PUBLIC example)
