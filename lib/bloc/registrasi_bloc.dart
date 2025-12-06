import 'dart:convert';
import 'package:ngawimarket/helpers/api.dart';
import 'package:ngawimarket/helpers/api_url.dart';
import 'package:ngawimarket/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi;

    Map<String, dynamic> body = {
      'nama': nama,
      'email': email,
      'password': password,
    };

    var response = await ApiService().post(apiUrl, body);
    var jsonObj = json.decode(response);

    return Registrasi.fromJson(jsonObj);
  }
}
