set(IMGUI_DIR ${CMAKE_SOURCE_DIR}/imgui)

set(IMGUI_FILES
    ${IMGUI_DIR}/imconfig.h
    ${IMGUI_DIR}/imgui_demo.cpp
    ${IMGUI_DIR}/imgui_draw.cpp
    ${IMGUI_DIR}/imgui_internal.h
    ${IMGUI_DIR}/imgui_widgets.cpp
    ${IMGUI_DIR}/imgui_tables.cpp
    ${IMGUI_DIR}/imgui.cpp
    ${IMGUI_DIR}/imgui.h)	
add_library(Imgui STATIC ${IMGUI_FILES})