import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class HomePageController extends GetxController {
  File? originalImage; // Original Image
  Uint8List? removedBackgroundImage; // Image After remove Background
  bool isLoading = true;
  final ImagePicker imagePicker = ImagePicker();
  XFile? image;

  Future<XFile?> getImageFromGallery() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    update();
    return image;
  }

  void uploadImage(XFile? xFile) async {
    isLoading = true;
    String fileName = xFile!.path.split('/').last;
    print(fileName);

    FormData formData = FormData.fromMap({
      'source_image_file':
          await MultipartFile.fromFile(xFile.path, filename: fileName)
    });

    Dio dio = Dio();

    Response response = await dio.post(
        'https://api.slazzer.com/v2.0/remove_image_background',
        data: formData,
        options: Options(
            headers: {"API-KEY": "2a32e9fdd7b84201918a306a6af39c8b"},
            responseType: ResponseType.bytes));

    removedBackgroundImage = response.data;
    print('^^^^^^^^^^^^^^^^^ ${response.data.runtimeType}');
    isLoading = false;
    update();
  }
}
