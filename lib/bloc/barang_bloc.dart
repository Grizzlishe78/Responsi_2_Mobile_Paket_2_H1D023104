import 'dart:convert';
import 'package:ngawimarket/helpers/api.dart';
import 'package:ngawimarket/helpers/api_url.dart';
import 'package:ngawimarket/model/barang.dart';

class BarangBloc {
  static Future<List<Barang>> getBarang() async {
    String apiUrl = ApiUrl.listBarang;
    var response = await ApiService().get(apiUrl);
    var jsonObj = json.decode(response);
    List<dynamic> listBarang = jsonObj['data'];

    List<Barang> barangs = listBarang.map((e) => Barang.fromJson(e)).toList();
    return barangs;
  }

  static Future addBarang({Barang? barang}) async {
    String apiUrl = ApiUrl.createBarang;

    var body = jsonEncode({
      'nama': barang?.nama,
      'harga': barang?.harga.toString(),
      'jumlah': barang?.jumlah.toString(),
      'tanggal_masuk': barang?.tanggal_masuk,
      'tanggal_kedaluwarsa': barang?.tanggal_kedaluwarsa,
    });

    var response = await ApiService().post(apiUrl, body);
    var jsonObj = json.decode(response);
    return jsonObj['status'];
  }

  static Future updateBarang({Barang? barang}) async {
    String apiUrl = ApiUrl.updateBarang(int.parse(barang!.id!));

    var body = jsonEncode({
      'nama': barang.nama,
      'harga': barang.harga.toString(),
      'jumlah': barang.jumlah.toString(),
      'tanggal_masuk': barang.tanggal_masuk,
      'tanggal_kedaluwarsa': barang.tanggal_kedaluwarsa,
    });

    var response = await ApiService().put(apiUrl, body);
    var jsonObj = json.decode(response);
    return jsonObj['status'];
  }

  static Future<bool> deleteBarang({int? id}) async {
    String apiUrl = ApiUrl.deleteBarang(id!);

    var response = await ApiService().delete(apiUrl);
    var jsonObj = json.decode(response);
    return jsonObj['status'];
  }
}
