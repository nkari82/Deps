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
set(RENDERER_GRAPHICS_DIR ${THE_FORGE_DIR}/Common_3/Graphics)
set(RENDERER_RENDERER_DIR ${THE_FORGE_DIR}/Common_3/Renderer)
set(RENDERER_RESOURCES_DIR ${THE_FORGE_DIR}/Common_3/Resources)

set(OS_APPLICATION_DIR ${THE_FORGE_DIR}/Common_3/Application)
set(OS_GAME_DIR ${THE_FORGE_DIR}/Common_3/Game)
set(OS_CORE_DIR ${THE_FORGE_DIR}/Common_3/OS)
set(OS_RESOURCES_DIR ${THE_FORGE_DIR}/Common_3/Resources)
set(OS_UTILITIES_DIR ${THE_FORGE_DIR}/Common_3/Utilities)

include(SpirvTools.cmake)
include(Dependencies.cmake)
#include(OS.cmake)
#include(Graphics.cmake)
#include(TheForge.cmake)

set(RENDERER_GRAPHICS_DX11_FILES
    ${RENDERER_GRAPHICS_DIR}/Direct3D11/Direct3D11.cpp
    ${RENDERER_GRAPHICS_DIR}/Direct3D11/Direct3D11CapBuilder.h
    ${RENDERER_GRAPHICS_DIR}/Direct3D11/Direct3D11Config.h
    ${RENDERER_GRAPHICS_DIR}/Direct3D11/Direct3D11ShaderReflection.cpp
    )

set(RENDERER_GRAPHICS_DX12_FILES
    ${RENDERER_GRAPHICS_DIR}/Direct3D12/Direct3D12.cpp
    ${RENDERER_GRAPHICS_DIR}/Direct3D12/Direct3D12CapBuilder.h
    ${RENDERER_GRAPHICS_DIR}/Direct3D12/Direct3D12Config.h
    ${RENDERER_GRAPHICS_DIR}/Direct3D12/Direct3D12Hooks.cpp
    ${RENDERER_GRAPHICS_DIR}/Direct3D12/Direct3D12Hooks.h
    ${RENDERER_GRAPHICS_DIR}/Direct3D12/Direct3D12Raytracing.cpp
    ${RENDERER_GRAPHICS_DIR}/Direct3D12/Direct3D12ShaderReflection.cpp
    )

set(RENDERER_GRAPHICS_VULKAN_FILES
    ${RENDERER_GRAPHICS_DIR}/Vulkan/Vulkan.cpp
    ${RENDERER_GRAPHICS_DIR}/Vulkan/VulkanCapsBuilder.h
    ${RENDERER_GRAPHICS_DIR}/Vulkan/VulkanConfig.h
    ${RENDERER_GRAPHICS_DIR}/Vulkan/VulkanRaytracing.cpp
    ${RENDERER_GRAPHICS_DIR}/Vulkan/VulkanShaderReflection.cpp
    )

set(RENDERER_GRAPHICS_METAL_FILES
    ${RENDERER_GRAPHICS_DIR}/Metal/MetalAvailabilityMacros.h
    ${RENDERER_GRAPHICS_DIR}/Metal/MetalCapBuilder.h
    ${RENDERER_GRAPHICS_DIR}/Metal/MetalConfig.h
    ${RENDERER_GRAPHICS_DIR}/Metal/MetalMemoryAllocatorImpl.h
    ${RENDERER_GRAPHICS_DIR}/Metal/MetalRaytracing.mm
    ${RENDERER_GRAPHICS_DIR}/Metal/MetalRenderer.mm
    ${RENDERER_GRAPHICS_DIR}/Metal/MetalShaderReflection.mm
    )
		
set(RENDERER_GRAPHICS_INTERFACE_FILES
	${RENDERER_GRAPHICS_DIR}/Interfaces/IGraphics.h
    ${RENDERER_GRAPHICS_DIR}/Interfaces/IRay.h
    ${RENDERER_GRAPHICS_DIR}/Interfaces/IShaderReflection.h
	)

