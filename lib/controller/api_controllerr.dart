import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:spotify/model/SpofityAPIModel.dart';

class apiController extends GetxController {
  static const APIKEY = "985e1f22b7eb3f6582e3e703478fd28f";
  static const url =
      "http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=cher&api_key=$APIKEY&format=json";

  RxList<Toptracks> ttr = RxList([]);
  RxList<Track> trck = RxList([]);
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetch();
    for (int i = 0; i < trck.length; i++) {
      print(trck[i]);
    }
  }

  Future<void> fetch() async {
    try {
      final response = await GetConnect().get(url);
      if (response.statusCode == 200) {
        ttr.add(SpotifyApi.fromJson(json.decode(json.encode(response.body)))
            .toptracks);
        trck.value = ttr.first.track;
      }
      ;
    } catch (e) {
      print(e);
    } finally {}
  }
}
