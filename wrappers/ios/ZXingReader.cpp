#include "include/ZXingReader.h"
#include "ReadBarcode.h"
#include "TextUtfEncoding.h"

#include <cstring>
#include <string>
#include <algorithm>
#include <cctype>

#include <string.h>
#include <stdlib.h>
#include <iostream>
#include "BarcodeFormat.h"
using namespace ZXing;

void read_barcode(const uint8_t* bytes, int32_t width, int32_t height, int32_t channels, Format format, ZXingResult* out) {
	DecodeHints hints;
	hints.setFormats(BarcodeFormat(format));
	hints.setTryHarder(0);
	const auto imgfmt = channels == 1 ? ImageFormat::Lum : ImageFormat::BGRX;
	auto r = ReadBarcode({bytes, width, height, imgfmt, width * channels, channels}, hints);
	auto txt = TextUtfEncoding::ToUtf8(r.text());
	out->length = txt.length();	
	strcpy(out->text, txt.c_str());
	out->format = Format(r.format());
}