import 'package:flutter/material.dart';
import 'package:ngawimarket/bloc/logout_bloc.dart';
import 'package:ngawimarket/bloc/barang_bloc.dart';
import 'package:ngawimarket/model/barang.dart';
import 'package:ngawimarket/ui/login_page.dart';
import 'package:ngawimarket/ui/barang_detail.dart';
import 'package:ngawimarket/ui/barang_form.dart';

class BarangPage extends StatefulWidget {
  const BarangPage({Key? key}) : super(key: key);

  @override
  _BarangPageState createState() => _BarangPageState();
}

class _BarangPageState extends State<BarangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Daftar Inventaris NgawiMart'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarangForm()),
                );
              },
            )
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) =>{
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginPage()), (route) => false)
                });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: BarangBloc.getBarang(),
        builder: (context, snapshot){
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBarang(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        })
    );
  }
}

class ListBarang extends StatelessWidget {
  final List? list;
  const ListBarang({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemBarang(barang: list![i]);
      },
    );
  }
}

class ItemBarang extends StatelessWidget {
  final Barang barang;

  const ItemBarang({Key? key, required this.barang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarangDetail(barang: barang),
          ),
        );
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: ListTile(
          leading: const Icon(Icons.inventory_2, color: Colors.green),
          title: Text(barang.nama!),
          subtitle: Text('Stok : ${barang.jumlah.toString()}'),
          trailing: const Icon(Icons.chevron_right),
        ),
      )
    );
  }
}