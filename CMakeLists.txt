cmake_minimum_required(VERSION 3.14)
project(fork C)

set(CMAKE_C_STANDARD 11)

#For debugging
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_RULE_MESSAGES ON)

add_subdirectory(asm)


add_executable(fork main.c)
TARGET_LINK_LIBRARIES(fork asm-core)
target_compile_options(fork PUBLIC -O3)
target_link_options(fork PUBLIC -O3)