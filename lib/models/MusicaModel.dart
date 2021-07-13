import 'dart:convert';

class MusicaModel {
  int id;
  String name;
  String artist;
  String gender;
  String album;
  String year;
  int rating;
  String image;

  MusicaModel({this.id, this.name, this.artist, this.gender, this.album,
      this.year, this.rating, this.image});

  factory MusicaModel.fromJson(Map<String, dynamic> json){
    return MusicaModel(
      id: json["music"]["id"],
      name: json["music"]["name"],
      artist: json["music"]["artist"],
      gender: json["music"]["gender"],
      album: json["music"]["album"],
      rating: json["music"]["rating"],
      image: json["music"]["image"],
    );
  }
}


