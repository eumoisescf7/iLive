import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:i_live_project/models/FilmeModel.dart';
import 'package:i_live_project/models/LivroModel.dart';
import 'package:i_live_project/models/MusicaModel.dart';



class DataSet{


  Future<List<FilmeModel>> readJsonFilme() async {

    final String response = await rootBundle.loadString('assets/arq.json');
    final data = await json.decode(response);

    print(data["movie"]);

    Map<String, dynamic> dadosJson = json.decode(data);

    List<FilmeModel> _listaFilmes = dadosJson["movie"].map<FilmeModel>(
            (map) {
          print(map);
          return FilmeModel.fromJson(map);
        }
    ).toList();

    return _listaFilmes;
  }


  Future<List<MusicaModel>> readJsonMusica() async {

    final String response = await rootBundle.loadString('assets/arq.json');
    final data = await json.decode(response);

    print(data["music"]);

    Map<String, dynamic> dadosJson = json.decode(data);

    List<MusicaModel> _listaMusica = dadosJson["music"].map<MusicaModel>(
            (map) {
          print(map);
          return MusicaModel.fromJson(map);
        }
    ).toList();

    return _listaMusica;
  }


  Future<List<LivroModel>> readJsonLivro() async {

    final String response = await rootBundle.loadString('assets/arq.json');
    final data = await json.decode(response);

    print(data["book"]);

    Map<String, dynamic> dadosJson = json.decode(data);

    List<LivroModel> _listaLivros = dadosJson["book"].map<LivroModel>(
            (map) {
          print(map);
          return LivroModel.fromJson(map);
        }
    ).toList();

    return _listaLivros;
  }

}