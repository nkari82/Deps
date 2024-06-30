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
set(GRAPHICS_DIR ${THE_FORGE_DIR}/Common_3/Graphics) 
set(GRAPHICS_THIRD_PARTY_DIR ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource)

set(RENDERER_DIR ${THE_FORGE_DIR}/Common_3/Renderer)
set(RESOURCES_DIR ${THE_FORGE_DIR}/Common_3/Resources)

set(TOOLS_DIR ${THE_FORGE_DIR}/Common_3/Tools)
set(TOOLS_THIRD_PARTY_DIR ${THE_FORGE_DIR}/Common_3/Tools/ThirdParty/OpenSource)

set(APPLICATION_DIR ${THE_FORGE_DIR}/Common_3/Application)
set(APPLICATION_THIRD_PARTY_DIR ${APPLICATION_DIR}/ThirdParty/OpenSource)

set(GAME_DIR ${THE_FORGE_DIR}/Common_3/Game)
set(GAME_THIRD_PARTY_DIR ${THE_FORGE_DIR}/Common_3/Game/ThirdParty/OpenSource)

set(OS_DIR ${THE_FORGE_DIR}/Common_3/OS)
set(RESOURCES_DIR ${THE_FORGE_DIR}/Common_3/Resources)
set(UTILITIES_DIR ${THE_FORGE_DIR}/Common_3/Utilities)

# Dependencies
set(SPIRVTOOLS_SOURCE
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cfg.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cfg.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cpp.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cpp.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cross.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cross.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cross_parsed_ir.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cross_parsed_ir.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cross_util.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_cross_util.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_glsl.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_glsl.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_hlsl.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_hlsl.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_msl.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_msl.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_parser.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_parser.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_reflect.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/spirv_reflect.hpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/SpirvTools.cpp
    ${GRAPHICS_THIRD_PARTY_DIR}/SPIRV_Cross/SpirvTools.h
    )

add_library(SpirvTools STATIC ${SPIRVTOOLS_SOURCE})
set_property(TARGET SpirvTools PROPERTY CXX_STANDARD 17)


add_library(WinPixEventRuntime SHARED IMPORTED)
set_property(TARGET WinPixEventRuntime PROPERTY IMPORTED_LOCATION ${THIRD_PARTY_OS_DIR}/winpixeventruntime/bin/WinPixEventRuntime.dll)
set_property(TARGET WinPixEventRuntime PROPERTY IMPORTED_IMPLIB ${THIRD_PARTY_OS_DIR}/winpixeventruntime/bin/WinPixEventRuntime.lib)

add_library(AGS SHARED IMPORTED)
set_property(TARGET AGS PROPERTY IMPORTED_LOCATION ${THIRD_PARTY_GRAPHIS_DIR}/ags/ags_lib/lib/amd_ags_x64.dll)
set_property(TARGET AGS PROPERTY IMPORTED_IMPLIB ${THIRD_PARTY_GRAPHIS_DIR}/ags/ags_lib/lib/amd_ags_x64.lib)
target_include_directories(AGS INTERFACE ${THIRD_PARTY_GRAPHIS_DIR}/ags)


add_library(Nvapi STATIC IMPORTED)
set_property(TARGET Nvapi PROPERTY IMPORTED_LOCATION ${THIRD_PARTY_GRAPHIS_DIR}/nvapi/amd64/nvapi64.lib)
target_include_directories(Nvapi INTERFACE ${THIRD_PARTY_GRAPHIS_DIR}/nvapi)

add_library(DirectXShaderCompiler STATIC IMPORTED)
set_property(TARGET DirectXShaderCompiler PROPERTY IMPORTED_LOCATION ${THIRD_PARTY_GRAPHIS_DIR}/DirectXShaderCompiler/lib/x64/dxcompiler.lib)

add_library(VulkanMemoryAllocator INTERFACE)
target_include_directories(VulkanMemoryAllocator INTERFACE ${THIRD_PARTY_GRAPHIS_DIR}/VulkanMemoryAllocator)


add_library(D3D12MemoryAllocator INTERFACE)
target_include_directories(D3D12MemoryAllocator INTERFACE ${THIRD_PARTY_GRAPHIS_DIR}/D3D12MemoryAllocator)

