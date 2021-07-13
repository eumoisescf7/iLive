import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {

  List _listaLivros = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/arq.json');
    final data = await json.decode(response);

    setState(() {
      _listaLivros = data["book"];
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
            _listaLivros.length > 0 ? Expanded(
              child: ListView.separated(
                itemCount: _listaLivros.length,
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
                                "images/${_listaLivros[index]["image"]}",
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
                                        Text(_listaLivros[index]["name"],
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
                                    Text("Sinopse: "+_listaLivros[index]["description"]),
                                    Text("Ano de Lançamento: "+_listaLivros[index]["year"]),
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
                          width: 80.0, // fixed width and height
                          child: Image.asset("images/${_listaLivros[index]["image"]}")
                      ),
                      title: Text(_listaLivros[index]["name"]),
                      subtitle: Text(_listaLivros[index]["description"]),
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
