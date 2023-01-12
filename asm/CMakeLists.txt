cmake_minimum_required(VERSION 3.8)

enable_language(ASM_NASM)


set(SRCS
        fork.asm
        )


add_library(asm-core STATIC ${SRCS} ${TFHE_CUDA_HEADERS})
set_target_properties(asm-core PROPERTIES COMPILE_FLAGS "")

set(CMAKE_ASM_NASM_FLAGS "")
