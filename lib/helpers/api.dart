import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'user_info.dart';
import 'app_exception.dart';

class ApiService {
  Future<dynamic> get(String url) async {
    String? token = await UserInfo().getToken();

    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  Future<dynamic> post(String url, dynamic data) async {
    String? token = await UserInfo().getToken();

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: data,
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  Future<dynamic> put(String url, dynamic data) async {
    String? token = await UserInfo().getToken();

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: data,
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  Future<dynamic> delete(String url) async {
    String? token = await UserInfo().getToken();

    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      default:
        throw FetchDataException(
          "Error occurred while communicating with server. Status Code: ${response.statusCode}",
        );
    }
  }
}
