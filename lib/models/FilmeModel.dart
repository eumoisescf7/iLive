import 'dart:convert';

class FilmeModel {

  int id;
  String name;
  String description;
  String year;
  double rating;
  String image;

  FilmeModel({this.id, this.name, this.description, this.year, this.rating, this.image});

  factory FilmeModel.fromJson(Map<String, dynamic> json){
    return FilmeModel(
      id: json["movie"]["id"],
      name: json["movie"]["name"],
      description: json["movie"]["description"],
      year: json["movie"]["year"],
      rating: json["movie"]["rating"],
      image: json["movie"]["image"],
    );
  }
}
