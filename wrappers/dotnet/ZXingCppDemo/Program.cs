﻿using System.Collections.Generic;
using ImageMagick;
using ZXingCpp;

public static class ImageMagickBarcodeReader
{
	public static List<Barcode> Read(MagickImage img, ReaderOptions? opts = null)
	{
		var bytes = img.ToByteArray(MagickFormat.Gray);
		var iv = new ImageView(bytes, img.Width, img.Height, ImageFormat.Lum, 0, 0);
		return BarcodeReader.Read(iv, opts);
	}

	public static List<Barcode> Read(this BarcodeReader reader, MagickImage img) => Read(img, reader);
}

public class Program
{
	public static void Main(string[] args)
	{
		var img = new MagickImage(args[0]);
		Console.WriteLine(img);

		var reader = new BarcodeReader() {
			TryInvert = false,
		};

		if (args.Length >= 2)
			reader.Formats = BarcodeReader.FormatsFromString(args[1]);
	
		foreach (var b in reader.Read(img))
			Console.WriteLine($"{b.Format} ({b.ContentType}): {b.Text} / [{string.Join(", ", b.Bytes)}]");
	}
}
