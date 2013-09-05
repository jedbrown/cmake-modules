# CorrectWindowsPaths - this module defines one macro
#
# CONVERT_CYGWIN_PATH( PATH )
#  This uses the command cygpath (provided by cygwin) to convert
#  unix-style paths into paths useable by cmake on windows

macro (CONVERT_CYGWIN_PATH _path)

# Some cygwin utilities (namely make) do not like DOS paths, but are happy with UNIX paths
# On the other hand out of the cygwin, the cygpath tool doesn't need to be available.

  if (WIN32 AND NOT CYGWIN)
    EXECUTE_PROCESS(COMMAND cygpath.exe -m ${${_path}}
      OUTPUT_VARIABLE ${_path})
    string (STRIP ${${_path}} ${_path})
  endif (WIN32 AND NOT CYGWIN)
endmacro (CONVERT_CYGWIN_PATH)

