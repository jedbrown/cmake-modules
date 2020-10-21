A collection of CMake modules, which can mostly be used independently.

The utilities for writing robust Find* modules might be useful until
CMake takes static libraries and multiple active configurations
seriously.  See [Improving Find* Modules](https://gitlab.kitware.com/cmake/community/-/wikis/doc/cmake/dev/Improving-Find*-Modules).

**Note for PETSc users**: please consider using [FindPkgConfig](https://cmake.org/cmake/help/latest/module/FindPkgConfig.html) instead of `FindPETSc.cmake` from this package.  PETSc has distributed `petsc.pc` for use by [pkg-config](https://www.freedesktop.org/wiki/Software/pkg-config/) since PETSc 3.4 and some corner cases were fixed in 3.12.  Use of the provided `petsc.pc` is simpler for you distributing your package (only requires CMake default modules) and for us to maintain, especially when distributions modify the installation schema (so there is no `PETSC_DIR`).
