import 'dart:convert';
import 'package:flutter/foundation.dart'; 
import 'package:ngawimarket/helpers/api.dart'; 
import 'package:ngawimarket/helpers/api_url.dart';
import 'package:ngawimarket/model/barang.dart';

class BarangBloc extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  static Future<List<Barang>> getBarang() async {
    String apiUrl = ApiUrl.listBarang;
    ApiService apiService = ApiService(); 

    var response = await apiService.get(apiUrl);
    var jsonObj = json.decode(response);

    List<dynamic> listBarang = jsonObj['data'];
    return listBarang.map((e) => Barang.fromJson(e)).toList();
  }

  static Future addBarang({Barang? barang}) async {
    String apiUrl = ApiUrl.createBarang;
    ApiService apiService = ApiService();

    Map<String, dynamic> body = barang?.toJson() ?? {};
    
    body.remove('id'); 

    var response = await apiService.post(apiUrl, body);
    var status = json.decode(response)['status'] ?? false;
    return status;
  }

  Future updateBarang(Barang barang) async {
    isLoading = true; 
    ApiService apiService = ApiService();

    var body = barang.toJson(); 
    var id = body.remove('id') as String?; 

    if (id == null) {
      isLoading = false;
      throw Exception("ID Barang tidak boleh null untuk update.");
    }
    
    print("URL PUT DIKIRIM: ${ApiUrl.updateBarang(id)}");
    print("BODY PUT DIKIRIM: $body");

    try {
      var response = await apiService.put(ApiUrl.updateBarang(id), body);
      isLoading = false;
      return response;
    } catch (e) {
      isLoading = false;
      rethrow;
    }
}

  static Future<bool> deleteBarang({String? id}) async {
    if (id == null) return false;
    
    ApiService apiService = ApiService();
    String apiUrl = ApiUrl.deleteBarang(id);
    
    var response = await apiService.delete(apiUrl);

    return json.decode(response)['status'] ?? false;
  }
}