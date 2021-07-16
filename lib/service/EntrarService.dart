import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:i_live_project/constants/auth.dart';

class EntrarService {

  signUp(String email, String password) async {

    var url = Uri.parse(Routes.urlSignUp);
    http.Response response = await http.post(
        url,
        body: jsonEncode(
          {"email": email,
          "password": password,
          "returnSecureToken": true
          },
        )
    );
    print(response.body);
  }
}