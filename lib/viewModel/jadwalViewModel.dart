import 'package:absensi_siswa/model/jadwal.dart';
import 'package:absensi_siswa/services/api_services.dart';
import 'package:flutter/material.dart';


class JadwalViewModel {
  final ApiService apiService;

  JadwalViewModel(this.apiService);

  List<Jadwal> jadwal = [];

  Future<void> getJadwal() async {
    try {
      jadwal = await apiService.getJadwal();    
    }  catch (error) {
      print('Failed to get matkul: $error');
    }
  }
}