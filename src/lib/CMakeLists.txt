find_package(PkgConfig REQUIRED)
pkg_check_modules(LUA REQUIRED IMPORTED_TARGET lua)

message(STATUS "LUA_FOUND = ${LUA_FOUND}")
message(STATUS "LUA_VERSION = ${LUA_VERSION}")
message(STATUS "LUA_PREFIX = ${LUA_PREFIX}")
message(STATUS "LUA_INCLUDEDIR = ${LUA_INCLUDEDIR}")
message(STATUS "LUA_LIBDIR = ${LUA_LIBDIR}")

add_library(
    toluapp_lib SHARED
    tolua_event.c
    tolua_is.c
    tolua_map.c
    tolua_push.c
    tolua_to.c
  )
set_target_properties(toluapp_lib PROPERTIES OUTPUT_NAME toluapp)
set_target_properties(toluapp_lib PROPERTIES PUBLIC_HEADER ${PROJECT_SOURCE_DIR}/include/tolua++.h)
set_target_properties(toluapp_lib PROPERTIES VERSION ${PROJECT_VERSION})
target_include_directories(toluapp_lib PUBLIC
    ${LUA_INCLUDE_DIRS}
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
  )
target_compile_options(toluapp_lib PRIVATE
    ${LUA_CFLAGS_OTHER}
  )
target_link_libraries(toluapp_lib PUBLIC
    PkgConfig::LUA
  )
target_link_options(toluapp_lib PRIVATE
    ${LUA_LDFLAGS_OTHER}
  )
install(TARGETS toluapp_lib
    EXPORT toluapp-targets
    PUBLIC_HEADER
  )

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/toluapp-config-version.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
  )

export(EXPORT toluapp-targets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/toluapp-targets.cmake"
    NAMESPACE toluapp::
  )
configure_file(cmake/toluapp-config.cmake
    "${CMAKE_CURRENT_BINARY_DIR}/toluapp-config.cmake"
    COPYONLY
  )

set(ConfigPackageLocation lib/cmake/toluapp)
install(EXPORT toluapp-targets
    FILE toluapp-targets.cmake
    NAMESPACE toluapp::
    DESTINATION ${ConfigPackageLocation}
  )
install(
    FILES
        cmake/toluapp-config.cmake
        "${CMAKE_CURRENT_BINARY_DIR}/toluapp-config-version.cmake"
    DESTINATION ${ConfigPackageLocation}
)