set(RENDERER_GRAPHICS_FILES
    ${RENDERER_GRAPHICS_DIR}/CommonShaderReflection.cpp
    ${RENDERER_GRAPHICS_DIR}/GraphicsConfig.cpp
	${RENDERER_GRAPHICS_DIR}/GraphicsConfig.h
    ${RENDERER_GRAPHICS_DIR}/PickRenderingAPI.cpp
    )

set(RENDERER_RENDERER_INTERFACE_FILES
	${FORGE_RENDERER_RENDERER_DIR}/Interfaces/IParticleSystem.h
	${FORGE_RENDERER_RENDERER_DIR}/Interfaces/IVisibilityBuffer.h
	)

set(RENDERER_RENDERER_FILES
	${RENDERER_RENDERER_INTERFACE_FILES}
	${RENDERER_RENDERER_DIR}/ParticleSystem/ParticleSystem.cpp
	${RENDERER_RENDERER_DIR}/VisibilityBuffer/VisibilityBuffer.cpp
	)

set(RENDERER_RESOURCES_INTERFACES_FILES
	${RENDERER_RESOURCES_DIR}/Interfaces/IResourceLoader.h
	)
	
set(RENDERER_RESOURCES_FILES
	${RENDERER_RESOURCES_INTERFACES_FILES}
	${RENDERER_RESOURCES_DIR}/ResourceLoader/ResourceLoader.cpp
	${RENDERER_RESOURCES_DIR}/ResourceLoader/TextureContainers.h
	)
	
set(RENDERER_SOURCE_FILES 
	${RENDERER_GRAPHICS_FILES}
	${RENDERER_RENDERER_FILES}
	${RENDERER_RESOURCES_FILES})

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
		${RENDERER_GRAPHICS_METAL_FILES})

    find_library(APPLE_APPKIT AppKit)
    find_library(APPLE_QUARTZCORE QuartzCore)
    find_library(APPLE_IOKIT IOKit)

    set(RENDER_LIBRARIES
        ${RENDER_LIBRARIES}
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

    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES}
            VulkanMemoryAllocator
            SpirvTools
            )
    set(RENDERER_SOURCE_FILES 
		${RENDERER_SOURCE_FILES} 
		${RENDERER_GRAPHICS_VULKAN_FILES})

    set(RENDERER_LIBRARY_PATHS ${Vulkan_INCLUDE_DIRS})

endif()

if(${DX11} MATCHES ON)
    set(RENDERER_LIBRARIES ${RENDERER_LIBRARIES}
            DirectXShaderCompiler
            "d3d11.lib"
            )
    set(RENDERER_SOURCE_FILES 
		${RENDERER_SOURCE_FILES} 
		${RENDERER_GRAPHICS_DX11_FILES})
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
		${RENDERER_GRAPHICS_DX12_FILES})
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

# OS (OK without Imgui)
set(APP_FILES
	${OS_APPLICATION_DIR}/Fonts/FontSystem.cpp
	${OS_APPLICATION_DIR}/Fonts/stbtt.cpp
	${OS_APPLICATION_DIR}/Profiler/GpuProfiler.cpp
    ${OS_APPLICATION_DIR}/Profiler/GpuProfiler.h
	${OS_APPLICATION_DIR}/Profiler/ProfilerBase.cpp
    ${OS_APPLICATION_DIR}/Profiler/ProfilerBase.h
    ${OS_APPLICATION_DIR}/Profiler/ProfilerHTML.h
	${OS_APPLICATION_DIR}/UI/UI.cpp
	${OS_APPLICATION_DIR}/CameraController.cpp
    ${OS_APPLICATION_DIR}/Config.h
    ${OS_APPLICATION_DIR}/InputSystem.cpp
	${OS_APPLICATION_DIR}/RemoteControl.cpp
	${OS_APPLICATION_DIR}/Screenshot.cpp
	)

#(without lua)
set(GAME_FILES
	${OS_GAME_DIR}/Scripting/LuaManager.cpp
    ${OS_GAME_DIR}/Scripting/LuaManager.h
    ${OS_GAME_DIR}/Scripting/LuaManagerCommon.h
    ${OS_GAME_DIR}/Scripting/LuaManagerImpl.cpp
    ${OS_GAME_DIR}/Scripting/LuaManagerImpl.h
    ${OS_GAME_DIR}/Scripting/LuaSystem.cpp
    ${OS_GAME_DIR}/Scripting/LunaV.hpp)

