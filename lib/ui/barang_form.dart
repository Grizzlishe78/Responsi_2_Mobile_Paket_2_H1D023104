import 'package:flutter/material.dart';
import 'package:ngawimarket/model/barang.dart';
import 'package:ngawimarket/bloc/barang_bloc.dart';
import 'package:ngawimarket/widget/warning_dialog.dart';
import 'package:provider/provider.dart'; 

class BarangForm extends StatefulWidget {
  Barang? barang;
  BarangForm({Key? key, this.barang}) : super(key: key);

  @override
  _BarangFormState createState() => _BarangFormState();
}

class _BarangFormState extends State<BarangForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false; 

  final _namaTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tanggalMasukTextboxController = TextEditingController();
  final _tanggalkedaluwarsaTextboxController = TextEditingController();

  String judul = "Tambah Inventaris NgawiMart";
  String tombolSubmit = "Simpan Barang";

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      judul = "Ubah Inventaris NgawiMart";
      tombolSubmit = "Ubah Barang";
      _namaTextboxController.text = widget.barang!.nama ?? '';
      _hargaTextboxController.text = widget.barang!.harga?.toString() ?? '';
      _jumlahTextboxController.text = widget.barang!.jumlah?.toString() ?? '';
      _tanggalMasukTextboxController.text = widget.barang!.tanggal_masuk ?? '';
      _tanggalkedaluwarsaTextboxController.text = widget.barang!.tanggal_kedaluwarsa ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildField("Nama Barang", _namaTextboxController),
                    const SizedBox(height: 12),
                    _buildField("Harga", _hargaTextboxController, isNumber: true),
                    const SizedBox(height: 12),
                    _buildField("Jumlah", _jumlahTextboxController, isNumber: true),
                    const SizedBox(height: 12),
                    _buildField("Tanggal Masuk", _tanggalMasukTextboxController),
                    const SizedBox(height: 12),
                    _buildField("Tanggal Kedaluwarsa", _tanggalkedaluwarsaTextboxController),
                    const SizedBox(height: 20),
                    _buttonSubmit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.green.shade50,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: (value) => value!.isEmpty ? "$label harus diisi" : null,
    );
  }

  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.green,
          side: const BorderSide(color: Colors.green),
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(_isLoading ? "Loading..." : tombolSubmit),
        onPressed: () async {
          if (_formKey.currentState!.validate() && !_isLoading) {
            widget.barang != null ? await ubah() : await simpan();
          }
        },
      ),
    );
  }

  Future simpan() async {
    setState(() => _isLoading = true);

    Barang barang = Barang(id: null);
    barang.nama = _namaTextboxController.text;
    barang.harga = int.tryParse(_hargaTextboxController.text) ?? 0;
    barang.jumlah = int.tryParse(_jumlahTextboxController.text) ?? 0;
    barang.tanggal_masuk = _tanggalMasukTextboxController.text;
    barang.tanggal_kedaluwarsa = _tanggalkedaluwarsaTextboxController.text;

    try {
      await BarangBloc.addBarang(barang: barang);
      Navigator.pop(context, true); 
    } catch (e) {
      showDialog(context: context, builder: (_) => const WarningDialog(description: "Simpan gagal, silahkan coba lagi"));
    }

    setState(() => _isLoading = false);
  }

  Future ubah() async {
    setState(() => _isLoading = true);

    Barang barang = Barang(id: widget.barang!.id);
    barang.nama = _namaTextboxController.text;
    barang.harga = int.tryParse(_hargaTextboxController.text) ?? 0;
    barang.jumlah = int.tryParse(_jumlahTextboxController.text) ?? 0;
    barang.tanggal_masuk = _tanggalMasukTextboxController.text;
    barang.tanggal_kedaluwarsa = _tanggalkedaluwarsaTextboxController.text;

    try {
      final barangBloc = Provider.of<BarangBloc>(context, listen: false);
      
      await barangBloc.updateBarang(barang); 
      
      Navigator.pop(context, true); 
    } catch (e) {
      print("ERROR UBBAH DATA: $e");
      showDialog(context: context, builder: (_) => const WarningDialog(description: "Ubah data gagal, silahkan coba lagi"));
    }

    setState(() => _isLoading = false);
  }
}