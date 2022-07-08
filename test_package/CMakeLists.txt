cmake_minimum_required( VERSION 3.15 )

if( NOT EXISTS "${CMAKE_BINARY_DIR}/mb_conan_build.cmake" )
    message( STATUS "Downloading mb_conan_build.cmake from https://github.com/microblink/conan-build-helper" )
    file( DOWNLOAD "https://raw.githubusercontent.com/microblink/conan-build-helper/master/mb_conan_build.cmake" "${CMAKE_BINARY_DIR}/mb_conan_build.cmake" )
endif()

include( ${CMAKE_BINARY_DIR}/mb_conan_build.cmake )

project( ZXingTest )

build_mobile_exe( ZXingTest ${CMAKE_CURRENT_LIST_DIR} main.cpp )
target_link_libraries( ZXingTest PRIVATE CONAN_PKG::zxing-cpp-br CONAN_PKG::CoreUtils )
