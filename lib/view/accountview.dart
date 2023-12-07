import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import 'package:image_picker/image_picker.dart'; 
import 'dart:io'; 
 
class UserProfileView extends StatelessWidget { 
  final ProfileController profileController = ProfileController(); 
 
  Future<void> _pickImage(ImageSource source) async { 
    final pickedFile = await ImagePicker().pickImage(source: source); 
 
    if (pickedFile != null) { 
      final imageUrl = pickedFile.path; 
      profileController.setImageUrl(imageUrl); 
    } 
  } 
 
  Future<void> _showImageSourceDialog(BuildContext context) async { 
    return showDialog<void>( 
      context: context, 
      builder: (BuildContext context) { 
        return AlertDialog( 
          title: Text('Pilih Sumber Gambar'), 
          content: SingleChildScrollView( 
            child: ListBody( 
              children: <Widget>[ 
                ElevatedButton( 
                  onPressed: () { 
                    Navigator.of(context).pop(); 
                    _pickImage(ImageSource.gallery); 
                  }, 
                  child: Text('Galeri'), 
                ), 
                ElevatedButton( 
                  onPressed: () { 
                    Navigator.of(context).pop(); 
                    _pickImage(ImageSource.camera); 
                  }, 
                  child: Text('Kamera'), 
                ), 
              ], 
            ), 
          ), 
        ); 
      }, 
    ); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    return Container( 
      margin: EdgeInsets.all(20.0), 
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.start, 
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [ 
          Obx(() { 
            final imageUrl = profileController.imageUrl.value; 
            return GestureDetector( 
              onTap: () => _showImageSourceDialog(context), 
              child: Row( 
                children: [ 
                  CircleAvatar( 
                    radius: 25, 
                    backgroundImage: 
                        imageUrl.isNotEmpty ? FileImage(File(imageUrl)) : null, 
                  ), 
                  SizedBox(width: 10), 
                  Text( 
                    'Guest', // Ganti 'Username' dengan username yang sebenarnya 
                    style: TextStyle(fontSize: 25), 
                  ), 
                ], 
              ), 
            ); 
          }), 
        ], 
      ), 
    ); 
  } 
} 
 
class ProfileController extends GetxController { 
  RxString imageUrl = ''.obs; 
 
  void setImageUrl(String url) { 
    imageUrl.value = url; 
  } 
}