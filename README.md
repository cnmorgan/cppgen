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

`cppgen (subdir  | sd) (subdir_name)` will generate a subdirectory for the current project.

`cppgen (class   | c ) (class_name)` will generate a `(class_name).hpp` file in `src/headers` and also a `(class_name).cpp` file in `/src`. This command should be used in the root directory of the project.

`cppgen (template   | t ) (template_name)` will generate a `(template_name).hpp` file in `include/(project_name)` and also a `(template_name).tcc` file in `include/(project_name)/templates`. This command should be used in the root directory of the project.
