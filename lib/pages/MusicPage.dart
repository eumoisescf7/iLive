import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {

  List _listaMusicas = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/arq.json');
    final data = await json.decode(response);

    setState(() {
      _listaMusicas = data["music"];
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
            _listaMusicas.length > 0 ? Expanded(
              child: ListView.separated(
                itemCount: _listaMusicas.length,
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
                            return AlertDialog(

                              title: Image.asset(
                                "images/${_listaMusicas[index]["image"]}",
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(_listaMusicas[index]["name"],
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
                                    Text("Artista: "+_listaMusicas[index]["artist"]),
                                    Text("Gênero: "+_listaMusicas[index]["gender"]),
                                    Text("Álbum: "+_listaMusicas[index]["album"]),
                                    Text("Ano de Lançamento: "+_listaMusicas[index]["year"]),
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
                            );
                          }
                      );
                    },
                    child: ListTile(
                        leading: SizedBox(
                            height: 100.0,
                            width: 80.0, // fixed width and height
                            child: Image.asset("images/${_listaMusicas[index]["image"]}")
                        ),
                      title: Text(_listaMusicas[index]["name"]),
                      subtitle: Text(_listaMusicas[index]["artist"]),
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
