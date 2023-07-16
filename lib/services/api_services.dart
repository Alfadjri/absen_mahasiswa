import 'dart:convert';
import 'package:absensi_siswa/model/jadwal.dart';
import 'package:absensi_siswa/model/sendOtp.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<String> getTokenFromStorage() async {
    final token = await secureStorage.read(key: 'auth_token');
    if (token == null) {
      throw Exception('Token not found in storage');
    }
    return token;
  }

  Future<String> getIdJadwal() async {
    final idJadwal = await secureStorage.read(key: 'idJadwal');
    if (idJadwal == null) {
      throw Exception('id jadwal tidak ada');
    }
    return idJadwal;
  }

  Future<String> getLevelFromStorage() async {
    final level = await secureStorage.read(key: 'level');
    if(level == null) {
      throw Exception('level tidak ada');
    }
    return level;
  }

  Future<List<Jadwal>> getJadwal() async {
    final token = await getTokenFromStorage();
    final level = await getLevelFromStorage();
    final url = 'http://absensi-siswa-be.sagatech-alpha.com/api/siswa/jadwal';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    final jsonData = json.decode(response.body);
    var data = jsonData['result'];
    print(data);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['result'];
      final List<Jadwal> jadwal = data.map((data) => Jadwal(
        id_jadwal: data['id_jadwal'], 
        judul_pertemuan: data['judul_pertemuan'], 
        jam_masuk: data['jam_masuk'], 
        matakuliah: data['matakuliah'], 
        nama_dosen: data['nama_dosen']
      )).toList();
      return jadwal;
    } else {
      throw Exception('Failed to get');
    }
  }

  Future<void> sendOtp(SendOtp sendOtp) async {
    final token = await getTokenFromStorage();
    final idJadwal = await getIdJadwal();
    final url = 'http://absensi-siswa-be.sagatech-alpha.com/api/siswa/jadwalKuliah/setAbsen';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'id_jadwal' : sendOtp.id_jadwal.toString(),
        'code' : sendOtp.code
      }
    );
    if(response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception('gagal mengirim');
    }
  }
}
