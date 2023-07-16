import 'package:absensi_siswa/view/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:absensi_siswa/components/navbar_bottom.dart';
import 'package:absensi_siswa/view/absense/hal_absen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String _userRole = '';
  final secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    getLevelFromStorage(); // Memuat peran pengguna saat widget diinisialisasi
  }

   Future<void> getLevelFromStorage() async {
    final level = await secureStorage.read(key: 'level');
    if(level == null) {
      throw Exception('level tidak ada');
    }
    setState(() {
      _userRole = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      initialRoute: '/loginpage',
      routes: {
        '/absense': (context) => Navbar_bottom(),
        '/hal_absen':(context) => Hal_absen(),
      }
    );
  }
}

