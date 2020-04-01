cmake_minimum_required(VERSION 3.1)

include(CTest)

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

# Create Library
add_library(${TARGET_NAME} ${SOURCES})

# include files
# TODO: Add 3rd party includes here e.g. ./libs/LIB_NAME/include
target_include_directories(${TARGET_NAME} ./include ./libs/example/include)

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
add_subdirectory(libs/example)
target_link_libraries(${TARGET_NAME} PUBLIC example)
