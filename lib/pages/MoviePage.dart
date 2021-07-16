import 'dart:convert';
import 'dart:async';
import 'package:i_live_project/models/FilmeModel.dart';
import 'package:flutter/material.dart';
import 'package:i_live_project/data/DataSet.dart';
import 'package:flutter/services.dart' show rootBundle;


class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List _listaFilmes = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/arq.json');
    final data = await json.decode(response);

    setState(() {
      _listaFilmes = data["movie"];
    });
    // ...
  }

  @override
  Widget build(BuildContext context) {

    readJson();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // Display the data loaded from sample.json
            _listaFilmes.length > 0 ? Expanded(
              child: ListView.separated(
                itemCount: _listaFilmes.length,
                separatorBuilder: (context, index) => Divider(
                  /*height: 20,
                  color: Colors.white,*/
                ),
                itemBuilder: (context, index) {

                  return GestureDetector(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return  SingleChildScrollView(
                             padding: EdgeInsets.all(10),
                                child: AlertDialog(

                              title: Image.asset(
                                "images/${_listaFilmes[index]["image"]}",
                                height: 100.0,
                                width: 60.0,
                              ),

                              titlePadding: EdgeInsets.all(20),
                              titleTextStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.deepOrange
                              ),
                              content: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(_listaFilmes[index]["name"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.deepOrange
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                    ),
                                    Text("Descrição: "+_listaFilmes[index]["description"]),
                                    Text("Ano de Lancamento: "+_listaFilmes[index]["year"]),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text("Fechar"),
                                  style: TextButton.styleFrom(
                                    primary: Colors.deepOrange,
                                  ),
                                ),
                              ],
                            )
                            );
                          }
                      );
                    },
                    child: ListTile(
                      leading: SizedBox(
                          height: 100.0,
                          width: 100.0, // fixed width and height
                          child: Image.asset("images/${_listaFilmes[index]["image"]}")
                      ),
                      title: Text(_listaFilmes[index]["name"]),
                      subtitle: Text(_listaFilmes[index]["description"]),
                    ),
                  );
                },
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}



