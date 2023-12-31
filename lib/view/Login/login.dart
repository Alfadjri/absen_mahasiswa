import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:absensi_siswa/constants/color.dart';
import 'package:absensi_siswa/model/login.dart';
import 'package:absensi_siswa/viewModel/login.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginViewModel = LoginViewModel();
  String _errorMessage = '';
  bool _passwordVisible = false;
  bool _isLoading = false;

  void _submitForm() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var login = Login(username: _username, password: _password);
      var success = await _loginViewModel.authenticateUser(login);

      try {
        var token = await _loginViewModel.authenticateUser(login);
        Navigator.of(context).pushNamed('/absense');
      } catch (e) {
        setState(() {
          _errorMessage = 'Invalid email or password.';
        });
      }
    }
  }

  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      child: SvgPicture.asset("images/logo.svg"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "NPM",
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                         onSaved: (value) {
                            _username = value!;
                          },
                          decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(18),
                        hintText: 'Enter NPM',
                        hintStyle: TextStyle(fontSize: 14.0),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: appBorder),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: appOrange),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        textAlign: TextAlign.start,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          _password = value;
                        },
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFFAFAFAF),
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.all(18),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(fontSize: 14.0),
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: appBorder),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: appOrange),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(appOrange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    padding:
                        MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                        )
                      : Text('LOGIN'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
