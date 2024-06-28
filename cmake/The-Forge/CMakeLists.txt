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

include(SpirvTools.cmake)
include(Dependencies.cmake)
include(OS.cmake)
include(Graphics.cmake)
include(TheForge.cmake)

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