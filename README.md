# CPPGEN

## Overview

This project contains a shellscript for autogenerating c++ project skeletons as well as an example with the output of running the script.

## Getting started

### Installing

Simply clone the repo onto your machine using `git clone https://github.com/cnmorgan/cppgen`

Then you can free use `cppgen.sh` to generate project skeletons.

### Usage

There are a couple of commands that can be used with cppgen:

`cppgen (project | p ) (project_name)` will generate a project skeleton in the current directory with the name given.
<<<<<<< HEAD
`cppgen (subdir  | sd) (subdir_name)` will generate a subdirectory for the current project.
=======

`cppgen (subdir  | sd) (subdir_name)` will generate a subdirectory in the current directory. This is meant to be used in the `/libs` directory of the project.

>>>>>>> 2bb035baaed31f27f19474c8108b48b85d59e25c
`cppgen (class   | c ) (class_name)` will generate a `(class_name).hpp` file in `src/headers` and also a `(class_name).cpp` file in `/src`. This command should be used in the root
directory of the project.
