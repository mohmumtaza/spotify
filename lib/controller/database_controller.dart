import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify/controller/client_controller.dart';

class DatabaseController extends ClientController {
  Databases? databases;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi databases dari Appwrite
    databases = Databases(client);
  }

  Future storeUserName(Map map) async {
    try {
      final result = await databases!.createDocument(
        databaseId: "SpotifyDatabase",
        documentId: ID.unique(),
        collectionId: "SpotifyCollection",
        data: map,
        permissions: [
          Permission.read(Role.user("65685c85656eae4daef8")),
          Permission.update(Role.user("65685c85656eae4daef8")),
          Permission.delete(Role.user("65685c85656eae4daef8")),
        ],
      );
      print("DatabaseController:: storeUserName $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
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
