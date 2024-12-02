import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:icragee_mobile/utility/generate_random_string.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageHelpers {
  final ImagePicker _imagePicker;

  ImageHelpers({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  Future<XFile?> pickImage(
      {ImageSource source = ImageSource.gallery,
      int imageQuality = 100}) async {
    return await _imagePicker.pickImage(
        source: source, imageQuality: imageQuality);
  }

  static Future<Image> xFileToImage({required XFile xFile}) async {
    final tempDir = await getTemporaryDirectory();
    String fileName = generateRandomString(length: 20);
    File file = await File('${tempDir.path}/$fileName.png').create();
    file.writeAsBytesSync(await xFile.readAsBytes());

    return Image.file(file);
  }

  static Future<File> imageToFile({required ui.Image image}) async {
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = data!.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final String path = generateRandomString(length: 20);
    File file = await File('${tempDir.path}/$path.png').create();

    file.writeAsBytesSync(bytes);

    return file;
  }
}
