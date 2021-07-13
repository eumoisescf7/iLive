import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConectDB extends StatefulWidget {
  @override
  _ConectDBState createState() => _ConectDBState();
}

class _ConectDBState extends State<ConectDB> {

  _recuperarBancoDado() async {

    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco_ilive.db");


    var retorno = await openDatabase(
        localBancoDados,
        version: 1,
        onCreate: (db, dbVersaoRecente){
          String sql = "CREATE TABLE MOVIE (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, descricao VARCHAR, avaliacao INTEGER, ano INTEGER, genero VARCHAR, duracao VARCHAR)";
          db.execute(sql);
        }
    );

    print("aberto " + retorno.isOpen.toString());

  }

  @override
  Widget build(BuildContext context) {

    _recuperarBancoDado();

    return Container();
  }
}
