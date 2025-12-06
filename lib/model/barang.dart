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
      id: obj['id'],
      nama: obj['nama'],
      harga: obj['harga'],
      jumlah: obj['jumlah'],
      tanggal_masuk: obj['tanggal_masuk'],
      tanggal_kedaluwarsa: obj['tanggal_kedaluwarsa'],
    ); 
  }
}