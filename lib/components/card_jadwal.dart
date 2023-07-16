import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:absensi_siswa/constants/color.dart';

class Card_Jadwal extends StatelessWidget {
  final String name;
  final String waktu;
  final VoidCallback onTap;
  const Card_Jadwal({
    required this.name,
    required this.waktu,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: appOrangePrimary,
            ),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(21.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("images/ic_jam.svg"),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(waktu, style: TextStyle(color: Colors.white),),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Image.asset("images/img-card.png")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
