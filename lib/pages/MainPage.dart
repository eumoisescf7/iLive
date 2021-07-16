import 'package:flutter/material.dart';
import 'package:i_live_project/pages/ExibirPerfilPage.dart';
import 'package:i_live_project/pages/MoviePage.dart';
import 'package:i_live_project/pages/MusicPage.dart';
import 'package:i_live_project/pages/BookPage.dart';
import 'package:i_live_project/data/ConectDB.dart';
import 'package:i_live_project/util/CorAppUtil.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      MoviePage(),
      MusicPage(),
      BookPage()
    ];

    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //whitout back Button
        iconTheme: IconThemeData(
          color: Colors.grey,
          //opacity: 1
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          "images/logo_size.jpg",
          width: 60,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                print("ação: pesquisar");
              },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            color: Color(CorAppUtil.corApp),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExibirPerfilPage())
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: pages[_indiceAtual],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.shifting, //mais de tres navigationBar
          type: BottomNavigationBarType.fixed, //até três navigationBar
          fixedColor: Color(CorAppUtil.corApp),
          currentIndex: _indiceAtual,
          onTap: (indice){
            print(indice);
            setState(() {
              _indiceAtual = indice;
            });
          },
          items: [
            BottomNavigationBarItem(
              //backgroundColor: Color(0xffba3d07),
                title: Text("Filmes"),
                icon: Icon(Icons.movie)
            ),
            BottomNavigationBarItem(
              //backgroundColor: Color(0xffba3d07),
                title: Text("Música"),
                icon: Icon(Icons.music_note)
            ),
            BottomNavigationBarItem(
              //backgroundColor: Color(0xffba3d07),
                title: Text("Livros"),
                icon: Icon(Icons.menu_book_outlined)
            ),
          ]
      ),
    );
  }
}
