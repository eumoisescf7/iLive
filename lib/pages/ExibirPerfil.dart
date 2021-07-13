import 'package:flutter/material.dart';

class ExibirPerfil extends StatefulWidget {
  @override
  _ExibirPerfilState createState() => _ExibirPerfilState();
}

class _ExibirPerfilState extends State<ExibirPerfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          //opacity: 1
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "Perfil Usuário",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
