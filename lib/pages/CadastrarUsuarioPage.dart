import 'package:flutter/material.dart';
import 'package:i_live_project/models/Usuario.dart';
import 'package:i_live_project/service/CadastrarUsuarioService.dart';
import 'package:i_live_project/pages/MainPage.dart';



class CadastrarUsuarioPage extends StatefulWidget {
  @override
  _CadastrarUsuarioPageState createState() => _CadastrarUsuarioPageState();
}

class _CadastrarUsuarioPageState extends State<CadastrarUsuarioPage> {


  final _formKeyCadastro = GlobalKey<FormState>();
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  Usuario usuario = new Usuario();
  var _cadastrarUsuario = new CadastrarUsuarioService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cadastro"),
        backgroundColor: Color(0xffba3d07),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKeyCadastro,
        child: Container(
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
                    child: TextFormField(
                      validator: (nome) {
                        if (nome == null || nome.isEmpty) {
                          return 'Por favor, insira o nome!';
                        }
                        return null;
                      },
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          labelText: "Nome",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)
                          )
                      ),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      controller: _controllerNome,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: TextFormField(
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Por favor, insira um email valido!';
                        }
                        return null;
                      },
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
                          return 'Por favor, insira a senha!';
                        }
                        return null;
                      },
                      obscureText: true,
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
                  Padding(
                    padding: EdgeInsets.only(top: 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text("Cadastrar"),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              primary: Color(0xffba3d07),
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              )
                          ),
                          onPressed: (){

                            if(_formKeyCadastro.currentState.validate()){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Realizando login'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              setState(() {
                                usuario.nome = _controllerNome.text;
                                usuario.email = _controllerEmail.text;
                                usuario.password = _controllerSenha.text;
                              });
                              _cadastrarUsuario.cadastrarUsuarioService(usuario)
                                  .then((value) {

                                  _cadastrarUsuario.salvarDadosUsuario(usuario);

                                  Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage())
                                  );
                                  }).catchError((onError){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Erro ao logar, verifique os dados.'),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      )
    );
  }
}
