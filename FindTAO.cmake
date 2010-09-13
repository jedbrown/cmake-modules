# - Try to find TAO
#

find_path (TAO_DIR include/tao.h HINTS ENV TAO_DIR PATHS $ENV{HOME}/tao DOC "Tao Directory")

IF(EXISTS ${TAO_DIR}/include/tao.h)
  SET(TAO_FOUND YES)
  SET(TAO_INCLUDES ${TAO_DIR})
  find_path (TAO_INCLUDE_DIR tao.h HINTS "${TAO_DIR}" PATH_SUFFIXES include NO_DEFAULT_PATH)
  list(APPEND TAO_INCLUDES ${TAO_INCLUDE_DIR})
  find_path (TAO_FINCLUDE_DIR tao_general.h HINTS "${TAO_INCLUDE_DIR}" PATH_SUFFIXES finclude NO_DEFAULT_PATH)
  list(APPEND TAO_INCLUDES ${TAO_FINCLUDE_DIR})
  FILE(GLOB TAO_LIBRARIES RELATIVE "${TAO_DIR}/lib" "${TAO_DIR}/lib/libtao*.a")
ELSE(EXISTS ${TAO_DIR}/include/tao.h)
  SET(TAO_FOUND No)
ENDIF(EXISTS ${TAO_DIR}/include/tao.h)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(TAO DEFAULT_MSG TAO_LIBRARIES TAO_INCLUDES)