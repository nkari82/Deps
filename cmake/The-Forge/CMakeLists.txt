# Do some OS checks, and setup accordingly.
set(APPLE_PLATFORM OFF)
set(LINUX OFF)
set(WINDOWS OFF)

# On macOS, we always set Metal support to on.
set(METAL OFF)

# Make our APIs into options
option(DX12 "DirectX12 (Windows only)" OFF)
option(DX11 "DirectX11 (Windows only)" OFF)
option(EXAMPLES "The Forge examples" OFF)
option(VULKAN "Vulkan" OFF)
option(DYNAMIC_LIB "Dynamic Library" OFF)

set(ASSIMP OFF)
set(OZZ OFF)

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    message("Apple platform detected. Generating macOS and iOS targets.")
    set(APPLE_PLATFORM ON)
endif()

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    message("Linux detected. Generating Linux targets.")
    set(LINUX ON)
    set(VULKAN ON)
endif()

if (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    message("Windows detected. Generating Windows targets.")
    set(WINDOWS ON)
endif()


# Setup some sane API defaults.
set(API_SELECTED ON)

if(${VULKAN} MATCHES OFF)
    if(${DX11} MATCHES OFF)
        if(${DX12} MATCHES OFF)
            if(${METAL} MATCHES OFF)
                set(API_SELECTED OFF)
            endif()
        endif()
    endif()
endif()

# Apple platforms should always default to Metal.
if (${APPLE_PLATFORM} MATCHES ON)
    if(${METAL} MATCHES OFF)
        set(METAL ON)
    endif()

    if(${VULKAN} MATCHES ON)
        set(VULKAN OFF)
    endif()

    if(${DX11} MATCHES ON)
        set(DX11 OFF)
    endif()

    if(${DX12} MATCHES ON)
        set(DX12 OFF)
    endif()

    set(API_SELECTED ON)
endif()

if (${API_SELECTED} MATCHES OFF)
    if(${APPLE_PLATFORM} MATCHES ON)
        set(METAL ON)
    endif()

    if(${LINUX} MATCHES ON)
        set(VULKAN ON)
    endif()

    if(${WINDOWS} MATCHES ON)
        set(DX12 ON)
        # Needed due to how the profiler in forge force-links to vulkan as well.
        set(VULKAN ON)
    endif()
endif()

if(${DX12} MATCHES ON)
    set(DX11 ON)
endif()

message("The following options have been set to on:\n")
if(${APPLE_PLATFORM} MATCHES ON)
    message("Apple platform")
endif()

if(${LINUX} MATCHES ON)
    message("Linux platform")
endif()

if(${WINDOWS} MATCHES ON)
    message("Windows platform")
endif()

if(${METAL} MATCHES ON)
    message("Metal reendering API")
endif()

if(${VULKAN} MATCHES ON)
    message("Vulkan rendering API")
endif()

if(${DX11} MATCHES ON)
    message("DirectX 11 rendering API")
endif()

if(${DX12} MATCHES ON)
    message("DirectX 12 rendering API")
endif()

if(${DYNAMIC_LIB} MATCHES ON)
    message("Dynamic library")
endif()

message("\n")

set(THE_FORGE_DIR ../../The-Forge)
set(TF_GRAPHICS_DIR ${THE_FORGE_DIR}/Common_3/Graphics) 
set(TF_GRAPHICS_THIRD_PARTY_DIR ${TF_GRAPHICS_DIR}/ThirdParty)

set(TF_RENDERER_DIR ${THE_FORGE_DIR}/Common_3/Renderer)

set(TF_RESOURCES_DIR ${THE_FORGE_DIR}/Common_3/Resources)
set(TF_RESOURCES_ANIMATION ${TF_RESOURCES_DIR}/AnimationSystem)
set(TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR ${TF_RESOURCES_ANIMATION}/ThirdParty)
set(TF_RESOURCES_LOADER ${TF_RESOURCES_DIR}/ResourceLoader)
set(TF_RESOURCES_LOADER_THIRD_PARTY_DIR ${TF_RESOURCES_LOADER}/ThirdParty)

set(TF_TOOLS_DIR ${THE_FORGE_DIR}/Common_3/Tools)
set(TF_TOOLS_THIRD_PARTY_DIR ${TF_TOOLS_DIR}/ThirdParty)

set(TF_APPLICATION_DIR ${THE_FORGE_DIR}/Common_3/Application)
set(TF_APPLICATION_THIRD_PARTY_DIR ${TF_APPLICATION_DIR}/ThirdParty)

set(TF_GAME_DIR ${THE_FORGE_DIR}/Common_3/Game)
set(TF_GAME_THIRD_PARTY_DIR ${TF_GAME_DIR}/ThirdParty)

set(TF_OS_DIR ${THE_FORGE_DIR}/Common_3/OS)
set(TF_OS_THIRD_PARTY_DIR ${TF_OS_DIR}/ThirdPaty)

set(TF_UTILITIES_DIR ${THE_FORGE_DIR}/Common_3/Utilities)
set(TF_UTILITIES_THIRD_PARTY_DIR ${TF_UTILITIES_DIR}/ThirdParty)

# Dependencies
set(SPIRVTOOLS_SOURCE
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cfg.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cfg.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cpp.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cpp.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cross.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cross.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cross_parsed_ir.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cross_parsed_ir.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cross_util.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_cross_util.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_glsl.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_glsl.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_hlsl.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_hlsl.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_msl.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_msl.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_parser.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_parser.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_reflect.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/spirv_reflect.hpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/SpirvTools.cpp
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/SPIRV_Cross/SpirvTools.h
    )

add_library(SpirvTools STATIC ${SPIRVTOOLS_SOURCE})
set_property(TARGET SpirvTools PROPERTY CXX_STANDARD 17)

add_library(WinPixEventRuntime SHARED IMPORTED)
set_property(TARGET WinPixEventRuntime PROPERTY IMPORTED_LOCATION ${TF_THIRD_PARTY_OS_DIR}/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.dll)
set_property(TARGET WinPixEventRuntime PROPERTY IMPORTED_IMPLIB ${TF_THIRD_PARTY_OS_DIR}/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.lib)

add_library(AGS SHARED IMPORTED)
set_property(TARGET AGS PROPERTY IMPORTED_LOCATION ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/ags/ags_lib/lib/amd_ags_x64.dll)
set_property(TARGET AGS PROPERTY IMPORTED_IMPLIB ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/ags/ags_lib/lib/amd_ags_x64.lib)
target_include_directories(AGS INTERFACE ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/ags)

add_library(Nvapi STATIC IMPORTED)
set_property(TARGET Nvapi PROPERTY IMPORTED_LOCATION ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/nvapi/amd64/nvapi64.lib)
target_include_directories(Nvapi INTERFACE ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/nvapi)

add_library(DirectXShaderCompiler STATIC IMPORTED)
set_property(TARGET DirectXShaderCompiler PROPERTY IMPORTED_LOCATION ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/DirectXShaderCompiler/lib/x64/dxcompiler.lib)

add_library(VulkanMemoryAllocator INTERFACE)
target_include_directories(VulkanMemoryAllocator INTERFACE ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/VulkanMemoryAllocator)

add_library(D3D12MemoryAllocator INTERFACE)
target_include_directories(D3D12MemoryAllocator INTERFACE ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/D3D12MemoryAllocator)

set(IMGUI_FILES
    ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/imgui/imconfig.h
    ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/imgui/imgui_demo.cpp
    ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/imgui/imgui_draw.cpp
    ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/imgui/imgui_internal.h
    ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/imgui/imgui_widgets.cpp
    ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/imgui/imgui_tables.cpp
    ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/imgui/imgui.cpp
    ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/imgui/imgui.h
    )
add_library(Imgui STATIC ${IMGUI_FILES})

set(TF_APPLICATION_THIRD_PARTY_INPUT_DIR ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/gainput/lib/source)
set(GAINPUT_STATIC_FILES
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/gainput.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/GainputAllocator.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/gestures/GainputButtonStickGesture.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/dev/GainputDev.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/dev/GainputMemoryStream.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/dev/GainputNetAddress.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/dev/GainputNetConnection.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/dev/GainputNetListener.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/gestures/GainputDoubleClickGesture.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/gestures/GainputHoldGesture.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/GainputInputDeltaState.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/GainputInputDevice.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/builtin/GainputInputDeviceBuiltIn.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/keyboard/GainputInputDeviceKeyboard.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/mouse/GainputInputDeviceMouse.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/pad/GainputInputDevicePad.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/touch/GainputInputDeviceTouch.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/GainputInputManager.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/GainputInputMap.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/recorder/GainputInputPlayer.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/recorder/GainputInputRecorder.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/recorder/GainputInputRecording.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/GainputInputState.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/GainputMapFilters.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/gestures/GainputPinchGesture.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/gestures/GainputRotateGesture.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/gestures/GainputSimultaneouslyDownGesture.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/gestures/GainputTapGesture.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/hid/GainputHID.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/hid/GainputHIDWhitelist.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/hid/hidparsers/HIDParserPS4Controller.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/hid/hidparsers/HIDParserPS5Controller.cpp
	${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/hid/hidparsers/HIDParserSwitchController.cpp
    )

set(GAINPUT_WINDOWS_FILES ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/hidapi/windows/hid.c)
set(GAINPUT_LINUX_FILES ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/hidapi/linux/hid.c)
set(GAINPUT_MACOS_FILES
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/GainputMac.mm
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/pad/GainputInputDevicePadMac.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/mouse/GainputInputDeviceMouseMac.mm
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/mouse/GainputInputDeviceMouseMacRaw.mm
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/keyboard/GainputInputDeviceKeyboardMac.cpp
    ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/hidapi/mac/hid.c
    )
set(GAINPUT_IOS_FILES ${TF_APPLICATION_THIRD_PARTY_INPUT_DIR}/gainput/GainputIos.mm)
source_group(Core FILES ${GAINPUT_STATIC_FILES})
source_group(MacOS FILES ${GAINPUT_MACOS_FILES})
if(${APPLE_PLATFORM} MATCHES ON)
    set(GAINPUT_STATIC_FILES ${GAINPUT_STATIC_FILES} ${GAINPUT_MACOS_FILES} )
endif()

if(${WINDOWS} MATCHES ON)
    set(GAINPUT_STATIC_FILES ${GAINPUT_STATIC_FILES} ${GAINPUT_WINDOWS_FILES})
endif()

add_library(GaInput STATIC ${GAINPUT_STATIC_FILES})
target_include_directories(GaInput PUBLIC ${TF_APPLICATION_THIRD_PARTY_DIR}/OpenSource/gainput/lib/include)
if (${APPLE_PLATFORM} MATCHES ON)
    set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=c++17 -stdlib=libc++ -x objective-c++")
    set_property(TARGET GaInput PROPERTY C_STANDARD 17)
    target_compile_options(GaInput PRIVATE "-fno-objc-arc")
endif()

set(LUA_FILES
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lapi.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lauxlib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lbaselib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lbitlib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lcode.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lcorolib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lctype.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/ldblib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/ldebug.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/ldo.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/ldump.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lfunc.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lgc.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/linit.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/liolib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/llex.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lmathlib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lmem.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/loadlib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lobject.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lopcodes.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/loslib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lparser.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lstate.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lstring.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lstrlib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/ltable.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/ltablib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/ltm.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lundump.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lutf8lib.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lvm.c
    ${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lzio.c
    )
add_library(Lua STATIC ${LUA_FILES})

set(THIRD_PARTY_DEPS Imgui GaInput Lua)
		
# Tools
# ozz-animation
set(OZZ_FILES
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/additive_animation_builder.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/animation_builder.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/animation_optimizer.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/raw_animation.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/raw_animation_archive.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/raw_animation_utils.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/raw_skeleton.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/raw_skeleton_archive.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/raw_track.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/skeleton_builder.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/track_builder.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/offline/track_optimizer.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/animation.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/animation_keyframe.h
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/animation_utils.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/blending_job.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/ik_aim_job.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/ik_two_bone_job.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/local_to_model_job.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/sampling_job.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/skeleton.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/skeleton_utils.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/track.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/track_sampling_job.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/runtime/track_triggering_job.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/base/containers/string_archive.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/base/io/archive.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/base/maths/math_archive.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/base/maths/simd_math_archive.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/base/maths/soa_math_archive.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/base/memory/allocator.cc
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/src/base/platform.cc
	)

# AssetPipelineCmd
set(ASSET_PIPELINE_CMD_FILES
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/TressFX/TressFXAsset.h
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/TressFX/TressFXAsset.cpp
	${TF_RESOURCES_ANIMATION_THIRD_PARTY_DIR}/OpenSource/TressFX/TressFXFileFormat.h
	${TF_TOOLS_DIR}/AssetPipeline/src/AssetPipeline.cpp
	${TF_TOOLS_DIR}/AssetPipeline/src/AssetPipeline.h
	${TF_TOOLS_DIR}/AssetPipeline/src/AssetPipeline_Textures.cpp
	${TF_TOOLS_DIR}/AssetPipeline/src/AssetPipelineCmd.cpp
	${TF_TOOLS_DIR}/AssetPipeline/src/AssetPipelineConfig.h
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/allocator.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/clusterizer.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/indexcodec.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/indexgenerator.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/meshoptimizer.h
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/overdrawanalyzer.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/overdrawoptimizer.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/simplifier.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/spatialorder.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/stripifier.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/vcacheanalyzer.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/vcacheoptimizer.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/vertexcodec.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/vertexfilter.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/vfetchanalyzer.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/meshoptimizer/src/vfetchoptimizer.cpp
	${TF_UTILITIES_DIR}/FileSystem/ToolFileSystem.c)
	
# lz4
set(LZ4_FILES
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/lz4/lz4.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/lz4/lz4hc.c)

# zstd
set(ZSTD_FILES
    ${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/common/debug.c
    ${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/common/entropy_common.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/common/error_private.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/common/fse_decompress.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/common/pool.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/common/threading.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/common/xxhash.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/common/zstd_common.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/fse_compress.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/hist.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/huf_compress.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstdmt_compress.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstd_compress.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstd_compress_literals.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstd_compress_sequences.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstd_compress_superblock.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstd_double_fast.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstd_fast.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstd_lazy.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstd_ldm.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/compress/zstd_opt.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/decompress/huf_decompress.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/decompress/zstd_ddict.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/decompress/zstd_decompress.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/zstd/decompress/zstd_decompress_block.c)

# BunyLib
set(BUNY_FILES
	${TF_TOOLS_DIR}/BunyArchive/Buny.c
	${TF_TOOLS_DIR}/BunyArchive/Buny.h
	${LZ4_FILES}
	${ZSTD_FILES})
	
# BunyTool
set(BUNY_TOOL_FILES
	${TF_OS_DIR}/Windows/WindowsToolsFileSystem.cpp
	${TF_TOOLS_DIR}/BunyArchive/BunyTool.c
	${TF_TOOLS_DIR}/BunyArchive/VisualStudio/BunyTool.rc
	${TF_TOOLS_DIR}/BunyArchive/VisualStudio/icon.cio
	${TF_TOOLS_DIR}/BunyArchive/VisualStudio/resource.h
	${TF_UTILITIES_DIR}/FileSystem/ToolFileSystem.c)
	
# ispc_texcomp
set(ISPC_TEX_COMP_FILES
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/ISPCTextureCompressor/ispc_texcomp/ispc_texcomp.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/ISPCTextureCompressor/ispc_texcomp/ispc_texcomp.h
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/ISPCTextureCompressor/ispc_texcomp/ispc_texcomp_astc.cpp
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/ISPCTextureCompressor/ispc_texcomp/kernel.ispc
	${TF_TOOLS_THIRD_PARTY_DIR}/OpenSource/ISPCTextureCompressor/ispc_texcomp/kernel_astc.ispc)
											  
# Renderer
set(GRAPHICS_DX11_FILES
    ${TF_GRAPHICS_DIR}/Direct3D11/Direct3D11.cpp
    ${TF_GRAPHICS_DIR}/Direct3D11/Direct3D11CapBuilder.h
    ${TF_GRAPHICS_DIR}/Direct3D11/Direct3D11Config.h
    ${TF_GRAPHICS_DIR}/Direct3D11/Direct3D11ShaderReflection.cpp)
source_group(Graphics/Direct3D11 FILES ${GRAPHICS_DX11_FILES})

set(GRAPHICS_DX12_FILES
    ${TF_GRAPHICS_DIR}/Direct3D12/Direct3D12.cpp
    ${TF_GRAPHICS_DIR}/Direct3D12/Direct3D12CapBuilder.h
    ${TF_GRAPHICS_DIR}/Direct3D12/Direct3D12Config.h
    ${TF_GRAPHICS_DIR}/Direct3D12/Direct3D12Hooks.cpp
    ${TF_GRAPHICS_DIR}/Direct3D12/Direct3D12Hooks.h
    ${TF_GRAPHICS_DIR}/Direct3D12/Direct3D12Raytracing.cpp
    ${TF_GRAPHICS_DIR}/Direct3D12/Direct3D12ShaderReflection.cpp)
source_group(Graphics/Direct3D12 FILES ${GRAPHICS_DX12_FILES})

set(GRAPHICS_VULKAN_FILES
    ${TF_GRAPHICS_DIR}/Vulkan/Vulkan.cpp
    ${TF_GRAPHICS_DIR}/Vulkan/VulkanCapsBuilder.h
    ${TF_GRAPHICS_DIR}/Vulkan/VulkanConfig.h
    ${TF_GRAPHICS_DIR}/Vulkan/VulkanRaytracing.cpp
    ${TF_GRAPHICS_DIR}/Vulkan/VulkanShaderReflection.cpp)
source_group(Graphics/Vulkan FILES ${GRAPHICS_VULKAN_FILES})

set(GRAPHICS_METAL_FILES
    ${TF_GRAPHICS_DIR}/Metal/MetalAvailabilityMacros.h
    ${TF_GRAPHICS_DIR}/Metal/MetalCapBuilder.h
    ${TF_GRAPHICS_DIR}/Metal/MetalConfig.h
    ${TF_GRAPHICS_DIR}/Metal/MetalMemoryAllocatorImpl.h
    ${TF_GRAPHICS_DIR}/Metal/MetalRaytracing.mm
    ${TF_GRAPHICS_DIR}/Metal/MetalRenderer.mm
    ${TF_GRAPHICS_DIR}/Metal/MetalShaderReflection.mm)
source_group(Graphics/Metal FILES ${GRAPHICS_METAL_FILES})
	
set(GRAPHICS_THIRD_PARTY_FILES
	${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource//ags/AgsHelper.h
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource//nvapi/NvApiHelper.h
    ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource//VulkanMemoryAllocator/VulkanMemoryAllocator.h)

source_group(Graphics/ThirdParty/OpenSource/ags FILES ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/ags/AgsHelper.h)
source_group(Graphics/ThirdParty/OpenSource/nvapi FILES ${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/nvapi/NvApiHelper.h)
source_group(Graphics/ThirdParty/OpenSource/VulkanMemoryAllocator FILES 
	${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/VulkanMemoryAllocator/VulkanMemoryAllocator.h)
	
set(GRAPHICS_INTERFACE_FILES
	${TF_GRAPHICS_DIR}/Interfaces/IGraphics.h
    ${TF_GRAPHICS_DIR}/Interfaces/IRay.h
    ${TF_GRAPHICS_DIR}/Interfaces/IShaderReflection.h)
source_group(Graphics/Interfaces FILES ${GRAPHICS_INTERFACE_FILES})

set(GRAPHICS_FILES
    ${TF_GRAPHICS_DIR}/CommonShaderReflection.cpp
    ${TF_GRAPHICS_DIR}/GraphicsConfig.cpp
	${TF_GRAPHICS_DIR}/GraphicsConfig.h
    ${TF_GRAPHICS_DIR}/PickRenderingAPI.cpp
	${TF_GRAPHICS_DIR}/ShaderUtilities.h.fsl)
source_group(Graphics FILES ${GRAPHICS_FILES})

set(RENDERER_INTERFACE_FILES
	${TF_RENDERER_DIR}/Interfaces/IParticleSystem.h
	${TF_RENDERER_DIR}/Interfaces/IVisibilityBuffer.h
	${TF_RENDERER_DIR}/Interfaces/IVisibilityBuffer2.h)
source_group(Renderer/Interfaces FILES ${RENDERER_INTERFACE_FILES})

set(RENDERER_PARTICLE_SYSTEM_SHADER_FILES
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle.frag.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle.vert.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle_boids.h.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle_clear_sorting_structs.comp.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle_defs.h.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle_packing.h.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle_random.h.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle_sets.h.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle_shared.h.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle_simulate.comp.fsl
	${TF_RENDERER_DIR}/ParticleSystem/Shaders/particle_utils.h.fsl)
set(RENDERER_PARTICLE_SYSTEM_FILES ${TF_RENDERER_DIR}/ParticleSystem/ParticleSystem.cpp)
	
set(RENDERER_VISIBILITY_BUFFER_SHADER_FILES
	${TF_RENDERER_DIR}/VisibilityBuffer/Shaders/FSL/batch_compaction.h.fsl
	${TF_RENDERER_DIR}/VisibilityBuffer/Shaders/FSL/clear_buffers.h.fsl
	${TF_RENDERER_DIR}/VisibilityBuffer/Shaders/FSL/pre_skin_vertexes.h.fsl
	${TF_RENDERER_DIR}/VisibilityBuffer/Shaders/FSL/triangle_filtering.h.fsl
	${TF_RENDERER_DIR}/VisibilityBuffer/Shaders/FSL/vb_resources.h.fsl
	${TF_RENDERER_DIR}/VisibilityBuffer/Shaders/FSL/vb_shader_defs.h.fsl
	${TF_RENDERER_DIR}/VisibilityBuffer/Shaders/FSL/vb_shading_utilities.h.fsl
	${TF_RENDERER_DIR}/VisibilityBuffer/Shaders/FSL/vb_structs.h.fsl)	
set(RENDERER_VISIBILITY_BUFFER_FILES ${TF_RENDERER_DIR}/VisibilityBuffer/VisibilityBuffer.cpp)
	
source_group(Renderer/ParticleSystem FILES ${RENDERER_PARTICLE_SYSTEM_FILES})
source_group(Renderer/VisibilityBuffer FILES ${RENDERER_VISIBILITY_BUFFER_FILES})
source_group(Renderer/ParticleSystem/Shaders FILES ${RENDERER_PARTICLE_SYSTEM_SHADER_FILES})
source_group(Renderer/VisibilityBuffer/Shaders FILES ${RENDERER_VISIBILITY_BUFFER_SHADER_FILES})

set(RESOURCES_INTERFACES_FILES ${TF_RESOURCES_LOADER}/Interfaces/IResourceLoader.h)
source_group(Resources/ResourceLoader/Interfaces FILES ${RESOURCES_INTERFACES_FILES})
	
set(RESOURCES_FILES
	${TF_RESOURCES_LOADER}/ResourceLoader.cpp
	${TF_RESOURCES_LOADER}/TextureContainers.h)
source_group(Resources/ResourceLoader FILES ${RESOURCES_FILES})
	
set(TOOLS_FILES
	${TF_TOOLS_DIR}/Network/Network.c
	${TF_TOOLS_DIR}/Network/Network.h
	${TF_TOOLS_DIR}/ReloadServer/ReloadClient.cpp
	${TF_TOOLS_DIR}/ReloadServer/ReloadClient.h)
	
source_group(Tools/Network FILES 
	${TF_TOOLS_DIR}/Network/Network.c 
	${TF_TOOLS_DIR}/Network/Network.h)
	
source_group(Tools/ReloadServer FILES 
	${TF_TOOLS_DIR}/ReloadServer/ReloadClient.cpp 
	${TF_TOOLS_DIR}/ReloadServer/ReloadClient.h)

set(RENDERER_SOURCE_FILES 
	${RENDERER_INTERFACE_FILES}
	${GRAPHICS_INTERFACE_FILES}
	${RESOURCES_INTERFACES_FILES}
	${RENDERER_PARTICLE_SYSTEM_SHADER_FILES}
	${RENDERER_VISIBILITY_BUFFER_SHADER_FILES}
	${GRAPHICS_FILES}
	${GRAPHICS_THIRD_PARTY_FILES}
	${RENDERER_PARTICLE_SYSTEM_FILES}
	${RENDERER_VISIBILITY_BUFFER_FILES}
	${RESOURCES_FILES}
	${TOOLS_FILES}
	)

if(${APPLE_PLATFORM} MATCHES ON)
    find_library(APPLE_METAL Metal)
    find_library(APPLE_METALKIT MetalKit)
    find_library(APPLE_METALPS MetalPerformanceShaders)

    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES} ${APPLE_METAL} ${APPLE_METALKIT} ${APPLE_METALPS})
    set(RENDERER_SOURCE_FILES ${RENDERER_SOURCE_FILES} ${GRAPHICS_METAL_FILES})

    find_library(APPLE_APPKIT AppKit)
    find_library(APPLE_QUARTZCORE QuartzCore)
    find_library(APPLE_IOKIT IOKit)

    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES} ${APPLE_QUARTZCORE} ${APPLE_APPKIT} ${APPLE_IOKIT})
endif()

if(${VULKAN} MATCHES ON)
    find_package(Vulkan REQUIRED)
    if (Vulkan_FOUND MATCHES TRUE)
        message("Vulkan SDK found.")
        set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES} Vulkan::Vulkan)
    else()
        message("Vulkan SDK not found.  Please make sure it is installed and added to your path.")
    endif()

    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES} VulkanMemoryAllocator SpirvTools)
    set(RENDERER_SOURCE_FILES  ${RENDERER_SOURCE_FILES}  ${GRAPHICS_VULKAN_FILES})
    set(RENDERER_LIBRARY_PATHS ${Vulkan_INCLUDE_DIRS})

endif()

if(${DX11} MATCHES ON)
    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES} DirectXShaderCompiler "d3d11.lib")
    set(RENDERER_SOURCE_FILES  ${RENDERER_SOURCE_FILES} ${GRAPHICS_DX11_FILES})
