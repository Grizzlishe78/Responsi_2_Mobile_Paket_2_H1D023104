import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:ngawimarket/bloc/barang_bloc.dart'; 
import 'package:ngawimarket/ui/login_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BarangBloc()),
      ],
      child: MaterialApp(
        title: 'Ngawi Market',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const LoginPage(), 
      ),
    );
  }
}