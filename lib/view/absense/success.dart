import 'package:absensi_siswa/view/absense/absense.dart';
import 'package:absensi_siswa/view/absense/hal_absen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:absensi_siswa/constants/color.dart';
import 'package:absensi_siswa/components/card_jadwal.dart';
import 'package:absensi_siswa/components/navbar_bottom.dart';

class SuccessAbsense extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SuccessAbsense();
  }
}

class _SuccessAbsense extends State<SuccessAbsense> {
  final storage = FlutterSecureStorage();
  String nama = '';
  late DateTime currentTime;

  @override
   void initState() {
    super.initState();
    currentTime = DateTime.now();
    getNamaMatkul(); // Memuat data saat widget diinisialisasi
  }

  Future<void> getNamaMatkul() async {
    final namaMatkul = await storage.read(key: 'namaMatkul');
    if (namaMatkul == null) {
      throw Exception('id jadwal tidak ada');
    }
    setState(() {
      nama = namaMatkul;
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentHour = currentTime.hour;
    int currentMinute = currentTime.minute;
    print(currentHour);
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
            padding: const EdgeInsets.only(top: 150),
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Text("BERHASIL",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 50,
                      ),
                      SvgPicture.asset("images/img-success.svg"),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Anda berhasil melakukan absen untuk",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "mata kuliah ${nama} pada Pukul $currentHour.$currentMinute WIB",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Navbar_bottom()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(appOrange),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 18)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back),
                              Text(
                                'KEMBALI',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
