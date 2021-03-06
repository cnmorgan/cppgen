#!/bin/bash

#-----------#
# Constants #
#-----------#

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

#-----------------------------------#
# Helper Echo Functions             #
#-----------------------------------#

echo_red() {
  printf "$RED$1$NC\n"
}

echo_green() {
  printf "$GREEN$1$NC\n"
}

echo_yellow() {
  printf "$YELLOW$1$NC\n"
}

#---------------------------#
# File Helper Functions     #
#---------------------------#

example_cmake() {
  cat <<EOF >>CMakeLists.txt
cmake_minimum_required(VERSION 3.1)

#-----------------#
# CMake Variables #
#-----------------#

set(TARGET_NAME $PROJECT_NAME)

# Add all src/*.cpp files
set(SOURCES
    src/example.cpp
)

# Add all tests/*.cpp files
set(TEST_SOURCES
    tests/main.cpp
)
EOF

  cat <<'EOF' >>CMakeLists.txt

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
EOF
}

empty_cmake() {
  cat <<EOF >>CMakeLists.txt
cmake_minimum_required(VERSION 3.1)

#-----------------#
# CMake Variables #
#-----------------#

set(TARGET_NAME $PROJECT_NAME)

# Add all src/*.cpp files
set(SOURCES
)

# Add all tests/*.cpp files
set(TEST_SOURCES
    tests/main.cpp
)
EOF

  cat <<'EOF' >>CMakeLists.txt

project(${TARGET_NAME} VERSION 1.0.0 LANGUAGES CXX)

include(CTest)

# Create Library
add_library(${TARGET_NAME} ${SOURCES})

# include files
# TODO: Add 3rd party includes here e.g. ./lib/LIB_NAME/include
target_include_directories(${TARGET_NAME} PUBLIC ./include )

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
EOF
}

