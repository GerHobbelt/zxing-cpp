// Autogenerated from Pigeon (v10.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class CameraConfig {
  CameraConfig({
    required this.textureId,
    required this.previewWidth,
    required this.previewHeight,
  });

  int textureId;

  int previewWidth;

  int previewHeight;

  Object encode() {
    return <Object?>[
      textureId,
      previewWidth,
      previewHeight,
    ];
  }

  static CameraConfig decode(Object result) {
    result as List<Object?>;
    return CameraConfig(
      textureId: result[0]! as int,
      previewWidth: result[1]! as int,
      previewHeight: result[2]! as int,
    );
  }
}

class ScanResult {
  ScanResult({
    this.code,
    required this.cameraImage,
    this.error,
  });

  String? code;

  CameraImage cameraImage;

  String? error;

  Object encode() {
    return <Object?>[
      code,
      cameraImage.encode(),
      error,
    ];
  }

  static ScanResult decode(Object result) {
    result as List<Object?>;
    return ScanResult(
      code: result[0] as String?,
      cameraImage: CameraImage.decode(result[1]! as List<Object?>),
      error: result[2] as String?,
    );
  }
}

class CameraImage {
  CameraImage({
    required this.cropRect,
    required this.width,
    required this.height,
    required this.rotationDegrees,
  });

  CropRect cropRect;

  int width;

  int height;

  int rotationDegrees;

  Object encode() {
    return <Object?>[
      cropRect.encode(),
      width,
      height,
      rotationDegrees,
    ];
  }

  static CameraImage decode(Object result) {
    result as List<Object?>;
    return CameraImage(
      cropRect: CropRect.decode(result[0]! as List<Object?>),
      width: result[1]! as int,
      height: result[2]! as int,
      rotationDegrees: result[3]! as int,
    );
  }
}

class CropRect {
  CropRect({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  int left;

  int top;

  int right;

  int bottom;

  Object encode() {
    return <Object?>[
      left,
      top,
      right,
      bottom,
    ];
  }

  static CropRect decode(Object result) {
    result as List<Object?>;
    return CropRect(
      left: result[0]! as int,
      top: result[1]! as int,
      right: result[2]! as int,
      bottom: result[3]! as int,
    );
  }
}

class ScannerOptions {
  ScannerOptions({
    required this.tryHarder,
    required this.tryRotate,
    required this.tryInvert,
    required this.qrCode,
    required this.cropPercent,
    required this.scanDelay,
    required this.scanDelaySuccess,
  });

  bool tryHarder;

  bool tryRotate;

  bool tryInvert;

  bool qrCode;

  double cropPercent;

  int scanDelay;

  int scanDelaySuccess;

  Object encode() {
    return <Object?>[
      tryHarder,
      tryRotate,
      tryInvert,
      qrCode,
      cropPercent,
      scanDelay,
      scanDelaySuccess,
    ];
  }

  static ScannerOptions decode(Object result) {
    result as List<Object?>;
    return ScannerOptions(
      tryHarder: result[0]! as bool,
      tryRotate: result[1]! as bool,
      tryInvert: result[2]! as bool,
      qrCode: result[3]! as bool,
      cropPercent: result[4]! as double,
      scanDelay: result[5]! as int,
      scanDelaySuccess: result[6]! as int,
    );
  }
}

class _FitatuBarcodeScannerHostApiCodec extends StandardMessageCodec {
  const _FitatuBarcodeScannerHostApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is ScannerOptions) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return ScannerOptions.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class FitatuBarcodeScannerHostApi {
  /// Constructor for [FitatuBarcodeScannerHostApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  FitatuBarcodeScannerHostApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _FitatuBarcodeScannerHostApiCodec();

  Future<void> init(ScannerOptions arg_options) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.FitatuBarcodeScannerHostApi.init', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_options]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> setTorchEnabled(bool arg_isEnabled) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.FitatuBarcodeScannerHostApi.setTorchEnabled', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_isEnabled]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> release() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.FitatuBarcodeScannerHostApi.release', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}

class _FitatuBarcodeScannerFlutterApiCodec extends StandardMessageCodec {
  const _FitatuBarcodeScannerFlutterApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is CameraConfig) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is CameraImage) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is CropRect) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is ScanResult) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return CameraConfig.decode(readValue(buffer)!);
      case 129: 
        return CameraImage.decode(readValue(buffer)!);
      case 130: 
        return CropRect.decode(readValue(buffer)!);
      case 131: 
        return ScanResult.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class FitatuBarcodeScannerFlutterApi {
  static const MessageCodec<Object?> codec = _FitatuBarcodeScannerFlutterApiCodec();

  void onTextureChanged(CameraConfig? cameraConfig);

  void result(ScanResult scanResult);

  void onTorchStateChanged(bool isEnabled);

  static void setup(FitatuBarcodeScannerFlutterApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FitatuBarcodeScannerFlutterApi.onTextureChanged', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FitatuBarcodeScannerFlutterApi.onTextureChanged was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CameraConfig? arg_cameraConfig = (args[0] as CameraConfig?);
          api.onTextureChanged(arg_cameraConfig);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FitatuBarcodeScannerFlutterApi.result', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FitatuBarcodeScannerFlutterApi.result was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final ScanResult? arg_scanResult = (args[0] as ScanResult?);
          assert(arg_scanResult != null,
              'Argument for dev.flutter.pigeon.FitatuBarcodeScannerFlutterApi.result was null, expected non-null ScanResult.');
          api.result(arg_scanResult!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FitatuBarcodeScannerFlutterApi.onTorchStateChanged', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FitatuBarcodeScannerFlutterApi.onTorchStateChanged was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final bool? arg_isEnabled = (args[0] as bool?);
          assert(arg_isEnabled != null,
              'Argument for dev.flutter.pigeon.FitatuBarcodeScannerFlutterApi.onTorchStateChanged was null, expected non-null bool.');
          api.onTorchStateChanged(arg_isEnabled!);
          return;
        });
      }
    }
  }
}
