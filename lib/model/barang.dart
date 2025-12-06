import 'dart:convert'; 

class Barang {
  String? id;
  String? nama;
  var harga;
  var jumlah;
  String? tanggal_masuk;
  String? tanggal_kedaluwarsa;

  Barang({
    this.id,
    this.nama,
    this.harga,
    this.jumlah,
    this.tanggal_masuk,
    this.tanggal_kedaluwarsa,
  });

  factory Barang.fromJson(Map<String, dynamic> obj) {
    return Barang(
      id: obj['id'].toString(),
      nama: obj['nama'] ?? '',
      harga: obj['harga'] ?? 0,
      jumlah: obj['jumlah'] ?? 0,
      tanggal_masuk: obj['tanggal_masuk'] ?? '',
      tanggal_kedaluwarsa: obj['tanggal_kedaluwarsa'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga?.toString(),
      'jumlah': jumlah?.toString(),
      'tanggal_masuk': tanggal_masuk,
      'tanggal_kedaluwarsa': tanggal_kedaluwarsa,
    };
  }
}