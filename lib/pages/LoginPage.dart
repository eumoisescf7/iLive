import 'package:flutter/material.dart';
import 'package:i_live_project/models/Usuario.dart';
import 'package:i_live_project/service/LoginService.dart';
import 'package:i_live_project/pages/MainPage.dart';
import 'package:i_live_project/pages/CadastrarUsuarioPage.dart';
import 'package:i_live_project/util/CorAppUtil.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'RecuperarSenhaPage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  Usuario usuario = new Usuario();
  var _login = LoginService();

  Future _verificarUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User currentUser =  await auth.currentUser;

    if(currentUser != null){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage())
      ).catchError((onError){
        print("ERRO"+ onError.toString());
      });
    }
  }

  @override
  void initState(){
    _verificarUsuarioLogado();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Color(CorAppUtil.corApp),
        ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container (
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
                      color: Color(CorAppUtil.corApp),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Por favor, insira o email!';
                      }
                      return null;
                    },
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
                    controller: _controllerEmail,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    validator: (senha) {
                      if (senha == null || senha.isEmpty) {
                        return 'Por favor, insira uma senha!';
                      }
                      return null;
                    },
                    obscureText: true,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        labelText: "Senha",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)
                        )
                    ),
                    style: TextStyle(
                        fontSize: 15
                    ),
                    controller: _controllerSenha,
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text("Não tem conta? Cadastre-se!",
                      style: TextStyle(
                          color: Color(CorAppUtil.corApp)
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CadastrarUsuarioPage())
                      );
                    },
                  ),
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
                              primary: Color(CorAppUtil.corApp),
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              )
                          ),
                          onPressed: () {
                            if(_formKey.currentState.validate()){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Realizando login'),
                                      duration: Duration(seconds: 1),
                                  ),
                              );
                              setState(() {
                                usuario.email = _controllerEmail.text;
                                usuario.password = _controllerSenha.text;
                              });
                              _login.realizarLogin(usuario)
                                  .then((value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage())
                              )).catchError((onError){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Erro ao logar, verifique os dados.'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              });
                            }
                          }
                      ),
                      ElevatedButton(
                        child: Text(
                          "Recuperar senha",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecuperarSenhaPage())
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
