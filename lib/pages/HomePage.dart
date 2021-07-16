import 'package:flutter/material.dart';
import 'package:i_live_project/pages/LoginPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset("images/logo_size.jpg"),
            Padding(
                padding: EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(
                      child: Text("ENTRAR"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Color(0xffba3d07),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                        )
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage())
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
