import 'dart:convert';
import 'package:ngawimarket/helpers/api.dart';
import 'package:ngawimarket/helpers/api_url.dart';
import 'package:ngawimarket/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;

    Map<String, dynamic> body = {
      'email': email,
      'password': password,
    };

    var response = await ApiService().postForm(apiUrl, body);
    var jsonObj = json.decode(response);

    return Login.fromJson(jsonObj);
  }
}
