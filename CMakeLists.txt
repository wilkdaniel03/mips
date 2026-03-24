cmake_minimum_required(VERSION 3.20)
project(mips LANGUAGES CXX)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
find_package(verilator)

add_executable(vmain main.cpp)
verilate(vmain SOURCES rtl/main.sv VERILATOR_ARGS --sc)
target_include_directories(vmain PRIVATE include)
target_link_libraries(vmain PRIVATE systemc)

add_executable(vcounter counter.cpp)
verilate(vcounter SOURCES rtl/counter_tb.sv VERILATOR_ARGS --sc --timing)
target_include_directories(vcounter PRIVATE include)
target_link_libraries(vcounter PRIVATE systemc)

add_executable(vringbuffer ring_buffer.cpp)
verilate(vringbuffer SOURCES rtl/ring_buffer_tb.sv VERILATOR_ARGS --sc --timing)
target_include_directories(vringbuffer PRIVATE include)
target_link_libraries(vringbuffer PRIVATE systemc)

add_executable(vcam cam.cpp)
verilate(vcam SOURCES rtl/cam_tb.sv VERILATOR_ARGS --sc --timing)
target_include_directories(vcam PRIVATE include)
target_link_libraries(vcam PRIVATE systemc)
