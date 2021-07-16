import 'package:flutter/material.dart';
import 'package:i_live_project/models/Usuario.dart';
import 'package:i_live_project/util/CorAppUtil.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecuperarSenhaPage extends StatefulWidget {

  @override
  _RecuperarSenhaPageState createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {

  String _email, _senha;
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Recuperar Senha"),
        backgroundColor: Color(CorAppUtil.corApp),
      ),
      backgroundColor: Colors.white,
      body: Column(
          children: <Widget>[
            Container (
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
                      padding: EdgeInsets.only(bottom: 8),
                      child: TextField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)
                            )
                        ),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ElevatedButton(
                            child: Text(
                              "Recuperar Solicitar",
                              style: TextStyle(
                                color: Color(CorAppUtil.corApp),
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
                              auth.sendPasswordResetEmail(email: _email);
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
      )
    );
  }
}
