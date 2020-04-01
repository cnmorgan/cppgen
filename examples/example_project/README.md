# example_project

## CPPGEN

This project has been bootstrapped using cppgen!

## File structure

```
example_project
|
+--app
+--bin
+--docs
+--examples
+--include
|  +--example_project
|  |  +--example.hpp
+--libs
|  +--docs
|  +--include
|  |  +--example
|  |  |  +--example.hpp
|  +--libs
|  +--src
|  |  +--example.cpp
|  +--CMakeLists.txt
+--src
|  +--example.cpp
+--tests
+--.gitignore
+--CMakeLists.txt
```

### /app

Use this directory to house the source code for an executable (if you need one)

### /bin

Use this directory for any shell scripts you need to use along with your library/app

### /docs

This is where you can put any additonal documentation for you project

### /examples

Put example code demonstrating the use of your project here.

### /include/example_project

Put any public header files in this directory.

### /libs

Use this directory for any third party libraries you want to use in your project

### /src

Use this directory for the actual source code of your project along with any private header files

### /tests

Use this directory to house your tests. The script defaults to using catch2

## TODO

in the  directory execute the following commands:

```
mkdir build
cd build
cmake ..
make
./main
```

You should see the output of the sample code. This means that everthing was set up correctly.

You should look through the example files given to get an idea of the organization of the project. You should also make sure to look at the CMakeLists.txt to see what you will need
to change as your project grows and new files and/or modules are added.

After you have made sure you understand the structure of this project, remove all of the sample code and you can begin adding to your project.
