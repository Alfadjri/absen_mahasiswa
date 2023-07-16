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

class Jadwal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Jadwal();
  }
}

class _Jadwal extends State<Jadwal> {

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
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Card_Jadwal(
                                    name: "nama",
                                    waktu: "20.00 WIB",
                                    onTap: (){},
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
