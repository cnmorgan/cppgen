cmake_minimum_required(VERSION 3.1)

#-----------------#
# CMake Variables #
#-----------------#

set(TARGET_NAME example_project)

# Add all src/*.cpp files
set(SOURCES
    src/example.cpp
)

# Add all tests/*.cpp files
set(TEST_SOURCES
    tests/main.cpp
)

project(${TARGET_NAME} VERSION 1.0.0 LANGUAGES CXX)

include(CTest)

# Create Library
add_library(${TARGET_NAME} ${SOURCES})

# include files
# TODO: Add 3rd party includes here e.g. ./lib/LIB_NAME/include
target_include_directories(${TARGET_NAME} PUBLIC ./include PUBLIC ./lib/example/include)

# Create Executable (if applicatble)
add_executable(main app/main.cpp)
target_link_libraries(main PRIVATE ${TARGET_NAME})

# Create executable for tests (Catch2 by default)
add_executable(tests ${TEST_SOURCES})

target_include_directories(tests PRIVATE ./include)

add_test(NAME tests COMMAND tests)
enable_testing()

# external libraries
# TODO: Add library references when needed
add_subdirectory(lib/example)
target_link_libraries(${TARGET_NAME} PUBLIC example)
