import 'package:flutter/material.dart';
import 'package:i_live_project/pages/MainPage.dart';
import 'package:i_live_project/pages/RecuperarSenha.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffba3d07),
        ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset(
                    "images/logo_size.jpg",
                    width: 100.0,
                    height: 100.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Seja bem-vindo, e viva o agora.",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000000),
                  ),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Login",
                ),
                style: TextStyle(
                    fontSize: 15,
                ),
                controller: null,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Senha"
                ),
                style: TextStyle(
                    fontSize: 15
                ),
                controller: null,
              ),
              Padding(
                padding: EdgeInsets.only(top: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text("Continuar"),
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
                                builder: (context) => MainPage())
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text(
                        "Precisa de ajuda?",
                        style: TextStyle(
                          color: Color(0xffba3d07),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 15
                          )
                      ),
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecuperarSenha())
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
