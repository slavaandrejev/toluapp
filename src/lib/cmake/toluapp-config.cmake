find_package(PkgConfig REQUIRED)
pkg_check_modules(LUA REQUIRED IMPORTED_TARGET lua)

include("${CMAKE_CURRENT_LIST_DIR}/toluapp-targets.cmake")
message(STATUS "Found toluapp")
