// To parse this JSON data, do
//
//     final spotifyApi = spotifyApiFromJson(jsonString);

import 'dart:convert';

SpotifyApi spotifyApiFromJson(String str) =>
    SpotifyApi.fromJson(json.decode(str));

String spotifyApiToJson(SpotifyApi data) => json.encode(data.toJson());

class SpotifyApi {
  Toptracks toptracks;

  SpotifyApi({
    required this.toptracks,
  });

  factory SpotifyApi.fromJson(Map<String, dynamic> json) => SpotifyApi(
        toptracks: Toptracks.fromJson(json["toptracks"]),
      );

  Map<String, dynamic> toJson() => {
        "toptracks": toptracks.toJson(),
      };
}

class Toptracks {
  List<Track> track;
  ToptracksAttr attr;

  Toptracks({
    required this.track,
    required this.attr,
  });

  factory Toptracks.fromJson(Map<String, dynamic> json) => Toptracks(
        track: List<Track>.from(json["track"].map((x) => Track.fromJson(x))),
        attr: ToptracksAttr.fromJson(json["@attr"]),
      );

  Map<String, dynamic> toJson() => {
        "track": List<dynamic>.from(track.map((x) => x.toJson())),
        "@attr": attr.toJson(),
      };
}

class ToptracksAttr {
  String artist;
  String page;
  String perPage;
  String totalPages;
  String total;

  ToptracksAttr({
    required this.artist,
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.total,
  });

  factory ToptracksAttr.fromJson(Map<String, dynamic> json) => ToptracksAttr(
        artist: json["artist"],
        page: json["page"],
        perPage: json["perPage"],
        totalPages: json["totalPages"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "artist": artist,
        "page": page,
        "perPage": perPage,
        "totalPages": totalPages,
        "total": total,
      };
}

class Track {
  String name;
  String playcount;
  String listeners;
  String? mbid;
  String url;
  String streamable;
  ArtistClass artist;
  List<Image> image;
  TrackAttr attr;

  Track({
    required this.name,
    required this.playcount,
    required this.listeners,
    this.mbid,
    required this.url,
    required this.streamable,
    required this.artist,
    required this.image,
    required this.attr,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        name: json["name"],
        playcount: json["playcount"],
        listeners: json["listeners"],
        mbid: json["mbid"],
        url: json["url"],
        streamable: json["streamable"],
        artist: ArtistClass.fromJson(json["artist"]),
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        attr: TrackAttr.fromJson(json["@attr"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "playcount": playcount,
        "listeners": listeners,
        "mbid": mbid,
        "url": url,
        "streamable": streamable,
        "artist": artist.toJson(),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "@attr": attr.toJson(),
      };
}

class ArtistClass {
  String name;
  String mbid;
  String url;

  ArtistClass({
    required this.name,
    required this.mbid,
    required this.url,
  });

  factory ArtistClass.fromJson(Map<String, dynamic> json) => ArtistClass(
        name: json["name"],
        mbid: json["mbid"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mbid": mbid,
        "url": url,
      };
}

class TrackAttr {
  String rank;

  TrackAttr({
    required this.rank,
  });

  factory TrackAttr.fromJson(Map<String, dynamic> json) => TrackAttr(
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
      };
}

class Image {
  String text;
  Size size;

  Image({
    required this.text,
    required this.size,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        text: json["#text"],
        size: sizeValues.map[json["size"]]!,
      );

  Map<String, dynamic> toJson() => {
        "#text": text,
        "size": sizeValues.reverse[size],
      };
}

enum Size { EXTRALARGE, LARGE, MEDIUM, SMALL }

final sizeValues = EnumValues({
  "extralarge": Size.EXTRALARGE,
  "large": Size.LARGE,
  "medium": Size.MEDIUM,
  "small": Size.SMALL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
