import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Base64Convertor {
  static bool isFolderCreated = false;
  static Directory? directory;

  static Future<void> checkDocumentFolder() async {
    try {
      if (!isFolderCreated) {
        directory = await getApplicationDocumentsDirectory();
        // ignore: avoid_slow_async_io
        final bool value = await directory!.exists();
        if (value) {
          await directory!.create();
        }
        isFolderCreated = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<File> downloadPdfFile(String base64PdfString) async {
    final String base64str = base64PdfString;
    final Uint8List bytes = base64.decode(base64str);
    await checkDocumentFolder();
    final String dir =
        '${directory!.path}/${DateTime.now().millisecondsSinceEpoch}.pdf';
    final File file = File(dir);
    if (!file.existsSync()) {
      await file.create();
    }
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<void> openPdfFile(String fileName) async {
    final String dir = '${directory!.path}/$fileName';
    await OpenFile.open(dir);
  }

  Uint8List base64toImage(String base64String) {
    final String base64 = base64String.split(',')[1];
    final Uint8List bytes = const Base64Decoder().convert(base64);
    return bytes;
  }

  String imageToBase64(XFile? image) {
    final Uint8List bytes = File(image!.path).readAsBytesSync();
    final String base64Image = 'data:image/png;base64,${base64Encode(bytes)}';
    return base64Image;
  }

  Future<bool?> saveImageLocally(String imgUrl) async{
    final bool? success = await GallerySaver.saveImage(imgUrl, albumName: 'chatMe');
    print(success);
    return success;
  }


}
