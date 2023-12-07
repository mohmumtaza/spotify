import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/controller/client_controller.dart';

class StorageController extends ClientController {
  Storage? storage;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi storage dari Appwrite
    storage = Storage(client);
  }

  Future storeImage() async {
    try {
      final result = await storage!.createFile(
        bucketId: '[65685cb95e548a711ca1]',
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: './path-to-files/image.jpg',
          filename: 'image.jpg',
        ),
      );
      print("StorageController:: storeImage $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Storage",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}
