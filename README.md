NgawiMarket - Responsi 2 Praktikum Pemrograman Mobile <br>

Aplikasi sederhana pengelolaan inventaris barang bahan makanan pada supermarket NgawiMarket yang memiliki fitur login, register, dan CRUD produk.<br> Aplikasi dibangun dengan menggunakan Flutter dan terintegrasi dengan API melalui CodeIgniter3.<br>
Nama: Simon Dimas Pramudya<br>
NIM: H1D023104<br>
Shift Awal : G<br>
Shift Baru : D<br>

Video Demo Aplikasi
Berikut ditampilkan video saat menjalankan aplikasi :<br>
![gif1](https://github.com/Grizzlishe78/Responsi-Pemrograman-Mobile/blob/main/docs/Gif.gif)

Spesifikasi API (API Spec)

Registrasi
| Endpoint | `/registrasi` |
|---|---|
| Method | POST |
| Header | Content-type: application/json |
| Body | `{ "nama":"string", "email":"string", "password":"string" }` |
| Response | `{ "code":200, "status":"boolean", "data":"Registrasi Berhasil" }`

Login
| Endpoint | `/login` |
|---|---|
| Method | POST |
| Header | Content-type: application/json |
| Body | `{ "email":"string", "password":"string" }` |
| Response | `{ "code":200, "status":"boolean", "data":[{"token":"string", "user":{"id":"int", "email":"string"}}] }`

CRUD Barang
1. List Barang

| Endpoint | `/barang` |
|---|---|
| Method | GET |
| Header | Content-type: application/json |
| Body | - |
| Response | `{ "code":200, "status":"boolean", "data":[{"id":"int", "nama":"string", "harga":"int", "jumlah":"int", "tanggal_masuk":"string", "tanggal_kadaluarsa":"string"}] }`

2. Lihat Barang

| Endpoint | `/barang/{id}` |
|---|---|
| Method | GET |
| Header | Content-type: application/json |
| Body | - |
| Response | `{ "code":200, "status":"boolean", "data":[{"id":"int", "nama":"string", "harga":"int", "jumlah":"int", "tanggal_masuk":"string", "tanggal_kadaluarsa":"string"}] }`

3. Tambah Barang

| Endpoint | `/barang` |
|---|---|
| Method | POST |
| Header | Content-type: application/json |
| Body | {"id":"int", "nama":"string", "harga":"int", "jumlah":"int", "tanggal_masuk":"string", "tanggal_kadaluarsa":"string"} |
| Response | `{ "code":200, "status":"boolean", "data":[{"id":"int", "nama":"string", "harga":"int", "jumlah":"int", "tanggal_masuk":"string", "tanggal_kadaluarsa":"string"}] }`

4. Ubah Barang

| Endpoint | `/barang/{id}` |
|---|---|
| Method | PUT |
| Header | Content-type: application/json |
| Body | {"id":"int", "nama":"string", "harga":"int", "jumlah":"int", "tanggal_masuk":"string", "tanggal_kadaluarsa":"string"} |
| Response | `{ "code":200, "status":"boolean", "data":[{"id":"int", "nama":"string", "harga":"int", "jumlah":"int", "tanggal_masuk":"string", "tanggal_kadaluarsa":"string"}] }`

5. Hapus Barang

| Endpoint | `/barang/{id}` |
|---|---|
| Method | DELETE |
| Header | Content-type: application/json |
| Body | - |
| Response | `{ "code":200, "status":"boolean", "data":"Barang berhasil dihapus" }`

Penjelasan Kode

File Penting dan Fungsinya

`lib/main.dart`
- **Fungsi utama**: Entry point aplikasi, mengatur tema (warna hijau), dan pengecekan login (redirect ke halaman barang jika sudah login, login jika belum).
- **Key class**: `MyApp`, `_MyAppState`

`lib/ui/login_page.dart`
- **Fungsi**: Halaman login user dengan validasi email dan password
- **Method penting**: `_submit()` - memanggil `LoginBloc.login()` dan menyimpan token ke SharedPreferences
- **Validasi**: Email harus diisi, password minimal 6 karakter

`lib/ui/registrasi_page.dart`
- **Fungsi**: Halaman registrasi user baru
- **Method penting**: `_submit()` - memanggil `RegistrasiBloc.registrasi()` untuk mendaftarkan user
- **Validasi**: Nama minimal 3 karakter, email valid, password minimal 6 karakter, konfirmasi password harus sama

`lib/ui/barang_page.dart`
- **Fungsi**: Menampilkan daftar semua barang dalam bentuk list
- **Method penting**: `FutureBuilder` - memanggil `BarangBloc.getBarang()` untuk fetch data
- **Fitur**: Tombol tambah (+) untuk menambah barang, drawer untuk logout

`lib/ui/barang_form.dart`
- **Fungsi**: Form untuk tambah/ubah data barang
- **Method penting**: 
  - `simpan()` - membuat barang baru via `BarangBloc.addBarang()`
  - `ubah()` - update barang via `BarangBloc.updateBarang()`
- **Field**: Nama, Harga, Jumlah, Tanggal Masuk, Tanggal Kadaluarsa

`lib/ui/barang_detail.dart`
- **Fungsi**: Menampilkan detail lengkap satu barang dengan opsi edit/hapus
- **Method penting**: `confirmHapus()` - konfirmasi dan hapus barang via `BarangBloc.deleteBarang()`

`lib/bloc/login_bloc.dart`
- **Fungsi**: Business logic untuk login (mengirim request ke API)
- **Method penting**: `LoginBloc.login()` - melakukan autentikasi dan mengembalikan token

`lib/bloc/barang_bloc.dart`
- **Fungsi**: Business logic untuk CRUD barang
- **Method penting**:
  - `getBarang()` - fetch semua barang
  - `addBarang()` - tambah barang baru
  - `updateBarang()` - ubah data barang
  - `deleteBarang()` - hapus barang

`lib/helpers/api.dart`
- **Fungsi**: Helper untuk membuat HTTP request ke API
- **Method penting**: `get()`, `post()`, `put()`, `delete()` - menangani komunikasi dengan backend

`lib/helpers/user_info.dart`
- **Fungsi**: Menyimpan dan mengambil data user dari SharedPreferences (token, userID)
- **Method penting**: `setToken()`, `getToken()`, `setUserID()`, `getUserID()`
