import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i_live_project/models/Usuario.dart';


class LoginService{


  Future realizarLogin(Usuario usuario) async {

    FirebaseAuth auth = FirebaseAuth.instance;

    return auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.password);

  }

  Future logout() async {

    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;

    return auth.signOut();

  }


  Future verificarUsuarioLogado() async {

    FirebaseAuth auth = FirebaseAuth.instance;

    User currentUser =  await auth.currentUser;

    return currentUser;
  }

}