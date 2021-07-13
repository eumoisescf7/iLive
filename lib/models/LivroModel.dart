import 'dart:convert';

class LivroModel {

  int id;
  String name;
  String description;
  String year;
  double rating;
  String image;

  LivroModel({this.id, this.name, this.description, this.year, this.rating, this.image});


  factory LivroModel.fromJson(Map<String, dynamic> json){
    return LivroModel(
      id: json["book"]["id"],
      name: json["book"]["name"],
      description: json["book"]["description"],
      year: json["book"]["year"],
      rating: json["book"]["rating"],
      image: json["book"]["image"],
    );
  }

}
