set(THE_FORGE_DIR ../../The-Forge)
set(THIRD_PARTY_GRAPHIS_DIR ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource)
set(THIRD_PARTY_OS_DIR ${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource)


add_library(WinPixEventRuntime SHARED IMPORTED)
set_property(TARGET WinPixEventRuntime PROPERTY IMPORTED_LOCATION
        ${THIRD_PARTY_OS_DIR}/winpixeventruntime/bin/WinPixEventRuntime.dll
        )
set_property(TARGET WinPixEventRuntime PROPERTY IMPORTED_IMPLIB
        ${THIRD_PARTY_OS_DIR}/winpixeventruntime/bin/WinPixEventRuntime.lib
        )

add_library(AGS SHARED IMPORTED)
set_property(TARGET AGS PROPERTY IMPORTED_LOCATION
        ${THIRD_PARTY_GRAPHIS_DIR}/ags/ags_lib/lib/amd_ags_x64.dll
        )
set_property(TARGET AGS PROPERTY IMPORTED_IMPLIB
        ${THIRD_PARTY_GRAPHIS_DIR}/ags/ags_lib/lib/amd_ags_x64.lib
        )
target_include_directories(AGS INTERFACE ${THIRD_PARTY_GRAPHIS_DIR}/ags)


add_library(Nvapi STATIC IMPORTED)
set_property(TARGET Nvapi PROPERTY IMPORTED_LOCATION
        ${THIRD_PARTY_GRAPHIS_DIR}/nvapi/amd64/nvapi64.lib
        )
target_include_directories(Nvapi INTERFACE ${THIRD_PARTY_GRAPHIS_DIR}/nvapi)


add_library(DirectXShaderCompiler STATIC IMPORTED)
set_property(TARGET DirectXShaderCompiler PROPERTY IMPORTED_LOCATION
        ${THIRD_PARTY_GRAPHIS_DIR}/DirectXShaderCompiler/lib/x64/dxcompiler.lib
        )

add_library(VulkanMemoryAllocator INTERFACE)
target_include_directories(VulkanMemoryAllocator INTERFACE
        ${THIRD_PARTY_GRAPHIS_DIR}/VulkanMemoryAllocator
        )


add_library(D3D12MemoryAllocator INTERFACE)
target_include_directories(D3D12MemoryAllocator INTERFACE
        ${THIRD_PARTY_GRAPHIS_DIR}/D3D12MemoryAllocator
        )

set(BSTR_FILES
        ${THE_FORGE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/bstrlib/bstrlib.c)
add_library(Bstr STATIC ${BSTR_FILES})

set(cJSON_FILES
        ${THE_FORGE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/cJSON/cJSON.c)
add_library(cJSON STATIC ${cJSON_FILES})

set(RMEM_FILES
        ${THE_FORGE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_get_module_info.cpp
        ${THE_FORGE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_hook.cpp
        ${THE_FORGE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/rmem/src/rmem_lib.cpp
        )
add_library(RMem STATIC ${RMEM_FILES})

set(IMGUI_FILES
        ${THE_FORGE_DIR}/Common_3/Application/ThirdParty/OpenSource/imgui/imconfig.h
        ${THE_FORGE_DIR}/Common_3/Application/ThirdParty/OpenSource/imgui/imgui_demo.cpp
        ${THE_FORGE_DIR}/Common_3/Application/ThirdParty/OpenSource/imgui/imgui_draw.cpp
        ${THE_FORGE_DIR}/Common_3/Application/ThirdParty/OpenSource/imgui/imgui_internal.h
        ${THE_FORGE_DIR}/Common_3/Application/ThirdParty/OpenSource/imgui/imgui_widgets.cpp
        ${THE_FORGE_DIR}/Common_3/Application/ThirdParty/OpenSource/imgui/imgui_tables.cpp
        ${THE_FORGE_DIR}/Common_3/Application/ThirdParty/OpenSource/imgui/imgui.cpp
        ${THE_FORGE_DIR}/Common_3/Application/ThirdParty/OpenSource/imgui/imgui.h
        )
add_library(Imgui STATIC ${IMGUI_FILES})

set(CPU_FEATURES_FILES
        ${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_macos.c
        ${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_iOS.c
        ${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource/cpu_features/src/impl_x86_windows.c
        )
add_library(cpu_features STATIC ${CPU_FEATURES_FILES})


set(GAINPUT_THIRD_PARTY_DIR ${THE_FORGE_DIR}/Common_3/Application/ThirdParty/OpenSource)
set(GAINPUT_STATIC_FILES
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gainput.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputAllocator.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputButtonStickGesture.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputDev.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputMemoryStream.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputNetAddress.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputNetConnection.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputNetListener.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputDoubleClickGesture.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputHoldGesture.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputDeltaState.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputDevice.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/builtin/GainputInputDeviceBuiltIn.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboard.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/mouse/GainputInputDeviceMouse.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/pad/GainputInputDevicePad.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/touch/GainputInputDeviceTouch.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputManager.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputMap.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/recorder/GainputInputPlayer.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/recorder/GainputInputRecorder.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/recorder/GainputInputRecording.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputState.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputMapFilters.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputPinchGesture.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputRotateGesture.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputSimultaneouslyDownGesture.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputTapGesture.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/hid/GainputHID.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/hid/GainputHIDWhitelist.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS4Controller.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS5Controller.cpp
        )

set(GAINPUT_WINDOWS_FILES
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/hidapi/windows/hid.c
        )

set(GAINPUT_LINUX_FILES
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/hidapi/linux/hid.c
        )

set(GAINPUT_MACOS_FILES
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputMac.mm
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/pad/GainputInputDevicePadMac.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/mouse/GainputInputDeviceMouseMac.mm
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/mouse/GainputInputDeviceMouseMacRaw.mm
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboardMac.cpp
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/hidapi/mac/hid.c
        )
set(GAINPUT_IOS_FILES
        ${GAINPUT_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputIos.mm
        )
source_group(Core FILES ${GAINPUT_STATIC_FILES})
source_group(MacOS FILES ${GAINPUT_MACOS_FILES})
if(${APPLE_PLATFORM} MATCHES ON)
    set(GAINPUT_STATIC_FILES
            ${GAINPUT_STATIC_FILES}
            ${GAINPUT_MACOS_FILES}
            )
endif()

if(${WINDOWS} MATCHES ON)
    set(GAINPUT_STATIC_FILES
            ${GAINPUT_STATIC_FILES}
            ${GAINPUT_WINDOWS_FILES}
            )
endif()

add_library(GaInput STATIC ${GAINPUT_STATIC_FILES})
target_include_directories(GaInput PUBLIC ${THIRD_PARTY_DIR}/gainput/lib/include)
if (${APPLE_PLATFORM} MATCHES ON)
    #set_source_files_properties(${GAINPUT_STATIC_FILES} PROPERTIES COMPILE_FLAGS "-x objective-c++")
    set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=c++17 -stdlib=libc++ -x objective-c++")
    set_property(TARGET GaInput PROPERTY C_STANDARD 17)
    target_compile_options(GaInput PRIVATE "-fno-objc-arc")
endif()

set(LUA_THIRD_PARTY_DIR ${THE_FORGE_DIR}/Common_3/Game/ThirdParty/OpenSource)

set(LUA_FILES
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lapi.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lauxlib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lbaselib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lbitlib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lcode.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lcorolib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lctype.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/ldblib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/ldebug.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/ldo.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/ldump.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lfunc.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lgc.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/linit.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/liolib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/llex.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lmathlib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lmem.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/loadlib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lobject.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lopcodes.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/loslib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lparser.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lstate.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lstring.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lstrlib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/ltable.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/ltablib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/ltm.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lundump.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lutf8lib.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lvm.c
        ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lzio.c
        )
add_library(Lua STATIC ${LUA_FILES})


set(THIRD_PARTY_DEPS
        Bstr
        cJSON
        Imgui
        RMem
        GaInput
        cpu_features
        Lua
        )