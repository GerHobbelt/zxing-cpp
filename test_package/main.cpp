/**
 *
 * Copyright (c) Microblink Ltd. All rights reserved.
 *
 * ANY UNAUTHORIZED USE OR SALE, DUPLICATION, OR DISTRIBUTION
 * OF THIS PROGRAM OR ANY OF ITS PARTS, IN SOURCE OR BINARY FORMS,
 * WITH OR WITHOUT MODIFICATION, WITH THE PURPOSE OF ACQUIRING
 * UNLAWFUL MATERIAL OR ANY OTHER BENEFIT IS PROHIBITED!
 * THIS PROGRAM IS PROTECTED BY COPYRIGHT LAWS AND YOU MAY NOT
 * REVERSE ENGINEER, DECOMPILE, OR DISASSEMBLE IT.
 */

#include <CoreUtils/Imread.hpp>

#include <ZXing/BarcodeFormat.h>
#include <ZXing/DecodeHints.h>
#include <ZXing/MultiFormatReader.h>
#include <ZXing/GenericLuminanceSource.h>
#include <ZXing/HybridBinarizer.h>
#include <ZXing/Result.h>
#include <ZXing/ResultMetadata.h>
#include <ZXing/TextUtfEncoding.h>

#include <vector>

// based on barcode.cpp from BR Linux App
namespace
{
    std::vector< std::string > getBarcodesZxing( std::uint8_t * const imgBuffer, int width, int height )
    {
        std::vector< std::string > barcodes;

        ZXing::DecodeHints hints;
        hints.setTryHarder(true);
        ZXing::MultiFormatReader reader( hints );

        ZXing::GenericLuminanceSource source( width, height, imgBuffer, width );
        ZXing::HybridBinarizer binImage( std::shared_ptr< ZXing::LuminanceSource >( &source, []( void * ) {} ) );

        auto result{  reader.read( binImage ) };

        if ( result.isValid() )
        {
            barcodes.push_back( ZXing::TextUtfEncoding::ToUtf8( result.text() ) );
        }

        return barcodes;
    }
}

int main( int argc, char ** argv )
{
    if ( argc < 2 )
    {
        std::printf( "Usage %s <image_path>\n", argv[ 0 ] );
        return 1;
    }

    auto const imagePath = argv[ 1 ];
    auto const image = MB::imread< MB::GrayscalePixel >( std::string{ imagePath } );

    if( image.empty() )
    {
        std::printf( "Failed to load %s\n", imagePath );
        return 1;
    }

    auto const results{ getBarcodesZxing( image.bytes(), image.width(), image.height() ) };

    for ( auto && text : results )
    {
        std::printf( "Decoded text:\n%s\n", text.c_str() );
    }

    return 0;
}
