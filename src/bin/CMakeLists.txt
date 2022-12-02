add_executable(toluapp_bootstrap
    tolua.cpp
    toluabind_default.c
)
target_link_libraries(toluapp_bootstrap
    toluapp_lib
  )

file(GLOB
    LUA_FILES
    RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}/lua
    all.lua array.lua basic.lua class.lua clean.lua code.lua compat.lua
    compat-5.1.lua container.lua custom.lua declaration.lua define.lua doit.lua
    enumerate.lua feature.lua function.lua module.lua namespace.lua operator.lua
    package.lua template_class.lua typedef.lua variable.lua verbatim.lua
  )

add_custom_command(
    OUTPUT toluabind.c
    COMMAND toluapp_bootstrap -C -o ${CMAKE_CURRENT_BINARY_DIR}/toluabind.c tolua.pkg
    DEPENDS toluapp_bootstrap tolua.pkg ${LUA_FILES}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  )

add_executable(
    toluapp
    tolua.cpp
    toluabind.c
  )
set_property(TARGET toluapp PROPERTY CXX_STANDARD 20)
target_link_libraries(toluapp
    toluapp_lib
  )
install(TARGETS
    toluapp
  )