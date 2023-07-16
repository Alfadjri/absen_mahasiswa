import 'package:absensi_siswa/model/sendOtp.dart';
import 'package:absensi_siswa/services/api_services.dart';
import 'package:absensi_siswa/view/absense/success.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:absensi_siswa/constants/color.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController _otpController = TextEditingController();
  // set jumlah digit OTP yang ingin ditampilkan
  int _otpLength = 6;
  final _formKey = GlobalKey<FormState>();
  final apiService = ApiService();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var idJadwal = await apiService.getIdJadwal();
      var sendOtp = SendOtp(id_jadwal: int.parse(idJadwal), code: _code);
      var success = await apiService.sendOtp(sendOtp);
      try {
        await apiService.sendOtp(sendOtp);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessAbsense()),
        );
      } catch (e) {
        throw Exception('gagal mengiirim');
      }
    }
  }

  String _code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: appTokenCard,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: PinCodeTextField(
                      appContext: context,
                      length: _otpLength,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 48,
                        fieldWidth: 40,
                        inactiveFillColor: Colors.white,
                        inactiveColor: Color(0xFFEBEBEB),
                        activeFillColor: Colors.white,
                        activeColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      textStyle: TextStyle(fontSize: 20),
                      enableActiveFill: true,
                      controller: _otpController,
                      onCompleted: (value) {
                        _code = value.toString();
                        print("Completed: $value");
                      },
                      onChanged: (value) {
                        _code = value.toString();
                        print("OTP Value: $_code");
                      },
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _submitForm,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(appOrange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 130, vertical: 18)),
                ),
                child: Text(
                  'ABSEN',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
