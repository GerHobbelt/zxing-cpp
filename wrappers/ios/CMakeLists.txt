set (CMAKE_CXX_STANDARD 11)

# check if we are called from the top-level ZXing project
get_directory_property(hasParent PARENT_DIRECTORY)
if (NOT hasParent)
    option (BUILD_SHARED_LIBS "Link ios library to shared lib" OFF)
    option (BUILD_WRITERS "Build with writer support (encoders)" OFF)
    option (BUILD_READERS "Build with reader support (decoders)" ON)

    # build the main library
    if (NOT BUILD_SHARED_LIBS)
        set(CMAKE_POSITION_INDEPENDENT_CODE ON)
    endif()
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../../core ZXing EXCLUDE_FROM_ALL)

    enable_testing()
endif()

add_library(zxing ZXingReader.cpp include/ZXingReader.h)
target_link_libraries(zxing ZXing::ZXing)
add_custom_target(combined ALL
    COMMAND libtool -static -o ${CMAKE_BINARY_DIR}/libZXing.a $<TARGET_FILE:zxing> $<TARGET_FILE:ZXing::ZXing>
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    DEPENDS zxing ZXing::ZXing
)