set(IMGUI_FILES
    ${APPLICATION_THIRD_PARTY_DIR}/imgui/imconfig.h
    ${APPLICATION_THIRD_PARTY_DIR}/imgui/imgui_demo.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/imgui/imgui_draw.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/imgui/imgui_internal.h
    ${APPLICATION_THIRD_PARTY_DIR}/imgui/imgui_widgets.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/imgui/imgui_tables.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/imgui/imgui.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/imgui/imgui.h
    )
add_library(Imgui STATIC ${IMGUI_FILES})


set(GAINPUT_STATIC_FILES
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gainput.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputAllocator.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputButtonStickGesture.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputDev.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputMemoryStream.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputNetAddress.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputNetConnection.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/dev/GainputNetListener.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputDoubleClickGesture.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputHoldGesture.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputDeltaState.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputDevice.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/builtin/GainputInputDeviceBuiltIn.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboard.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/mouse/GainputInputDeviceMouse.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/pad/GainputInputDevicePad.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/touch/GainputInputDeviceTouch.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputManager.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputMap.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/recorder/GainputInputPlayer.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/recorder/GainputInputRecorder.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/recorder/GainputInputRecording.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputInputState.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputMapFilters.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputPinchGesture.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputRotateGesture.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputSimultaneouslyDownGesture.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/gestures/GainputTapGesture.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/hid/GainputHID.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/hid/GainputHIDWhitelist.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS4Controller.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/hid/hidparsers/HIDParserPS5Controller.cpp
	${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/hid/hidparsers/HIDParserSwitchController.cpp
    )

set(GAINPUT_WINDOWS_FILES ${APPLICATION_THIRDPARTY_DIR}/gainput/lib/source/hidapi/windows/hid.c)
set(GAINPUT_LINUX_FILES ${APPLICATION_THIRDPARTY_DIR}/gainput/lib/source/hidapi/linux/hid.c)
set(GAINPUT_MACOS_FILES
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputMac.mm
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/pad/GainputInputDevicePadMac.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/mouse/GainputInputDeviceMouseMac.mm
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/mouse/GainputInputDeviceMouseMacRaw.mm
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/keyboard/GainputInputDeviceKeyboardMac.cpp
    ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/hidapi/mac/hid.c
    )
set(GAINPUT_IOS_FILES ${APPLICATION_THIRD_PARTY_DIR}/gainput/lib/source/gainput/GainputIos.mm)
source_group(Core FILES ${GAINPUT_STATIC_FILES})
source_group(MacOS FILES ${GAINPUT_MACOS_FILES})
if(${APPLE_PLATFORM} MATCHES ON)
    set(GAINPUT_STATIC_FILES ${GAINPUT_STATIC_FILES} ${GAINPUT_MACOS_FILES} )
endif()

if(${WINDOWS} MATCHES ON)
    set(GAINPUT_STATIC_FILES ${GAINPUT_STATIC_FILES} ${GAINPUT_WINDOWS_FILES})
endif()

add_library(GaInput STATIC ${GAINPUT_STATIC_FILES})
target_include_directories(GaInput PUBLIC ${THIRD_PARTY_DIR}/gainput/lib/include)
if (${APPLE_PLATFORM} MATCHES ON)
    set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=c++17 -stdlib=libc++ -x objective-c++")
    set_property(TARGET GaInput PROPERTY C_STANDARD 17)
    target_compile_options(GaInput PRIVATE "-fno-objc-arc")
endif()

set(LUA_FILES
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lapi.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lauxlib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lbaselib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lbitlib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lcode.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lcorolib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lctype.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/ldblib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/ldebug.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/ldo.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/ldump.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lfunc.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lgc.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/linit.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/liolib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/llex.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lmathlib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lmem.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/loadlib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lobject.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lopcodes.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/loslib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lparser.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lstate.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lstring.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lstrlib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/ltable.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/ltablib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/ltm.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lundump.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lutf8lib.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lvm.c
    ${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lzio.c
    )
add_library(Lua STATIC ${LUA_FILES})

set(THIRD_PARTY_DEPS Imgui GaInput Lua)
		
# Tools
# ozz-animation
set(RESOURCE_ANIMATION ${RESOURCES_DIR}/AnimationSystem)
set(RESOURCE_ANIMATION_THIRD_PARTY_DIR ${RESOURCE_ANIMATION}/ThirdParty/OpenSource)

set(OZZ_FILES
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/additive_animation_builder.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/animation_builder.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/animation_optimizer.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/raw_animation.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/raw_animation_archive.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/raw_animation_utils.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/raw_skeleton.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/raw_skeleton_archive.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/raw_track.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/skeleton_builder.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/track_builder.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/offline/track_optimizer.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/animation.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/animation_keyframe.h
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/animation_utils.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/blending_job.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/ik_aim_job.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/ik_two_bone_job.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/local_to_model_job.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/sampling_job.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/skeleton.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/skeleton_utils.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/track.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/track_sampling_job.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/runtime/track_triggering_job.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/base/containers/string_archive.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/base/io/archive.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/base/maths/math_archive.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/base/maths/simd_math_archive.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/base/maths/soa_math_archive.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/base/memory/allocator.cc
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/ozz-animation/src/base/platform.cc
	)


# AssetPipelineCmd
set(ASSET_PIPELINE_CMD_FILES
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/TressFX/TressFXAsset.h
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/TressFX/TressFXAsset.cpp
	${RESOURCE_ANIMATION_THIRD_PARTY_DIR}/TressFX/TressFXFileFormat.h
	${TOOLS_DIR}/AssetPipeline/src/AssetPipeline.cpp
	${TOOLS_DIR}/AssetPipeline/src/AssetPipeline.h
	${TOOLS_DIR}/AssetPipeline/src/AssetPipeline_Textures.cpp
	${TOOLS_DIR}/AssetPipeline/src/AssetPipelineCmd.cpp
	${TOOLS_DIR}/AssetPipeline/src/AssetPipelineConfig.h
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/allocator.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/clusterizer.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/indexcodec.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/indexgenerator.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/meshoptimizer.h
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/overdrawanalyzer.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/overdrawoptimizer.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/simplifier.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/spatialorder.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/stripifier.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/vcacheanalyzer.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/vcacheoptimizer.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/vertexcodec.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/vertexfilter.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/vfetchanalyzer.cpp
	${TOOLS_THIRD_PARTY_DIR}/meshoptimizer/src/vfetchoptimizer.cpp
	${UTILITIES_DIR}/FileSystem/ToolFileSystem.c
	)
# BunyLib
# BunyTool
# ispc_texcomp

# Renderer
set(GRAPHICS_DX11_FILES
    ${GRAPHICS_DIR}/Direct3D11/Direct3D11.cpp
    ${GRAPHICS_DIR}/Direct3D11/Direct3D11CapBuilder.h
    ${GRAPHICS_DIR}/Direct3D11/Direct3D11Config.h
    ${GRAPHICS_DIR}/Direct3D11/Direct3D11ShaderReflection.cpp
    )

set(GRAPHICS_DX12_FILES
    ${GRAPHICS_DIR}/Direct3D12/Direct3D12.cpp
    ${GRAPHICS_DIR}/Direct3D12/Direct3D12CapBuilder.h
    ${GRAPHICS_DIR}/Direct3D12/Direct3D12Config.h
    ${GRAPHICS_DIR}/Direct3D12/Direct3D12Hooks.cpp
    ${GRAPHICS_DIR}/Direct3D12/Direct3D12Hooks.h
    ${GRAPHICS_DIR}/Direct3D12/Direct3D12Raytracing.cpp
    ${GRAPHICS_DIR}/Direct3D12/Direct3D12ShaderReflection.cpp
    )

set(GRAPHICS_VULKAN_FILES
    ${GRAPHICS_DIR}/Vulkan/Vulkan.cpp
    ${GRAPHICS_DIR}/Vulkan/VulkanCapsBuilder.h
    ${GRAPHICS_DIR}/Vulkan/VulkanConfig.h
    ${GRAPHICS_DIR}/Vulkan/VulkanRaytracing.cpp
    ${GRAPHICS_DIR}/Vulkan/VulkanShaderReflection.cpp
    )

set(GRAPHICS_METAL_FILES
    ${GRAPHICS_DIR}/Metal/MetalAvailabilityMacros.h
    ${GRAPHICS_DIR}/Metal/MetalCapBuilder.h
    ${GRAPHICS_DIR}/Metal/MetalConfig.h
    ${GRAPHICS_DIR}/Metal/MetalMemoryAllocatorImpl.h
    ${GRAPHICS_DIR}/Metal/MetalRaytracing.mm
    ${GRAPHICS_DIR}/Metal/MetalRenderer.mm
    ${GRAPHICS_DIR}/Metal/MetalShaderReflection.mm
    )
	
set(GRAPHICS_THIRD_PARTY_FILES
	${GRAPHICS_THIRD_PARTY_DIR}/ags/AgsHelper.h
    ${GRAPHICS_THIRD_PARTY_DIR}/nvapi/NvApiHelper.h
    ${GRAPHICS_THIRD_PARTY_DIR}/ags/VulkanMemoryAllocator.h
	)
	
set(GRAPHICS_INTERFACE_FILES
	${GRAPHICS_DIR}/Interfaces/IGraphics.h
    ${GRAPHICS_DIR}/Interfaces/IRay.h
    ${GRAPHICS_DIR}/Interfaces/IShaderReflection.h
	)

set(RENDERER_GRAPHICS_FILES
    ${GRAPHICS_DIR}/CommonShaderReflection.cpp
    ${GRAPHICS_DIR}/GraphicsConfig.cpp
	${GRAPHICS_DIR}/GraphicsConfig.h
    ${GRAPHICS_DIR}/PickRenderingAPI.cpp
    )

set(RENDERER_INTERFACE_FILES
	${RENDERER_DIR}/Interfaces/IParticleSystem.h
	${RENDERER_DIR}/Interfaces/IVisibilityBuffer.h
	${RENDERER_DIR}/Interfaces/IVisibilityBuffer2.h	
	)

set(RENDERER__FILES
	${RENDERER_INTERFACE_FILES}
	${RENDERER_DIR}/ParticleSystem/ParticleSystem.cpp
	${RENDERER_DIR}/VisibilityBuffer/VisibilityBuffer.cpp
	)

set(RESOURCES_INTERFACES_FILES
	${RESOURCES_DIR}/Interfaces/IResourceLoader.h
	)
	
set(RESOURCES_FILES
	${RESOURCES_INTERFACES_FILES}
	${RESOURCES_DIR}/ResourceLoader/ResourceLoader.cpp
	${RESOURCES_DIR}/ResourceLoader/TextureContainers.h
	)
	
set(TOOLS_FILES
	${TOOLS_DIR}/Network/Network.c
	${TOOLS_DIR}/Network/Network.h
	${TOOLS_DIR}/ReloadServer/ReloadServer.cpp
	${TOOLS_DIR}/ReloadServer/ReloadServer.h
	)

set(RENDERER_SOURCE_FILES 
	${GRAPHICS_FILES}
	${GRAPHICS_THIRD_PARTY_FILES}
	${RENDERER__FILES}
	${RESOURCES_FILES}
	${TOOLS_FILES}
	)

if(${APPLE_PLATFORM} MATCHES ON)
    find_library(APPLE_METAL Metal)
    find_library(APPLE_METALKIT MetalKit)
    find_library(APPLE_METALPS MetalPerformanceShaders)

    set(RENDERER_LIBRARIES 
		${RENDERER_LIBRARIES}
        ${APPLE_METAL}
        ${APPLE_METALKIT}
        ${APPLE_METALPS}
        )

    set(RENDERER_SOURCE_FILES 
		${RENDERER_SOURCE_FILES} 
		${GRAPHICS_METAL_FILES})

    find_library(APPLE_APPKIT AppKit)
    find_library(APPLE_QUARTZCORE QuartzCore)
    find_library(APPLE_IOKIT IOKit)

    set(RENDERER_LIBRARIES
        ${RENDERER_LIBRARIES}
        ${APPLE_QUARTZCORE}
        ${APPLE_APPKIT}
        ${APPLE_IOKIT}
        )
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
    set(RENDERER_SOURCE_FILES 
		${RENDERER_SOURCE_FILES} 
		${GRAPHICS_VULKAN_FILES})

    set(RENDERER_LIBRARY_PATHS ${Vulkan_INCLUDE_DIRS})

endif()

if(${DX11} MATCHES ON)
    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES}
            DirectXShaderCompiler
            "d3d11.lib"
            )
    set(RENDERER_SOURCE_FILES 
		${RENDERER_SOURCE_FILES} 
		${GRAPHICS_DX11_FILES})