endif()

if(${DX12} MATCHES ON)
    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES} D3D12MemoryAllocator)
    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES} "d3d12.lib")
    set(RENDERER_SOURCE_FILES ${RENDERER_SOURCE_FILES} ${GRAPHICS_DX12_FILES})
endif()

if(${WINDOWS} MATCHES ON)
    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES} WinPixEventRuntime AGS Nvapi)
    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES} "Xinput9_1_0.lib" "ws2_32.lib")
    set(RENDERER_DEFINES ${RENDERER_DEFINES} "_WINDOWS")
endif()

# OS
set(APP_INTERFACES_FILES
	${TF_APPLICATION_DIR}/Interfaces/IApp.h
	${TF_APPLICATION_DIR}/Interfaces/ICameraController.h
	${TF_APPLICATION_DIR}/Interfaces/IFont.h
	${TF_APPLICATION_DIR}/Interfaces/IInput.h
	${TF_APPLICATION_DIR}/Interfaces/IMiddleware.h
	${TF_APPLICATION_DIR}/Interfaces/IProfiler.h
	${TF_APPLICATION_DIR}/Interfaces/IScreenshot.h
	${TF_APPLICATION_DIR}/Interfaces/IUI.h
	)

set(APP_FILES
	${APP_INTERFACES_FILES}
	${TF_APPLICATION_DIR}/Fonts/FontSystem.cpp
	${TF_APPLICATION_DIR}/Fonts/stbtt.cpp
	${TF_APPLICATION_DIR}/Profiler/GpuProfiler.cpp
    ${TF_APPLICATION_DIR}/Profiler/GpuProfiler.h
	${TF_APPLICATION_DIR}/Profiler/ProfilerBase.cpp
    ${TF_APPLICATION_DIR}/Profiler/ProfilerBase.h
    ${TF_APPLICATION_DIR}/Profiler/ProfilerHTML.h
	${TF_APPLICATION_DIR}/UI/UI.cpp
	${TF_APPLICATION_DIR}/CameraController.cpp
    ${TF_APPLICATION_DIR}/Config.h
    ${TF_APPLICATION_DIR}/InputSystem.cpp
	${TF_APPLICATION_DIR}/RemoteControl.cpp
	${TF_APPLICATION_DIR}/Screenshot.cpp
	)

