set(protoc_files
  ${protobuf_SOURCE_DIR}/src/google/protobuf/compiler/main.cc
)

add_executable(protoc ${protoc_files} ${protobuf_version_rc_file})
target_link_libraries(protoc
  libprotoc
  libprotobuf
  ${protobuf_ABSL_USED_TARGETS}
)
add_executable(protobuf::protoc ALIAS protoc)

if (CMAKE_OSX_ARCHITECTURES)
    set_target_properties(protoc PROPERTIES OSX_ARCHITECTURES "x86_64;arm64")
endif()
if(UNIX AND NOT APPLE)
    target_link_libraries(protoc atomic)
endif()
target_link_libraries(protoc ${CMAKE_THREAD_LIBS_INIT})
target_include_directories(protoc PRIVATE src ${CMAKE_CURRENT_BINARY_DIR})
if (CMAKE_USE_PTHREADS_INIT)
    target_compile_definitions(protoc PUBLIC HAVE_PTHREAD)
endif (CMAKE_USE_PTHREADS_INIT)

set_target_properties(protoc PROPERTIES
    VERSION ${protobuf_VERSION})
