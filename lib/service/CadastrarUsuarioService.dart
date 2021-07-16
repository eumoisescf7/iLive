import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_live_project/models/Usuario.dart';

class CadastrarUsuarioService {

  Future cadastrarUsuarioService(Usuario usuario) async {

    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;

    return auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.password);
  }

  void salvarDadosUsuario(Usuario usuario) async {

    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    User currentUser =  await auth.currentUser;

    db.collection("usuarios")
      .doc(currentUser.uid)
      .set(usuario.toMap());
  }


}