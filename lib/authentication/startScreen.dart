import 'package:anywhere_hospital/authentication/loginPage.dart';
import 'package:anywhere_hospital/authentication/signUpPage.dart';
import 'package:flutter/material.dart';
class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _loginStatus = true;
  void toggleView(){
    setState(() {
      _loginStatus = !_loginStatus;
    });
  }
  @override
  Widget build(BuildContext context) {
    return _loginStatus ? LoginPage(toggleView: toggleView) : SignUpPage(toggleView: toggleView);
  }
}