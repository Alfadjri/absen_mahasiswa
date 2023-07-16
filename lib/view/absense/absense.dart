import 'package:absensi_siswa/components/loading.dart';
import 'package:absensi_siswa/model/jadwal.dart';
import 'package:absensi_siswa/services/api_services.dart';
import 'package:absensi_siswa/view/absense/hal_absen.dart';
import 'package:absensi_siswa/viewModel/jadwalViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:absensi_siswa/constants/color.dart';
import 'package:absensi_siswa/components/card_jadwal.dart';
import 'package:absensi_siswa/components/navbar_bottom.dart';

class Absense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Absense();
  }
}

class _Absense extends State<Absense> {
  ApiService apiService = ApiService();
  late JadwalViewModel jadwalViewModel;
  List<Jadwal> jadwal = [];
  bool isLoading = false;

  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    jadwal = await apiService.getJadwal();
    setState(() {
      isLoading = true;
    });
  }

  checkStorageContents() async {
    final secureStorage = FlutterSecureStorage();
    final allValues = await secureStorage.readAll();

    if (allValues.isNotEmpty) {
      // Storage is not empty, print the contents
      allValues.forEach((key, value) {
        print('$key: $value');
      });
    } else {
      // Storage is empty
      print('Storage is empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/bg-absense.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 210),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                // child: Image.asset(
                //   "images/abs.png",
                //   fit: BoxFit.cover,
                // ),
                decoration: BoxDecoration(color: app),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jadwal Kelas",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: InkWell(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => Hal_absen()),
                        //   );
                        // },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 13),
                          child: Column(
                            children: [
                              !isLoading ? Loading() : ListView.builder(
                                shrinkWrap: true,
                                itemCount: jadwal.length,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final item = jadwal[index];
                                  print(item);
                                  return Card_Jadwal(
                                    name: jadwal[index].matakuliah,
                                    waktu: jadwal[index].jam_masuk,
                                    onTap: () async {
                                      final storage = FlutterSecureStorage();
                                      var id =
                                          jadwal[index].id_jadwal.toString();
                                      var nama_matkul = jadwal[index].matakuliah.toString();
                                      await storage.write(
                                          key: 'idJadwal', value: id);
                                      await storage.write(key: 'namaMatkul', value: nama_matkul);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Hal_absen()),
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 65, left: 60),
                child: SvgPicture.asset("images/dash.svg"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
