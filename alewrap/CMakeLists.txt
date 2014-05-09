CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
CMAKE_POLICY(VERSION 2.6)

FILE(GLOB src *.cpp *.hpp *.h)
FILE(GLOB luasrc *.lua)
SET(luasrc ${luasrc} alewrap_core.h)

MESSAGE(STATUS "${CMAKE_INSTALL_PREFIX}")

# We are building alewraplib.
# We specify the paths to ALE includes and libale.
find_path(ALE_INCLUDE_DIR ale_interface.hpp
    HINTS ${TORCH_INSTALL_PREFIX}/include ${CMAKE_INSTALL_PREFIX}/../../../../../include ${LUAROCKS_INSTALL_PREFIX}/../../../../../include
          PATH_SUFFIXES ale )

find_library(ALE_LIBRARY NAMES ale libale
    HINTS ${TORCH_INSTALL_PREFIX}/lib ${CMAKE_INSTALL_PREFIX}/../../../../../lib ${LUAROCKS_INSTALL_PREFIX}/../../../../../lib)

IF(ALE_INCLUDE_DIR-NOTFOUND)
    MESSAGE(ERROR "Could not find ALE include location")
ENDIF()

IF(ALE_LIBRARY-NOTFOUND)
    MESSAGE(ERROR "Could not find ALE library")
ENDIF()

MESSAGE(STATUS "INCLUDES ${ALE_INCLUDE_DIR}")
MESSAGE(STATUS "LIBS ${ALE_LIBRARY}")

set(ALE_LIBRARIES ${ALE_LIBRARY} )
set(ALE_INCLUDE_DIRS ${ALE_INCLUDE_DIR} )

INCLUDE_DIRECTORIES("${ALE_INCLUDE_DIRS}")
LINK_DIRECTORIES("${ALE_LIBRARIES}")

ADD_TORCH_PACKAGE(alewrap "${src}" "${luasrc}" "ALE Wrapper")
TARGET_LINK_LIBRARIES(alewrap ${ALE_LIBRARY} z)
