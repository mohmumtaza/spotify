import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:spotify/controller/api_controller.dart';
import 'package:spotify/controller/api_controllerr.dart';
//import 'package:spotify/model/spotify_api_model.dart';

class MusicLibraryView extends StatefulWidget {
  @override
  _MusicLibraryViewState createState() => _MusicLibraryViewState();
}

class _MusicLibraryViewState extends State<MusicLibraryView> {
  final apiCon = Get.put(apiController());
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        Expanded(
          child: Obx(() {
            final tracks = apiCon.trck
                .where((track) =>
                    track.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                    track.artist.name.toLowerCase().contains(searchQuery.toLowerCase()))
                .toList();

            return ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final musicItem = tracks[index];

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  title: Text(
                    musicItem.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    musicItem.artist.name,
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: Text(
                    musicItem.playcount,
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      musicItem.image[1].text, // Ganti dengan path gambar kecil album musik Anda
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}