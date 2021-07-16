import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:i_live_project/models/Usuario.dart';
import 'package:i_live_project/pages/HomePage.dart';
import 'package:i_live_project/service/LoginService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_live_project/util/CorAppUtil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ExibirPerfilPage extends StatefulWidget {
  @override
  _ExibirPerfilPageState createState() => _ExibirPerfilPageState();
}

class _ExibirPerfilPageState extends State<ExibirPerfilPage> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  var _login = new LoginService();
  String _usuarioLogado;
  bool _subindoImagem = false;
  String _urlImagemRecuperada;
  File _imageFile;
  final picker = ImagePicker();
  Usuario usuario = new Usuario();


  Future _recuperarDados() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User currentUser =  await auth.currentUser;
    _usuarioLogado = currentUser.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db
        .collection("usuarios")
        .doc(_usuarioLogado)
        .get();

    Map<String, dynamic> dados = snapshot.data();
    _controllerEmail.text = dados["email"];
    _controllerNome.text = dados["nome"];

    setState(() {
      _urlImagemRecuperada = dados["urlImagem"];
    });
    print("USUARIO    "+_usuarioLogado);

  }

  Future _recuperarImagem(String imagem) async {

    File imagemSelecionada;
    switch( imagem ) {
      case "camera":
        imagemSelecionada = File(await ImagePicker().getImage(source: ImageSource.camera).then((pickedFile) => pickedFile.path));
        break;
      case "galeria":
        imagemSelecionada = File(await ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) => pickedFile.path));
        break;
    }
    setState(() {
      print("Imagem: "+ imagemSelecionada.toString());
      _imageFile = imagemSelecionada;
      if( _imageFile != null){
        _subindoImagem = true;
        _uploadImagem();
      }
    });
  }

  Future _uploadImagem() async {

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz
        .child("perfil")
        .child(_usuarioLogado+".jpg");


    UploadTask task = arquivo.putFile(_imageFile);
    task.snapshotEvents.listen((TaskSnapshot taskSnapshot) {

      if( taskSnapshot.state == TaskState.running ){
        setState(() {
          _subindoImagem = true;
        });
      }else if( taskSnapshot.state == TaskState.success ){
        _recuperarUrlImagem(taskSnapshot);
        setState(() {
          _subindoImagem = false;
        });
      }
    });
  }

  Future _recuperarUrlImagem(TaskSnapshot taskSnapshot) async {
    String url = await taskSnapshot.ref.getDownloadURL();
    _atualizarUrlImagemFireStore(url);
    print("resultado url: "+ url);

    setState(() {
      _urlImagemRecuperada = url;
    });

  }


  _atualizarUrlImagemFireStore(String url){

    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> dadosAtualizar = {
      "urlImagem": url
    };

    db.collection("usuarios")
    .doc(_usuarioLogado)
    .update(dadosAtualizar);
  }


  _atualizarNomeFirebase(){

    String nome = _controllerNome.text;
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, dynamic> dadosAtualizar = {
      "nome": nome
    };

    db.collection("usuarios")
        .doc(_usuarioLogado)
        .update(dadosAtualizar);

  }

  @override
  void initState() {
    super.initState();
    _recuperarDados();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(CorAppUtil.corApp),
        centerTitle: true,
        title: Text(
          "Perfil",
          style: TextStyle(
                color: Colors.white,

            ),
          ),
        ),
      body: Container(
        padding: EdgeInsets.all(16),
        child : SingleChildScrollView(
              child: Column(
            children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: _subindoImagem
                      ? LinearProgressIndicator()
                      : Container(),
                ),
                CircleAvatar(
                    child: Container(
                      child: GestureDetector(
                      onTap: (){
                        _recuperarImagem("camera");
                      },
                      onDoubleTap: (){
                        _recuperarImagem("galeria");
                      },
                    ),
                  ),
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                  _urlImagemRecuperada != null ?
                  NetworkImage(_urlImagemRecuperada)
                      :
                      null
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextField(
                      controller: _controllerNome,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Nome",
                          hintText: "Nome",
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)
                          )
                      ),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextField(
                      enabled: false,
                      controller: _controllerEmail,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Nome",
                          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)
                          )
                      ),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: ElevatedButton(
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          primary: Color(CorAppUtil.corApp),
                          textStyle: TextStyle(
                            fontSize: 15,
                          )
                      ),
                      onPressed: (){
                        _atualizarNomeFirebase();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Atualizações salvas!'),
                            duration: Duration(seconds: 1),
                          ),
                        );},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100, left: 10),
                    child: ElevatedButton(
                      child: Text(
                        "Sair",
                        style: TextStyle(
                          color: Color(CorAppUtil.corApp),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                          primary: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 15
                          )
                      ),
                      onPressed: (){
                        _login.logout().then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage())
                        )).catchError((onError){
                          print("ERRO"+ onError.toString());
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
