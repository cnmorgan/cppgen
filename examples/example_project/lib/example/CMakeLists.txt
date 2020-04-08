cmake_minimum_required(VERSION 3.1)

# include files
# TODO: Add 3rd party includes here e.g. ./lib/LIB_NAME/include
include_directories(./include)

# Create target
# TODO: Add any files to be compiled
add_library(example STATIC ./src/example.cpp)

# Add any link dependencies
#add_subdirectory(lib/LIBRARY_NAME)
#target_link_libraries(example PUBLIC | PRIVATE | INTERFACE LIBRARY_NAME)