readme() {
  cat <<EOF >README.md
# $PROJECT_NAME

## CPPGEN

This project has been bootstrapped using cppgen!

## File structure

\`\`\`
$PROJECT_NAME
|
+--app
+--bin
+--docs
+--examples
+--include
|  +--$PROJECT_NAME
|  |  +--example.hpp
+--lib
|  +--docs
|  +--include
|  |  +--example
|  |  |  +--example.hpp
|  +--lib
|  +--src
|  |  +--example.cpp
|  +--CMakeLists.txt
+--src
|  +--example.cpp
+--tests
+--.gitignore
+--CMakeLists.txt
\`\`\`

### /app

Use this directory to house the source code for an executable (if you need one)

### /bin

Use this directory for any shell scripts you need to use along with your library/app

### /docs

This is where you can put any additonal documentation for you project

### /examples

Put example code demonstrating the use of your project here.

### /include/$PROJECT_NAME

Put any public header files in this directory.

### /lib

Use this directory for any third party libraries you want to use in your project

### /src

Use this directory for the actual source code of your project along with any private header files

### /tests

Use this directory to house your tests. The script defaults to using catch2

## TODO

in the $($PROJECT_NAME) directory execute the following commands:

\`\`\`
mkdir build
cd build
cmake ..
make
./main
\`\`\`

You should see the output of the sample code. This means that everthing was set up correctly.

You should look through the example files given to get an idea of the organization of the project. You should also make sure to look at the CMakeLists.txt to see what you will need
to change as your project grows and new files and/or modules are added.

After you have made sure you understand the structure of this project, remove all of the sample code and you can begin adding to your project.
EOF
}

example_main() {
  cat <<EOF >main.cpp
#include <$PROJECT_NAME/example.hpp>
#include <example/example.hpp>

int main(){
  Example::foo();
  SubExample::foo();
};
EOF
}

empty_main() {
  cat <<EOF >main.cpp
int main(){
  return 0;
};
EOF
}
#---------------------------#
# Generate Project Function #
#---------------------------#

gen_project() {

  PROJECT_NAME=$1
  shift

  EXAMPLE="false"

  while [ "$1" != "" ]; do
    case $1 in
    --example | -e)
      EXAMPLE="true"
      ;;
    *)
      echo_red "ERROR: flag $1 unrecognized"
      exit 1
      ;;
    esac
    shift
  done

  if [ "$PROJECT_NAME" == "" ]; then
    echo_red "ERROR: project name required"
    exit 1
  fi

  echo "Generating project $PROJECT_NAME..."

  mkdir $PROJECT_NAME

  echo_green "created $PROJECT_NAME/"

  cd $PROJECT_NAME

  touch CMakeLists.txt

  if [ "$EXAMPLE" == "true" ]; then
    example_cmake
  else
    empty_cmake
  fi

  echo_green "created $PROJECT_NAME/CMakeLists.txt"

  touch .gitignore

  echo "/build" >.gitignore

  echo_green "created $PROJECT_NAME/.gitignore"

  readme

  echo_green "created $PROJECT_NAME/README.md"

  mkdir bin

  echo_green "created $PROJECT_NAME/bin/"

  mkdir build

  echo_green "created $PROJECT_NAME/build/"

  mkdir include

  echo_green "created $PROJECT_NAME/include/"

  mkdir include/$PROJECT_NAME

  echo_green "created $PROJECT_NAME/include/$PROJECT_NAME/"

  cd include/$PROJECT_NAME

  if [ "$EXAMPLE" == "true" ]; then
    cat <<EOC >example.hpp
#include<iostream>

class Example{
  public:
    static void foo();
};

EOC

    echo_green "created $PROJECT_NAME/include/$PROJECT_NAME/example.hpp"

  fi

  mkdir templates

  echo_green "created $PROJECT_NAME/include/$PROJECT_NAME/templates"

  cd ../../

  mkdir src

  echo_green "created $PROJECT_NAME/src/"

  cd src

  if [ "$EXAMPLE" == "true" ]; then

    cat <<EOF >example.cpp
#include <$PROJECT_NAME/example.hpp>

void Example::foo(){
  std::cout << "Hello World!" << std::endl;
};
EOF

    echo_green "created $PROJECT_NAME/src/example.cpp"

  fi

  mkdir headers

  echo_green "created $PROJECT_NAME/src/headers/"

  cd ../

  mkdir app

  echo_green "created $PROJECT_NAME/app/"

  cd app

  if [ "$EXAMPLE" == "true" ]; then
    example_main
  else
    empty_main
  fi

  echo_green "created $PROJECT_NAME/app/main.cpp"

  cd ../

  mkdir tests

  echo_green "created $PROJECT_NAME/tests/"

  cd tests

  cat <<EOF >main.cpp
#define CATCH_CONFIG_MAIN
#include <catch2/catch.hpp>

/* This file is the main testing entrypoint
 * Do not put tests in this file.
 * To add new tests, make other *.cpp files in this directory
 * adding #include<catch2/catch.hpp> to the top as well as
 * any other needed includes and preprocessor statements.
 *
 * finally, add any new files to the CMakeLists.txt file.
 */
EOF

  echo_green "created $PROJECT_NAME/tests/main.cpp"

  cd ../

  mkdir examples

  echo_green "created $PROJECT_NAME/examples/"

  mkdir docs

  echo_green "created $PROJECT_NAME/docs/"

  mkdir lib

  echo_green "created $PROJECT_NAME/lib/"

  if [ "$EXAMPLE" == "true" ]; then
    gen_subdir example
  fi
}

gen_subdir() {

  NAME=$1
  PROJECT_NAME="$(basename "lib/$NAME")"

  if [ "$NAME" == "" ]; then
    echo_red "ERROR subdir Name is required"
  fi

  cd lib

  mkdir $NAME

  echo_green "Created lib/$NAME/"

  cd $NAME

  cat <<EOF >CMakeLists.txt
cmake_minimum_required(VERSION 3.1)

# include files
# TODO: Add 3rd party includes here e.g. ./lib/LIB_NAME/include
include_directories(./include)

# Create target
# TODO: Add any files to be compiled
add_library($NAME STATIC ./src/$NAME.cpp)

# Add any link dependencies
#add_subdirectory(lib/LIBRARY_NAME)
#target_link_libraries($NAME PUBLIC | PRIVATE | INTERFACE LIBRARY_NAME)
EOF

  echo_green "Created lib/$NAME/CMakeLists.txt"

  mkdir include

  echo_green "Created lib/$NAME/include/"

  cd include

  mkdir $NAME

  cd $NAME

  if [ "$NAME" == "example" ]; then
    cat <<EOC >$NAME.hpp
#include <iostream>

class SubExample{
  public:
    static void foo();
};

EOC
  else
    touch $NAME.hpp
  fi

  cd ../../

  mkdir src

  echo_green "Created lib/$NAME/src/"

  cd src

  if [ "$NAME" == "example" ]; then
    cat <<EOC >$NAME.cpp
#include <$NAME/$NAME.hpp>

void SubExample::foo() {
  std::cout << "Hello from a sub-directory!" << std::endl;
}
EOC
  else
    touch $NAME.cpp
  fi

  cd ../

  mkdir docs

  echo_green "Created lib/$NAME/docs/"

  mkdir lib

  echo_green "Created lib/$NAME/lib/"

}

gen_class() {
  CLASS_NAME=$1
  shift

  PROJECT_NAME="$(basename "$PWD")"
  ADD_TESTS=false
  SCOPE='private'

  while [ "$1" != "" ]; do
    case $1 in
    --test | -t)
      ADD_TESTS=true
      ;;
    --public | -p)
      SCOPE='public'
      ;;
    --api | -a)
      SCOPE='api'
      ;;
    *)
      echo_red "ERROR: flag $1 unrecognized"
      exit 1
      ;;
    esac
    shift
  done

  if [ "$CLASS_NAME" == "" ]; then
    echo_red "ERROR: Class name cannot be blank"
    exit 1
  fi

  cat <<EOC >src/$CLASS_NAME.cpp
#include "headers/$CLASS_NAME.hpp"

EOC

  echo_green "Created src/$CLASS_NAME.cpp"

  if [ $SCOPE != "public" ]; then
    cat <<EOC >src/headers/$CLASS_NAME.hpp
#pragma once

class $CLASS_NAME {
  private:
    //Code here
  public:
    //Code here
};
EOC

    echo_green "Created src/headers/$CLASS_NAME.hpp"
  fi

  if [ $SCOPE != "private" ]; then
    cat <<EOC >include/$PROJECT_NAME/$CLASS_NAME.hpp
#pragma once

class $CLASS_NAME {  
  private:
    //Code here
  public:
    //Code here
};
EOC

    echo_green "Created include/$PROJECT_NAME/$CLASS_NAME.hpp"
  fi

  if [ "$ADD_TESTS" == true ]; then
    cat <<EOC >tests/$CLASS_NAME.cpp
#include <catch2/catch.hpp>

TEST_CASE("$CLASS_NAME", "[$CLASS_NAME]"){
  //add tests
  REQUIRE(1 == 2);
}
EOC

    echo_green "Created tests/$CLASS_NAME.cpp"
  fi
}

gen_template() {
  TEMPLATE_NAME=$1
  shift

  PROJECT_NAME="$(basename "$PWD")"
  ADD_TESTS=false

  if [ "$TEMPLATE_NAME" == "" ]; then
    echo_red "ERROR: Template name cannot be blank"
    exit 1
  fi

  while [ "$1" != "" ]; do
    case $1 in
    --test | -t)
      ADD_TESTS=true
      ;;
    *)
      echo_red "ERROR: flag $1 unrecognized"
      exit 1
      ;;
    esac
    shift
  done

  cat <<EOC >include/$PROJECT_NAME/templates/$TEMPLATE_NAME.tcc
#include <$PROJECT_NAME/$TEMPLATE_NAME.hpp>

//TODO: Add implementation code
EOC

  echo_green "Created include/$PROJECT_NAME/templates/$TEMPLATE_NAME.tcc"

  cat <<EOC >include/$PROJECT_NAME/$TEMPLATE_NAME.hpp
#pragma once

template <typename T>
class $TEMPLATE_NAME{
  private:
    //Add private fields
  public:
    //Add public fields
};

#include "templates/$TEMPLATE_NAME.tcc"
EOC

  echo_green "Created include/$PROJECT_NAME/$TEMPLATE_NAME.hpp"

  if [ "$ADD_TESTS" == true ]; then
    cat <<EOC >tests/$TEMPLATE_NAME.cpp
#include <catch2/catch.hpp>

TEMPLATE_TEST_CASE("$TEMPLATE_NAME", "[$TEMPLATE_NAME][Template]", int){
  //add tests
  REQUIRE(1 == 2);
}
EOC

    echo_green "Created tests/$TEMPLATE_NAME.cpp"
  fi

}

#-------------#
# Main script #
#-------------#

if [ $# == 0 ]; then
  echo "command required"
  echo "cppgen"
  echo "       project    | p  [project_name]"
  echo "       subdir     | sd [subdir_name]"
  echo "       class      | c  [class_name]    [Flags]"
  echo "       template   | t  [tempalte_name] [Flags]"
  exit 0
fi

while [ "$1" != "" ]; do
  case $1 in
  project | p)
    shift
    gen_project "$@"
    exit 0
    ;;
  subdir | sd)
    shift
    gen_subdir "$@"
    exit 0
    ;;
  class | c)
    shift
    gen_class "$@"
    exit 0
    ;;
  template | t)
    shift
    gen_template "$@"
    exit 0
    ;;
  *)
    echo_red "ERROR: flag $1 unrecognized"
    exit 1
    ;;
  esac
  shift
done
