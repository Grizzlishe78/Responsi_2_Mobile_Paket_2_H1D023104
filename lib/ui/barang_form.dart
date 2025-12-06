import 'package:flutter/material.dart';
import 'package:ngawimarket/model/barang.dart';
import 'package:ngawimarket/bloc/barang_bloc.dart';
import 'package:ngawimarket/ui/barang_page.dart';
import 'package:ngawimarket/widget/warning_dialog.dart';

class BarangForm extends StatefulWidget {
  Barang? barang;
  BarangForm({Key? key, this.barang}) : super(key: key);
  @override
  _BarangFormState createState() => _BarangFormState();
}

class _BarangFormState extends State<BarangForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Inventaris NgawiMart";
  String tombolSubmit = "Simpan Barang";
  final _namaTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tanggalMasukTextboxController = TextEditingController();
  final _tanggalkedaluwarsaTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.barang != null) {
      setState(() {
        judul = "Ubah Inventaris NgawiMart";
        tombolSubmit = "Ubah Barang";
        _namaTextboxController.text = widget.barang!.nama ?? '';
        _hargaTextboxController.text = widget.barang!.harga?.toString() ?? '';
        _jumlahTextboxController.text = widget.barang!.jumlah?.toString() ?? '';
        _tanggalMasukTextboxController.text = widget.barang!.tanggal_masuk ?? '';
        _tanggalkedaluwarsaTextboxController.text = widget.barang!.tanggal_kedaluwarsa ?? '';
      });
    } else {
      setState(() {
        judul = "Tambah Inventaris NgawiMart";
        tombolSubmit = "Simpan Barang";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(judul),
      ),
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
                    _namaTextField(),
                    const SizedBox(height: 12),
                    _hargaTextField(),
                    const SizedBox(height: 12),
                    _jumlahTextField(),
                    const SizedBox(height: 12),
                    _tanggalMasukTextField(),
                    const SizedBox(height: 12),
                    _tanggalkedaluwarsaTextField(),
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

  Widget _namaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Barang",
        filled: true,
        fillColor: Colors.green.shade50,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nama Barang harus diisi';
        }
        return null;
      },
    );
  }

  Widget _hargaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Harga",
        filled: true,
        fillColor: Colors.green.shade50,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Harga harus diisi';
        }
        return null;
      },
    );
  }

  Widget _jumlahTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Jumlah",
        filled: true,
        fillColor: Colors.green.shade50,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _jumlahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Jumlah harus diisi';
        }
        return null;
      },
    );
  }

  Widget _tanggalMasukTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tanggal Masuk",
        filled: true,
        fillColor: Colors.green.shade50,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _tanggalMasukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tanggal Masuk harus diisi';
        }
        return null;
      },
    );
  }

  Widget _tanggalkedaluwarsaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tanggal kedaluwarsa",
        filled: true,
        fillColor: Colors.green.shade50,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _tanggalkedaluwarsaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tanggal kedaluwarsa harus diisi';
        }
        return null;
      },
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
        child: Text(_isLoading ? 'Loading...' : tombolSubmit),
        onPressed:(){
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.barang != null) {
              // kondisi update produk
              ubah();
            } else {
              // kondisi tambah produk
              simpan();
            }
          }
        }
        },
      ),
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Barang createBarang = Barang(id: null);
    createBarang.nama = _namaTextboxController.text;
    createBarang.harga = int.parse(_hargaTextboxController.text);
    createBarang.jumlah = int.parse(_jumlahTextboxController.text);
    createBarang.tanggal_masuk = _tanggalMasukTextboxController.text;
    createBarang.tanggal_kedaluwarsa = _tanggalkedaluwarsaTextboxController.text;
    BarangBloc.addBarang(barang: createBarang).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const BarangPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Barang updateBarang = Barang(id: widget.barang!.id!);
    updateBarang.nama = _namaTextboxController.text;
    updateBarang.harga = int.parse(_hargaTextboxController.text);
    updateBarang.jumlah = int.parse(_jumlahTextboxController.text);
    updateBarang.tanggal_masuk = _tanggalMasukTextboxController.text;
    updateBarang.tanggal_kedaluwarsa = _tanggalkedaluwarsaTextboxController.text;
    BarangBloc.updateBarang(barang: updateBarang).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const BarangPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }
}