endif()

if(${DX12} MATCHES ON)
    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES}
            D3D12MemoryAllocator
            )

    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES}
            "d3d12.lib"
            )

    set(RENDERER_SOURCE_FILES 
		${RENDERER_SOURCE_FILES} 
		${GRAPHICS_DX12_FILES})
endif()

if(${WINDOWS} MATCHES ON)
    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES}
         WinPixEventRuntime
         AGS
         Nvapi
         )

    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES}
        "Xinput9_1_0.lib"
        "ws2_32.lib"
        )

    set(RENDERER_DEFINES ${RENDERER_DEFINES}
        "_WINDOWS"
		)
endif()

# OS
set(APP_INTERFACES_FILES
	${APPLICATION_DIR}/Interfaces/IApp.h
	${APPLICATION_DIR}/Interfaces/ICameraController.h
	${APPLICATION_DIR}/Interfaces/IFont.h
	${APPLICATION_DIR}/Interfaces/IInput.h
	${APPLICATION_DIR}/Interfaces/IMiddleware.h
	${APPLICATION_DIR}/Interfaces/IProfiler.h
	${APPLICATION_DIR}/Interfaces/IScreenshot.h
	${APPLICATION_DIR}/Interfaces/IUI.h
	)

set(APP_FILES
	${APP_INTERFACES_FILES}
	${APPLICATION_DIR}/Fonts/FontSystem.cpp
	${APPLICATION_DIR}/Fonts/stbtt.cpp
	${APPLICATION_DIR}/Profiler/GpuProfiler.cpp
    ${APPLICATION_DIR}/Profiler/GpuProfiler.h
	${APPLICATION_DIR}/Profiler/ProfilerBase.cpp
    ${APPLICATION_DIR}/Profiler/ProfilerBase.h
    ${APPLICATION_DIR}/Profiler/ProfilerHTML.h
	${APPLICATION_DIR}/UI/UI.cpp
	${APPLICATION_DIR}/CameraController.cpp
    ${APPLICATION_DIR}/Config.h
    ${APPLICATION_DIR}/InputSystem.cpp
	${APPLICATION_DIR}/RemoteControl.cpp
	${APPLICATION_DIR}/Screenshot.cpp
	)