set(OS_CORE_FILES
    ${OS_CORE_DIR}/Interfaces/IOperatingSystem.h
    ${OS_CORE_DIR}/CPUConfig.cpp
    ${OS_CORE_DIR}/CPUConfig.h
    ${OS_CORE_DIR}/WindowSystem/WindowSystem.cpp
    )

if (${WINDOWS} MATCHES ON)
    set(OS_CORE_FILES
		${OS_CORE_DIR}/Windows/WindowsBase.cpp
        ${OS_CORE_DIR}/Windows/WindowsFileSystem.cpp
        ${OS_CORE_DIR}/Windows/WindowsLog.c
        ${OS_CORE_DIR}/Windows/WindowsStackTraceDump.cpp
        ${OS_CORE_DIR}/Windows/WindowsStackTraceDump.h
        ${OS_CORE_DIR}/Windows/WindowsThread.c
        ${OS_CORE_DIR}/Windows/WindowsTime.c
        ${OS_CORE_DIR}/Windows/WindowsWindow.cpp
		${OS_CORE_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_windows.c
		#${OS_CORE_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_iOS.c
		#${OS_CORE_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_aarch64_linux_or_android.c
		#${OS_CORE_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_freebsd.c
		#${OS_CORE_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_linux_or_android.c
		#${OS_CORE_DIR}/ThirdParty/OpenSource/cpu_features/src/impl_x86_macos.c		
		${OS_CORE_FILES})
endif ()

set(OS_DARWIN_FILES
    ${OS_CORE_DIR}/Darwin/CocoaFileSystem.mm
    ${OS_CORE_DIR}/Darwin/DarwinLog.c
    ${OS_CORE_DIR}/Darwin/DarwinThread.c)
		
if (${APPLE_PLATFORM} MATCHES ON)
	set(OS_CORE_FILES 
	${OS_CORE_DIR}/Darwin/macOSAppDelegate.h
	${OS_CORE_DIR}/Darwin/macOSAppDelegate.m
	${OS_CORE_DIR}/Darwin/macOSBase.mm
	${OS_CORE_DIR}/Darwin/macOSWindow.mm
	${OS_CORE_FILES} 
	${OS_DARWIN_FILES})
endif ()

set(OS_RESOURCES_FILES
    ${OS_RESOURCES_DIR}/Animation/AnimatedObject.cpp
    ${OS_RESOURCES_DIR}/Animation/AnimatedObject.h
    ${OS_RESOURCES_DIR}/Animation/Animation.cpp
    ${OS_RESOURCES_DIR}/Animation/Animation.h
	${OS_RESOURCES_DIR}/Animation/Clip.cpp
	${OS_RESOURCES_DIR}/Animation/Clip.h
	${OS_RESOURCES_DIR}/Animation/ClipController.cpp
	${OS_RESOURCES_DIR}/Animation/ClipController.h
	${OS_RESOURCES_DIR}/Animation/ClipMask.cpp
	${OS_RESOURCES_DIR}/Animation/ClipMask.h
	${OS_RESOURCES_DIR}/Animation/Rig.cpp
	${OS_RESOURCES_DIR}/Animation/Rig.h
	${OS_RESOURCES_DIR}/Animation/SkeletonBatcher.h
	${OS_RESOURCES_DIR}/Animation/SkeletonBatcher.h
    )

set(OS_UTILLITIES_INTERFACES_FILES
	${OS_UTILITIES_DIR}/Interfaces/IFileSystem.h
	${OS_UTILITIES_DIR}/Interfaces/ILog.h
	${OS_UTILITIES_DIR}/Interfaces/IMemory.h
	${OS_UTILITIES_DIR}/Interfaces/IThread.h
	${OS_UTILITIES_DIR}/Interfaces/ITime.h
	)
	
set(OS_UTILLITY_FILES
	${OS_UTILLITIES_INTERFACES_FILES}
	${OS_UTILITIES_DIR}/FileSystem/FileSystem.c
	${OS_UTILITIES_DIR}/FileSystem/SystemRun.c
	${OS_UTILITIES_DIR}/Log/Log.c
	${OS_UTILITIES_DIR}/Log/Log.h
	${OS_UTILITIES_DIR}/Math/Algorithms.c
	${OS_UTILITIES_DIR}/Math/Algorithms.h
	${OS_UTILITIES_DIR}/Math/AlgorithmsImpl.h
	${OS_UTILITIES_DIR}/Math/BStringHashMap.h
	${OS_UTILITIES_DIR}/Math/MathTypes.h
	${OS_UTILITIES_DIR}/Math/Random.h
	${OS_UTILITIES_DIR}/Math/RTree.h
	${OS_UTILITIES_DIR}/Math/ShaderUtilities.h
	${OS_UTILITIES_DIR}/Math/StbDs.c
	${OS_UTILITIES_DIR}/MemoryTracking/MemoryTracking.c
	${OS_UTILITIES_DIR}/MemoryTracking/NoMemoryDefines.h
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/bstrlib/bstrlib.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/bstrlib/bstrlib.h
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/lz4/lz4.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/rmem/src/rmem_get_module_info.cpp
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/rmem/src/rmem_hook.cpp
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/rmem/src/rmem_lib.cpp
    ${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/debug.c
    ${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/entropy_common.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/error_private.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/fse_decompress.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/pool.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/threading.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/xxhash.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/common/zstd_common.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/fse_compress.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/hist.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/huf_compress.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstdmt_compress.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_compress.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_compress_literals.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_compress_sequences.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_compress_superblock.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_double_fast.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_fast.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_lazy.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_ldm.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/compress/zstd_opt.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/decompress/huf_decompress.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/decompress/zstd_ddict.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/decompress/zstd_decompress.c
	${OS_UTILITIES_DIR}/ThirdParty/OpenSource/zstd/decompress/zstd_decompress_block.c
	${OS_UTILITIES_DIR}/Threading/Atomic.h
	${OS_UTILITIES_DIR}/Threading/ThreadSystem.c
	${OS_UTILITIES_DIR}/Threading/ThreadSystem.h
	${OS_UTILITIES_DIR}/CustomUIWidgets.h
	${OS_UTILITIES_DIR}/RingBuffer.h
	${OS_UTILITIES_DIR}/Timer.c
	)

if (${APPLE_PLATFORM} MATCHES ON)
	set(OS_UTILLITY_FILES ${OS_UTILITIES_DIR}/FileSystem/UnixFileSystem.cpp)
endif ()

# Merge
set(FORGE_FILES
        #${RENDERER_SOURCE_FILES}
        #${RENDERER_INCLUDE_FILES}
        #${RENDERER_FILES}
		
		${OS_INTERFACE_FILES}
        ${OS_APP_FILES}
		${OS_CORE_FILES}
		${OS_GAME_FILES}
		${OS_RESOURCES_FILES}
		
        ${FORGE_FILESYSTEM_FILES}
        ${FORGE_MEMORY_TRACKING_FILES}
        ${FORGE_THREADING_FILES}
        ${FORGE_MATH_FILES}
        ${FORGE_LOG_FILES}
        ${OS_MIDDLEWARE_PARALLEL_PRIMS_FILES}
        )


add_library(The-Forge STATIC
        ${FORGE_FILES}
        )

target_include_directories(The-Forge PUBLIC
        ../../The-Forge/Common_3/
        ${RENDER_INCLUDES}
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
	FILES ${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lua.h
	${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/luaconf.h
	${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lualib.h
	${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lauxlib.h
	${LUA_THIRD_PARTY_DIR}/lua-5.3.5/src/lua.hpp
	DESTINATION include
	)
		
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Application/Interfaces/IApp.h
	${THE_FORGE_DIR}/Common_3/Application/Interfaces/ICameraController.h
	${THE_FORGE_DIR}/Common_3/Application/Interfaces/IFont.h
	${THE_FORGE_DIR}/Common_3/Application/Interfaces/IInput.h
	${THE_FORGE_DIR}/Common_3/Application/Interfaces/IMiddleware.h
	${THE_FORGE_DIR}/Common_3/Application/Interfaces/IProfiler.h
	${THE_FORGE_DIR}/Common_3/Application/Interfaces/IScreenshot.h
	${THE_FORGE_DIR}/Common_3/Application/Interfaces/IUI.h
	DESTINATION include/The-Forge/Application/Interfaces
	)

install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Application/Config.h
	DESTINATION include/The-Forge/Application
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Game/Interfaces/IScripting.h
	DESTINATION include/The-Forge/Game/Interfaces
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Game/Scripting/LuaManager.h
	${THE_FORGE_DIR}/Common_3/Game/Scripting/LuaManagerCommon.h
	DESTINATION include/The-Forge/Game/Scripting
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Graphics/Interfaces/IGraphics.h
	${THE_FORGE_DIR}/Common_3/Graphics/Interfaces/IRay.h
	${THE_FORGE_DIR}/Common_3/Graphics/Interfaces/IShaderReflection.h
	DESTINATION include/The-Forge/Graphics/Interfaces
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Graphics/GraphicsConfig.h
	DESTINATION include/The-Forge/Graphics
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Graphics/Direct3D12/Direct3D12Config.h
	DESTINATION include/The-Forge/Graphics/Direct3D12
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
	${THE_FORGE_DIR}/Common_3/OS/Interfaces/IOperatingSystem.h
	DESTINATION include/The-Forge/OS/Interfaces
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/OS/CPUConfig.h
	DESTINATION include/The-Forge/OS
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/OS/ThirdParty/OpenSource/cpu_features/src/cpu_features_types.h
	DESTINATION include/The-Forge/OS/ThirdParty/OpenSource/cpu_features/src
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Renderer/Interfaces/IParticleSystem.h
	${THE_FORGE_DIR}/Common_3/Renderer/Interfaces/IVisibilityBuffer.h
	${THE_FORGE_DIR}/Common_3/Renderer/Interfaces/IVisibilityBuffer2.h
	DESTINATION include/The-Forge/Renderer/Interfaces
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Resources/ResourceLoader/Interfaces/IResourceLoader.h
	DESTINATION include/The-Forge/Resources/ResourceLoader/Interfaces
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Resources/ResourceLoader/ThirdParty/OpenSource/tinyimageformat/tinyimageformat_base.h
	DESTINATION include/The-Forge/Resources/ResourceLoader/ThirdParty/OpenSource/tinyimageformat/
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Utilities/Interfaces/IFileSystem.h
	${THE_FORGE_DIR}/Common_3/Utilities/Interfaces/ILog.h
	${THE_FORGE_DIR}/Common_3/Utilities/Interfaces/IMemory.h
	${THE_FORGE_DIR}/Common_3/Utilities/Interfaces/IThread.h
	${THE_FORGE_DIR}/Common_3/Utilities/Interfaces/ITime.h
	${THE_FORGE_DIR}/Common_3/Utilities/Interfaces/IToolFileSystem.h
	DESTINATION include/The-Forge/Utilities/Interfaces
	)
		
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Utilities/Log/Log.h
	DESTINATION include/The-Forge/Utilities/Log
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Utilities/Math/MathTypes.h
	${THE_FORGE_DIR}/Common_3/Utilities/Math/Random.h
	DESTINATION include/The-Forge/Utilities/Math
	)
	
install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Utilities/Threading/Atomics.h
	DESTINATION include/The-Forge/Utilities/Threading
	)

install(
	FILES 
	${THE_FORGE_DIR}/Common_3/Utilities/RingBuffer.h
	DESTINATION include/The-Forge/Utilities/
	)
	
install(
	DIRECTORY 
	${THE_FORGE_DIR}/Common_3/Utilities/ThirdParty/OpenSource
	DESTINATION include/The-Forge/Utilities/ThirdParty
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
install(TARGETS
	The-Forge
	Lua
	Bstr 
	cJSON 
	RMem 
	Imgui 
	cpu_features
	GaInput
	tools
	lz4
	zstd
	SpirvTools
	DESTINATION lib)

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