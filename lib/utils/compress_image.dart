import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:uuid/uuid.dart';

Future<String?> compressImage(File? imageFile, String path) async {
  final tempPath = '$path${const Uuid().v4()}.jpeg';
  if (imageFile != null) {
    final result = await FlutterImageCompress.compressAndGetFile(
      imageFile.absolute.path,
      tempPath,
      quality: 88,
    );
    return result?.path;
  }

  return null;
}
