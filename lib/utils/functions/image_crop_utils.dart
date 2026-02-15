import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImageCropUtils {
  /// Crop image based on frame rectangle relative to screen size
  ///
  /// Parameters:
  /// - [imagePath]: Path to the original image
  /// - [frameRect]: The rectangle frame coordinates (relative to screen)
  /// - [screenSize]: The screen size where camera preview was shown
  /// - [imageSize]: The actual image size from camera
  ///
  /// Returns the path to the cropped image file
  static Future<String?> cropImageToFrame({
    required String imagePath,
    required Rect frameRect,
    required Size screenSize,
    required Size imageSize,
  }) async {
    try {
      // Read the original image
      final File imageFile = File(imagePath);
      final bytes = await imageFile.readAsBytes();
      final img.Image? originalImage = img.decodeImage(bytes);

      if (originalImage == null) {
        debugPrint('Failed to decode image');
        return null;
      }

      // Calculate scale factors
      // Camera image is usually rotated, so we need to handle orientation
      final double scaleX = originalImage.width / screenSize.width;
      final double scaleY = originalImage.height / screenSize.height;

      // Calculate crop rectangle in image coordinates
      final int cropX = (frameRect.left * scaleX).round();
      final int cropY = (frameRect.top * scaleY).round();
      final int cropWidth = (frameRect.width * scaleX).round();
      final int cropHeight = (frameRect.height * scaleY).round();

      // Ensure crop coordinates are within image bounds
      final int safeX = cropX.clamp(0, originalImage.width - 1);
      final int safeY = cropY.clamp(0, originalImage.height - 1);
      final int safeWidth = cropWidth.clamp(1, originalImage.width - safeX);
      final int safeHeight = cropHeight.clamp(1, originalImage.height - safeY);

      debugPrint(
        'Original image size: ${originalImage.width}x${originalImage.height}',
      );
      debugPrint('Screen size: ${screenSize.width}x${screenSize.height}');
      debugPrint('Frame rect: $frameRect');
      debugPrint('Scale: $scaleX x $scaleY');
      debugPrint('Crop rect: x=$safeX, y=$safeY, w=$safeWidth, h=$safeHeight');

      // Crop the image
      final img.Image croppedImage = img.copyCrop(
        originalImage,
        x: safeX,
        y: safeY,
        width: safeWidth,
        height: safeHeight,
      );

      // Save cropped image to temporary file
      final Directory tempDir = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String croppedPath = '${tempDir.path}/cropped_$timestamp.jpg';

      final File croppedFile = File(croppedPath);
      await croppedFile.writeAsBytes(img.encodeJpg(croppedImage, quality: 95));

      debugPrint('Cropped image saved to: $croppedPath');

      return croppedPath;
    } catch (e) {
      debugPrint('Error cropping image: $e');
      return null;
    }
  }

  /// Crop image specifically for KTP frame
  /// Uses standard KTP aspect ratio (8.5:5.4 cm)
  static Future<String?> cropImageForKtp({
    required String imagePath,
    required Size screenSize,
    required Size imageSize,
  }) async {
    // Calculate KTP frame rectangle (same as _KtpFramePainter)
    final frameWidth = screenSize.width * 0.9;
    final frameHeight = frameWidth * (5.4 / 8.5);

    final frameRect = Rect.fromCenter(
      center: Offset(screenSize.width / 2, screenSize.height / 2),
      width: frameWidth,
      height: frameHeight,
    );

    return cropImageToFrame(
      imagePath: imagePath,
      frameRect: frameRect,
      screenSize: screenSize,
      imageSize: imageSize,
    );
  }

  /// Crop image specifically for Selfie + KTP frame
  /// Uses oval for face and rectangle for KTP
  static Future<String?> cropImageForSelfieKtp({
    required String imagePath,
    required Size screenSize,
    required Size imageSize,
  }) async {
    // Calculate full frame rectangle that encompasses both face and KTP
    // For selfie, we want a wider frame
    final frameWidth = screenSize.width * 0.85;
    final frameHeight = screenSize.height * 0.6;

    final frameRect = Rect.fromCenter(
      center: Offset(screenSize.width / 2, screenSize.height / 2),
      width: frameWidth,
      height: frameHeight,
    );

    return cropImageToFrame(
      imagePath: imagePath,
      frameRect: frameRect,
      screenSize: screenSize,
      imageSize: imageSize,
    );
  }

  /// Get image dimensions from file
  static Future<Size?> getImageSize(String imagePath) async {
    try {
      final File imageFile = File(imagePath);
      final bytes = await imageFile.readAsBytes();
      final img.Image? image = img.decodeImage(bytes);

      if (image == null) return null;

      return Size(image.width.toDouble(), image.height.toDouble());
    } catch (e) {
      debugPrint('Error getting image size: $e');
      return null;
    }
  }
}
