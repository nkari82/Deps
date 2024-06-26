set(THE_FORGE_DIR ../../The-Forge)
set(SPIRVTOOLS_SOURCE
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cfg.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cfg.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cpp.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cpp.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross_parsed_ir.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross_parsed_ir.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross_util.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_cross_util.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_glsl.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_glsl.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_hlsl.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_hlsl.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_msl.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_msl.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_parser.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_parser.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_reflect.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/spirv_reflect.hpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/SpirvTools.cpp
        ${THE_FORGE_DIR}/Common_3/Graphics/ThirdParty/OpenSource/SPIRV_Cross/SpirvTools.h
        )

add_library(SpirvTools STATIC ${SPIRVTOOLS_SOURCE})
set_property(TARGET SpirvTools PROPERTY CXX_STANDARD 17)