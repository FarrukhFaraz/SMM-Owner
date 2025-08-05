


import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

class ScreenshotService {
  static final ScreenshotService _instance = ScreenshotService._internal();
  factory ScreenshotService() => _instance;
  ScreenshotService._internal();

  /// Captures a screenshot of the given widget and returns the image as bytes
  Future<Uint8List?> captureWidget(GlobalKey key) async {
    try {
      // Find the render object
      RenderRepaintBoundary? boundary =
      key.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Widget not found or not rendered');
      }

      // Capture the image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Failed to convert image to bytes');
      }

      return byteData.buffer.asUint8List();
    } catch (e) {
      print('Error capturing widget: $e');
      return null;
    }
  }

  Future<bool> downloadScreenshot(Uint8List imageBytes, String fileName) async {
    try {
      bool hasPermission = await _requestStoragePermission();
      if (!hasPermission) {
        throw Exception('Storage permission denied');
      }

      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        quality: 100,
        name: '${fileName}_$timestamp',
      );

      return result['isSuccess'] == true;
    } catch (e) {
      print('Error downloading screenshot: $e');
      return false;
    }
  }


  /// Creates a temporary file for sharing
  Future<String?> createTempFile(Uint8List imageBytes, String fileName) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = '${tempDir.path}/${fileName}_$timestamp.png';

      File file = File(filePath);
      await file.writeAsBytes(imageBytes);

      return filePath;
    } catch (e) {
      print('Error creating temp file: $e');
      return null;
    }
  }

  /// Requests storage permission
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }

      // For Android 13+ (API 33+), we need different permissions
      if (status.isDenied) {
        var mediaStatus = await Permission.photos.status;
        if (!mediaStatus.isGranted) {
          mediaStatus = await Permission.photos.request();
        }
        return mediaStatus.isGranted;
      }

      return status.isGranted;
    } else if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        status = await Permission.photos.request();
      }
      return status.isGranted;
    }

    return true;
  }

  /// Captures and downloads screenshot in one call
  Future<bool> captureAndDownload(GlobalKey key, String fileName) async {
    try {
      Uint8List? imageBytes = await captureWidget(key);
      if (imageBytes == null) {
        return false;
      }

      return await downloadScreenshot(imageBytes, fileName);
    } catch (e) {
      print('Error in captureAndDownload: $e');
      return false;
    }
  }

  /// Captures and creates temp file for sharing
  Future<String?> captureForSharing(GlobalKey key, String fileName) async {
    try {
      Uint8List? imageBytes = await captureWidget(key);
      if (imageBytes == null) {
        return null;
      }

      return await createTempFile(imageBytes, fileName);
    } catch (e) {
      print('Error in captureForSharing: $e');
      return null;
    }
  }

  /// Cleanup temporary files
  Future<void> cleanupTempFiles() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      List<FileSystemEntity> files = tempDir.listSync();

      for (FileSystemEntity file in files) {
        if (file is File && file.path.contains('transaction_detail_')) {
          // Delete files older than 1 hour
          DateTime fileDate = await file.lastModified();
          if (DateTime.now().difference(fileDate).inHours > 1) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      print('Error cleaning up temp files: $e');
    }
  }


}