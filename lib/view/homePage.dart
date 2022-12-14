import 'dart:io';
import 'package:background_remover/constants.dart';
import 'package:background_remover/control/homePageController.dart';
import 'package:background_remover/view/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePageController controller = Get.put(HomePageController());
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Image Picker from Gallery"),
          backgroundColor: PRIMARY_COLOR),
      body: GetBuilder<HomePageController>(
        builder: (controller) => Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          alignment: Alignment.topCenter,
          child: ListView(
            children: [
              controller.image == null
                  ? Container(
                      child: const Text(
                        'No Image',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Image.file(
                        File(controller.image!.path),
                        fit: BoxFit.contain,
                      ),
                    ),
              SizedBox(
                height: width * 0.06,
              ),
              SizedBox(
                width: width,
                height: 50,
                child: CustomButton(
                    icon: const Icon(Icons.add),
                    onpressed: () async {
                      controller.getImageFromGallery();
                    },
                    text: "Pick Image"),
              ),
              SizedBox(
                height: width * 0.06,
              ),
              Divider(height: 2, color: PRIMARY_COLOR, thickness: 2),
              SizedBox(
                height: width * 0.06,
              ),
              SizedBox(
                width: width,
                height: 50,
                child: CustomButton(
                    icon: const Icon(Icons.upload),
                    onpressed: () async {
                      controller.uploadImage(controller.image);
                    },
                    text: "Upload And Get Removed Backgrund Image"),
              ),
              SizedBox(
                height: width * 0.06,
              ),
              controller.removedBackgroundImage == null
                  ? Container(
                      child: const Text(
                        'No Image',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : (controller.isLoading)
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Image.memory(
                            controller.removedBackgroundImage!,
                            fit: BoxFit.contain,
                          ),
                        ),
              SizedBox(
                height: width * 0.06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