set(GAME_INTERFACES_FILES ${GAME_DIR}/Interfaces/IScripting.h
set(GAME_FILES
	${GAME_INTERFACES_FILES}
	${GAME_DIR}/Scripting/LuaManager.cpp
    ${GAME_DIR}/Scripting/LuaManager.h
    ${GAME_DIR}/Scripting/LuaManagerCommon.h
    ${GAME_DIR}/Scripting/LuaManagerImpl.cpp
    ${GAME_DIR}/Scripting/LuaManagerImpl.h
    ${GAME_DIR}/Scripting/LuaSystem.cpp
    ${GAME_DIR}/Scripting/LunaV.hpp)

set{OS_INTERFACES_FILES ${OS_DIR}/Interfaces/IOperatingSystem.h)
set(OS_FILES
    ${OS_INTERFACES_FILES}
    ${OS_DIR}/CPUConfig.cpp
    ${OS_DIR}/CPUConfig.h
    ${OS_DIR}/WindowSystem/WindowSystem.cpp
    )

if (${WINDOWS} MATCHES ON)
    set(OS_FILES
		${OS_DIR}/Windows/WindowsBase.cpp
        ${OS_DIR}/Windows/WindowsFileSystem.cpp
        ${OS_DIR}/Windows/WindowsLog.c
        ${OS_DIR}/Windows/WindowsStackTraceDump.cpp
        ${OS_DIR}/Windows/WindowsStackTraceDump.h
        ${OS_DIR}/Windows/WindowsThread.c
        ${OS_DIR}/Windows/WindowsTime.c
        ${OS_DIR}/Windows/WindowsWindow.cpp
		${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_windows.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_iOS.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_linux_or_android.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_freebsd.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_linux_or_android.c
		#${OS_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_macos.c		
		${OS_FILES})
endif ()

set(OS_DARWIN_FILES
    ${OS_DIR}/Darwin/CocoaFileSystem.mm
    ${OS_DIR}/Darwin/DarwinLog.c
    ${OS_DIR}/Darwin/DarwinThread.c)
		
if (${APPLE_PLATFORM} MATCHES ON)
	set(OS_FILES 
	${OS_DIR}/Darwin/macOSAppDelegate.h
	${OS_DIR}/Darwin/macOSAppDelegate.m
	${OS_DIR}/Darwin/macOSBase.mm
	${OS_DIR}/Darwin/macOSWindow.mm
	${OS_FILES} 
	${OS_DARWIN_FILES})
endif ()

set(RESOURCES_FILES
    ${RESOURCES_DIR}/Animation/AnimatedObject.cpp
    ${RESOURCES_DIR}/Animation/AnimatedObject.h
    ${RESOURCES_DIR}/Animation/Animation.cpp
    ${RESOURCES_DIR}/Animation/Animation.h
	${RESOURCES_DIR}/Animation/Clip.cpp
	${RESOURCES_DIR}/Animation/Clip.h
	${RESOURCES_DIR}/Animation/ClipController.cpp
	${RESOURCES_DIR}/Animation/ClipController.h
	${RESOURCES_DIR}/Animation/ClipMask.cpp
	${RESOURCES_DIR}/Animation/ClipMask.h
	${RESOURCES_DIR}/Animation/Rig.cpp
	${RESOURCES_DIR}/Animation/Rig.h
	${RESOURCES_DIR}/Animation/SkeletonBatcher.cpp
	${RESOURCES_DIR}/Animation/SkeletonBatcher.h
    )

set(UTILLITIES_INTERFACES_FILES
	${UTILITIES_DIR}/Interfaces/IFileSystem.h
	${UTILITIES_DIR}/Interfaces/ILog.h
	${UTILITIES_DIR}/Interfaces/IMemory.h
	${UTILITIES_DIR}/Interfaces/IThread.h
	${UTILITIES_DIR}/Interfaces/ITime.h
	${UTILITIES_DIR}/Interfaces/IToolFileSystem.h
	)
	
set(UTILLITY_FILES
	${UTILLITIES_INTERFACES_FILES}
	${UTILITIES_DIR}/FileSystem/FileSystem.c
	${UTILITIES_DIR}/FileSystem/SystemRun.c
	${UTILITIES_DIR}/Log/Log.c
	${UTILITIES_DIR}/Log/Log.h
	${UTILITIES_DIR}/Math/Algorithms.c
	${UTILITIES_DIR}/Math/Algorithms.h
	${UTILITIES_DIR}/Math/AlgorithmsImpl.h
	${UTILITIES_DIR}/Math/BStringHashMap.h
	${UTILITIES_DIR}/Math/MathTypes.h
	${UTILITIES_DIR}/Math/Random.h
	${UTILITIES_DIR}/Math/RTree.h
	${UTILITIES_DIR}/Math/ShaderUtilities.h
	${UTILITIES_DIR}/Math/StbDs.c
	${UTILITIES_DIR}/MemoryTracking/MemoryTracking.c
	${UTILITIES_DIR}/MemoryTracking/NoMemoryDefines.h
	${UTILITIES_DIR}/ThirdParty/OpenSource/bstrlib/bstrlib.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/bstrlib/bstrlib.h
	${UTILITIES_DIR}/ThirdParty/OpenSource/lz4/lz4.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/rmem/src/rmem_get_module_info.cpp
	${UTILITIES_DIR}/ThirdParty/OpenSource/rmem/src/rmem_hook.cpp
	${UTILITIES_DIR}/ThirdParty/OpenSource/rmem/src/rmem_lib.cpp
    ${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/debug.c
    ${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/entropy_common.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/error_private.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/fse_decompress.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/pool.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/threading.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/xxhash.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/zstd_common.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/fse_compress.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/hist.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/huf_compress.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstdmt_compress.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_compress.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_compress_literals.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_compress_sequences.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_compress_superblock.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_double_fast.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_fast.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_lazy.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_ldm.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_opt.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/decompress/huf_decompress.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/decompress/zstd_ddict.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/decompress/zstd_decompress.c
	${UTILITIES_DIR}/ThirdParty/OpenSource/zstd/decompress/zstd_decompress_block.c
	${UTILITIES_DIR}/Threading/Atomic.h
	${UTILITIES_DIR}/Threading/ThreadSystem.c
	${UTILITIES_DIR}/Threading/ThreadSystem.h
	${UTILITIES_DIR}/CustomUIWidgets.h
	${UTILITIES_DIR}/RingBuffer.h
	${UTILITIES_DIR}/Timer.c
	)

if (${APPLE_PLATFORM} MATCHES ON)
	set(UTILLITY_FILES ${UTILITIES_DIR}/FileSystem/UnixFileSystem.cpp)
endif ()

set(OS_SOURCE_FILES
	${CORE_FILES} 
	${RESOURCES_FILES}
	${UTILLITY_FILES}
	)
	
# Merge
set(FORGE_FILES
    ${RENDERER_SOURCE_FILES}
	${OS_SOURCE_FILES}
    )

add_library(The-Forge STATIC ${FORGE_FILES})

target_include_directories(The-Forge PUBLIC
	${THE_FORGE_DIR}/Common_3/
	${GRAPHICS_INTERFACE_FILES}
	${RESOURCES_INTERFACES_FILES}
    ${GRAPHICS_DIR}/GraphicsConfig.h
	${GRAPHICS_DIR}/GPUConfig.h
	${RESOURCES_DIR}/ResourceLoader/TextureContainers.h
    )

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
	${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lua.h
	${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/luaconf.h
	${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lualib.h
	${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lauxlib.h
	${GAME_THIRD_PARTY_DIR}/lua-5.3.5/src/lua.hpp
	DESTINATION include
	)
		
install(
	FILES 
	${APP_INTERFACES_FILES}
	DESTINATION include/The-Forge/Application/Interfaces/
	)

install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Application/Config.h
	DESTINATION include/The-Forge/Application
	)
	
install(
	FILES 
	${GAME_INTERFACES_FILES}
	DESTINATION include/The-Forge/Game/Interfaces/
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Game/Scripting/LuaManager.h
	${THE_FORGE_DIR}/Common_3/Game/Scripting/LuaManagerCommon.h
	DESTINATION include/The-Forge/Game/Scripting/
	)
	
install(
	FILES
	${GRAPHICS_INTERFACE_FILES}
	DESTINATION include/The-Forge/Graphics/Interfaces/
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Graphics/GraphicsConfig.h
	DESTINATION include/The-Forge/Graphics/
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Graphics/Direct3D12/Direct3D12Config.h
	DESTINATION include/The-Forge/Graphics/Direct3D12/
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Graphics/Direct3D11/Direct3D11Config.h
	DESTINATION include/The-Forge/Graphics/Direct3D11/
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Graphics/Vulkan/VulkanConfig.h
	DESTINATION include/The-Forge/Graphics/Vulkan/
	)

install(
	DIRECTORY 
	${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/
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
	${THE_FORGE_DIR}/Common_3/OS/CPUConfig.h
	DESTINATION include/The-Forge/OS/
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource/cpu_features/src/cpu_features_types.h
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
	${THE_FORGE_DIR}/Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/tinyimageformat/tinyimageformat_base.h
	DESTINATION include/The-Forge/Resources/ResourceLoader/ThirdParty/OpenSource/tinyimageformat/
	)
	
install(
	FILES 
	${OS_UTILLITIES_INTERFACES_FILES}
	DESTINATION include/The-Forge/Utilities/Interfaces
	)
		
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Utilities/Log/Log.h
	DESTINATION include/The-Forge/Utilities/Log/
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Utilities/Math/MathTypes.h
	${THE_FORGE_DIR}/Common_3/Utilities/Math/Random.h
	DESTINATION include/The-Forge/Utilities/Math/
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Utilities/Threading/Atomics.h
	DESTINATION include/The-Forge/Utilities/Threading/
	)

install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Utilities/RingBuffer.h
	DESTINATION include/The-Forge/Utilities/
	)
	
install(
	DIRECTORY 
	${THE_FORGE_DIR}/Common_3/Utilities/ThirdParty/OpenSource/
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
	${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/ags/ags_lib/lib/amd_ags_x64.lib
	${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/nvapi/amd64/nvapi64.lib
	${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/DirectXShaderCompiler/lib/x64/dxcompiler.lib
	${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.lib
	${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource/winpixeventruntime/bin/WinPixEventRuntime_UAP.lib
	DESTINATION lib
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/ags/ags_lib/lib/amd_ags_x64.dll
	${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/Direct3d12Agility/bin/x64/D3D12Core.dll
	${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/Direct3d12Agility/bin/x64/d3d12SDKLayers.dll
	${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource/winpixeventruntime/bin/WinPixEventRuntime.dll
	${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource/winpixeventruntime/bin/WinPixEventRuntime_UAP.dll
	DESTINATION bin
	)