set(GAME_INTERFACES_FILES ${GAME_DIR}/Interfaces/IScripting.h
set(GAME_FILES
	${GAME_INTERFACES_FILES}
	${TF_GAME_DIR}/Scripting/LuaManager.cpp
    ${TF_GAME_DIR}/Scripting/LuaManager.h
    ${TF_GAME_DIR}/Scripting/LuaManagerCommon.h
    ${TF_GAME_DIR}/Scripting/LuaManagerImpl.cpp
    ${TF_GAME_DIR}/Scripting/LuaManagerImpl.h
    ${TF_GAME_DIR}/Scripting/LuaSystem.cpp
    ${TF_GAME_DIR}/Scripting/LunaV.hpp)

set{OS_INTERFACES_FILES ${OS_DIR}/Interfaces/IOperatingSystem.h)
set(OS_FILES
    ${OS_INTERFACES_FILES}
    ${TF_OS_DIR}/CPUConfig.cpp
    ${TF_OS_DIR}/CPUConfig.h
    ${TF_OS_DIR}/WindowSystem/WindowSystem.cpp
    )

if (${WINDOWS} MATCHES ON)
    set(OS_FILES
		${TF_OS_DIR}/Windows/WindowsBase.cpp
        ${TF_OS_DIR}/Windows/WindowsFileSystem.cpp
        ${TF_OS_DIR}/Windows/WindowsLog.c
        ${TF_OS_DIR}/Windows/WindowsStackTraceDump.cpp
        ${TF_OS_DIR}/Windows/WindowsStackTraceDump.h
        ${TF_OS_DIR}/Windows/WindowsThread.c
        ${TF_OS_DIR}/Windows/WindowsTime.c
        ${TF_OS_DIR}/Windows/WindowsWindow.cpp
		${TF_OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_windows.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_iOS.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_linux_or_android.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_freebsd.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_linux_or_android.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_macos.c		
		${OS_FILES})
endif ()

set(OS_DARWIN_FILES
    ${TF_OS_DIR}/Darwin/CocoaFileSystem.mm
    ${TF_OS_DIR}/Darwin/DarwinLog.c
    ${TF_OS_DIR}/Darwin/DarwinThread.c)
		
if (${APPLE_PLATFORM} MATCHES ON)
	set(OS_FILES 
	${TF_OS_DIR}/Darwin/macOSAppDelegate.h
	${TF_OS_DIR}/Darwin/macOSAppDelegate.m
	${TF_OS_DIR}/Darwin/macOSBase.mm
	${TF_OS_DIR}/Darwin/macOSWindow.mm
	${OS_FILES} 
	${OS_DARWIN_FILES})
endif ()

set(RESOURCES_FILES
    ${TF_RESOURCES_ANIMATION}/Animation/AnimatedObject.cpp
    ${TF_RESOURCES_ANIMATION}/Animation/AnimatedObject.h
    ${TF_RESOURCES_ANIMATION}/Animation/Animation.cpp
    ${TF_RESOURCES_ANIMATION}/Animation/Animation.h
	${TF_RESOURCES_ANIMATION}/Animation/Clip.cpp
	${TF_RESOURCES_ANIMATION}/Animation/Clip.h
	${TF_RESOURCES_ANIMATION}/Animation/ClipController.cpp
	${TF_RESOURCES_ANIMATION}/Animation/ClipController.h
	${TF_RESOURCES_ANIMATION}/Animation/ClipMask.cpp
	${TF_RESOURCES_ANIMATION}/Animation/ClipMask.h
	${TF_RESOURCES_ANIMATION}/Animation/Rig.cpp
	${TF_RESOURCES_ANIMATION}/Animation/Rig.h
	${TF_RESOURCES_ANIMATION}/Animation/SkeletonBatcher.cpp
	${TF_RESOURCES_ANIMATION}/Animation/SkeletonBatcher.h
    )

set(UTILLITIES_INTERFACES_FILES
	${TF_UTILITIES_DIR}/Interfaces/IFileSystem.h
	${TF_UTILITIES_DIR}/Interfaces/ILog.h
	${TF_UTILITIES_DIR}/Interfaces/IMemory.h
	${TF_UTILITIES_DIR}/Interfaces/IThread.h
	${TF_UTILITIES_DIR}/Interfaces/ITime.h
	${TF_UTILITIES_DIR}/Interfaces/IToolFileSystem.h
	)
	
set(UTILLITY_FILES
	${UTILLITIES_INTERFACES_FILES}
	${LZ4_FILES}
	${ZSTD_FILES}
	${TF_UTILITIES_DIR}/FileSystem/FileSystem.c
	${TF_UTILITIES_DIR}/FileSystem/SystemRun.c
	${TF_UTILITIES_DIR}/Log/Log.c
	${TF_UTILITIES_DIR}/Log/Log.h
	${TF_UTILITIES_DIR}/Math/Algorithms.c
	${TF_UTILITIES_DIR}/Math/Algorithms.h
	${TF_UTILITIES_DIR}/Math/AlgorithmsImpl.h
	${TF_UTILITIES_DIR}/Math/BStringHashMap.h
	${TF_UTILITIES_DIR}/Math/MathTypes.h
	${TF_UTILITIES_DIR}/Math/Random.h
	${TF_UTILITIES_DIR}/Math/RTree.h
	${TF_UTILITIES_DIR}/Math/ShaderUtilities.h
	${TF_UTILITIES_DIR}/Math/StbDs.c
	${TF_UTILITIES_DIR}/MemoryTracking/MemoryTracking.c
	${TF_UTILITIES_DIR}/MemoryTracking/NoMemoryDefines.h
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/bstrlib/bstrlib.c
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/bstrlib/bstrlib.h
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/rmem/src/rmem_get_module_info.cpp
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/rmem/src/rmem_hook.cpp
	${TF_UTILITIES_THIRD_PARTY_DIR}/OpenSource/rmem/src/rmem_lib.cpp
	${TF_UTILITIES_DIR}/Threading/Atomics.h
	${TF_UTILITIES_DIR}/Threading/ThreadSystem.c
	${TF_UTILITIES_DIR}/Threading/ThreadSystem.h
	${TF_UTILITIES_DIR}/CustomUIWidgets.h
	${TF_UTILITIES_DIR}/RingBuffer.h
	${TF_UTILITIES_DIR}/Timer.c
	)

if (${APPLE_PLATFORM} MATCHES ON)
	set(UTILLITY_FILES ${TF_UTILITIES_DIR}/FileSystem/UnixFileSystem.cpp)
endif ()

set(OS_SOURCE_FILES
	${CORE_FILES} 
	${RESOURCES_FILES}
	${UTILLITY_FILES}
	)
	
# Merge
set(FORGE_FILES ${RENDERER_SOURCE_FILES} ${OS_SOURCE_FILES})

add_library(The-Forge STATIC ${FORGE_FILES})
target_include_directories(The-Forge PUBLIC ${TF_RESOURCE_ANIMATION_THIRD_PARTY_DIR}/OpenSource/ozz-animation/include)
target_link_libraries(The-Forge PUBLIC ${RENDERER_LIBRARIES} ${THIRD_PARTY_DEPS})
target_link_directories(The-Forge PUBLIC ${RENDERER_LIBRARY_PATHS})
target_compile_definitions(The-Forge PUBLIC ${RENDERER_DEFINES})

if (${APPLE_PLATFORM} MATCHES ON)
    set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=c++17 -stdlib=libc++ -x objective-c++")
    target_compile_options(The-Forge PRIVATE "-fobjc-arc")
endif()

# installs
install(TARGETS Lua DESTINATION lib)
install(
	FILES 
	${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lua.h
	${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/luaconf.h
	${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lualib.h
	${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lauxlib.h
	${TF_GAME_THIRD_PARTY_DIR}/OpenSource/lua-5.3.5/src/lua.hpp
	DESTINATION include
	)
		
install(
	FILES 
	${APP_INTERFACES_FILES}
	DESTINATION include/The-Forge/Application/Interfaces/
	)

install(
	FILES 
	${TF_APPLICATION_DIR}/Config.h
	DESTINATION include/The-Forge/Application
	)
	
install(
	FILES 
	${GAME_INTERFACES_FILES}
	DESTINATION include/The-Forge/Game/Interfaces/
	)
	
install(
	FILES 
	${TF_GAME_DIR}/Scripting/LuaManager.h
	${TF_GAME_DIR}/Scripting/LuaManagerCommon.h
	DESTINATION include/The-Forge/Game/Scripting/
	)
	
install(
	FILES
	${GRAPHICS_INTERFACE_FILES}
	DESTINATION include/The-Forge/Graphics/Interfaces/
	)
	
install(
	FILES 
	${GRAPHICS_DIR}/GraphicsConfig.h
	DESTINATION include/The-Forge/Graphics/
	)
	
install(
	FILES 
	${TF_GRAPHICS_DIR}/Direct3D12/Direct3D12Config.h
	DESTINATION include/The-Forge/Graphics/Direct3D12/
	)
	
install(
	FILES 
	${TF_GRAPHICS_DIR}/Direct3D11/Direct3D11Config.h
	DESTINATION include/The-Forge/Graphics/Direct3D11/
	)
	
install(
	FILES 
	${TF_GRAPHICS_DIR}/Vulkan/VulkanConfig.h
	DESTINATION include/The-Forge/Graphics/Vulkan/
	)

install(
	DIRECTORY 
	${TF_GRAPHICS_DIR}/ThirdParty/
	DESTINATION include/The-Forge/Graphics/ThirdParty/
	FILES_MATCHING
	PATTERN "*.hpp"
	PATTERN "*.h" 
	)
	
install(
	FILES 
	${OS_INTERFACES_FILES}
	DESTINATION include/The-Forge/OS/Interfaces/
	)
	
install(
	FILES 
	${TF_OS_DIR}/CPUConfig.h
	DESTINATION include/The-Forge/OS/
	)
	
install(
	FILES 
	${TF_OS_THIRD_PARTY_DIR}/OpenSource/cpu_features/src/cpu_features_types.h
	DESTINATION include/The-Forge/OS/ThirdParty/OpenSource/cpu_features/src/
	)
	
install(
	FILES 
	${RENDERER_CORE_INTERFACE_FILES}
	DESTINATION include/The-Forge/Renderer/Interfaces/
	)
	
install(
	FILES 
	${RENDERER_RESOURCES_INTERFACES_FILES}
	DESTINATION include/The-Forge/Resources/ResourceLoader/Interfaces/
	)
	
install(
	FILES 
	${TF_RESOURCE_LOADER_THIRD_PARTY_DIR}/OpenSource/tinyimageformat/tinyimageformat_base.h
	DESTINATION include/The-Forge/Resources/ResourceLoader/ThirdParty/OpenSource/tinyimageformat/
	)
	
install(
	FILES 
	${OS_UTILLITIES_INTERFACES_FILES}
	DESTINATION include/The-Forge/Utilities/Interfaces
	)
		
install(
	FILES 
	${TF_UTILITIES_DIR}/Log/Log.h
	DESTINATION include/The-Forge/Utilities/Log/
	)
	
install(
	FILES 
	${TF_UTILITIES_DIR}/Math/MathTypes.h
	${TF_UTILITIES_DIR}/Math/Random.h
	DESTINATION include/The-Forge/Utilities/Math/
	)
	
install(
	FILES 
	${TF_UTILITIES_DIR}/Threading/Atomics.h
	DESTINATION include/The-Forge/Utilities/Threading/
	)

install(
	FILES 
	${TF_UTILITIES_DIR}/RingBuffer.h
	DESTINATION include/The-Forge/Utilities/
	)
	
install(
	DIRECTORY 
	${TF_UTILITIES_THIRD_PARTY_DIR}
	DESTINATION include/The-Forge/Utilities/ThirdParty/
	FILES_MATCHING 
	PATTERN "*.hpp"
	PATTERN "*.h" 
	)
	
	
install(
	DIRECTORY  
	${THE_FORGE_DIR}/Common_3/IDE/
	DESTINATION include/The-Forge/
	)

# binary
install(TARGETS The-Forge Imgui GaInput SpirvTools DESTINATION lib)

install(
	FILES 
	${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/ags/ags_lib/lib/amd_ags_x64.lib
	${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/nvapi/amd64/nvapi64.lib
	${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/DirectXShaderCompiler/lib/x64/dxcompiler.lib
	${TF_OS_THIRD_PARTY_DIR}/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.lib
	${TF_OS_THIRD_PARTY_DIR}/OpenSource/winpixeventruntime/bin/WinPixEventRuntime_UAP.lib
	DESTINATION lib
	)
	
install(
	FILES 
	${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/ags/ags_lib/lib/amd_ags_x64.dll
	${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/Direct3d12Agility/bin/x64/D3D12Core.dll
	${TF_GRAPHICS_THIRD_PARTY_DIR}/OpenSource/Direct3d12Agility/bin/x64/d3d12SDKLayers.dll
	${TF_OS_THIRD_PARTY_DIR}/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.dll
	${TF_OS_THIRD_PARTY_DIR}/OpenSource/winpixeventruntime/bin/WinPixEventRuntime_UAP.dll
	DESTINATION bin
	)