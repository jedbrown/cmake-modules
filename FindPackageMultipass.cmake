# PackageMultipass - this module defines one function
#
# FIND_PACKAGE_MULTIPASS (Name CURRENT
#  STATES VAR0 VAR1 ...
#  DEPENDENTS DEP0 DEP1 ...)

#  This function creates a cache entry <UPPERCASED-Name>_CURRENT which
#  the user can set to "NO" to trigger a reconfiguration of the package.
#  The first time this function is called, the values of
#  <UPPERCASED-Name>_VAR0, ... are saved.  If <UPPERCASED-Name>_CURRENT
#  is false or if any STATE has changed since the last time
#  FIND_PACKAGE_MULTIPASS() was called, then CURRENT will be set to "NO",
#  otherwise CURRENT will be "YES".  IF not CURRENT, then
#  <UPPERCASED-Name>_DEP0, ... will be FORCED to NOTFOUND.
#  Example:
#    find_path (FOO_DIR include/foo.h)
#    FIND_PACKAGE_MULTIPASS (Foo foo_current
#      STATES DIR
#      DEPENDENTS INCLUDES LIBRARIES)
#    if (NOT foo_current)
#      # Make temporary files, run programs, etc, to determine FOO_INCLUDES and FOO_LIBRARIES
#    endif (NOT foo_current)
#      

macro (FIND_PACKAGE_MULTIPASS _name _current)
  string (TOUPPER ${_name} _NAME)
  set (_args ${ARGV})
  list (REMOVE_AT _args 0 1)

  set (_states_current "YES")
  list (GET _args 0 _cmd)
  if (_cmd STREQUAL "STATES")
    list (REMOVE_AT _args 0)
    list (GET _args 0 _state)
    while (_state AND NOT _state STREQUAL "DEPENDENTS")
      # The name of the stored value for the given state
      set (_stored_var PACKAGE_MULTIPASS_${_NAME}_${_state})
      if (NOT "${${_stored_var}}" STREQUAL "${${_NAME}_${_state}}")
	set (_states_current "NO")
      endif (NOT "${${_stored_var}}" STREQUAL "${${_NAME}_${_state}}")
      set (${_stored_var} "${${_NAME}_${_state}}" CACHE INTERNAL "Stored state for ${_name}." FORCE)
      list (REMOVE_AT _args 0)
      list (GET _args 0 _state)
    endwhile (_state AND NOT _state STREQUAL "DEPENDENTS")
  endif (_cmd STREQUAL "STATES")

  set (_stored ${_NAME}_CURRENT)
  if (NOT ${_stored})
    set (${_stored} "YES" CACHE BOOL "Is the configuration for ${_name} current?  Set to \"NO\" to reconfigure." FORCE)
    set (_states_current "NO")
  endif (NOT ${_stored})

  set (${_current} ${_states_current})
  if (NOT ${_current})
    message (STATUS "Clearing ${_name} dependent variables")
    # Clear all the dependent variables so that the module can reset them
    list (GET _args 0 _cmd)
    if (_cmd STREQUAL "DEPENDENTS")
      list (REMOVE_AT _args 0)
      foreach (dep ${_args})
	set (${_NAME}_${dep} "NOTFOUND" CACHE INTERNAL "Cleared" FORCE)
      endforeach (dep)
    endif (_cmd STREQUAL "DEPENDENTS")
  endif (NOT ${_current})
endmacro (FIND_PACKAGE_MULTIPASS)
