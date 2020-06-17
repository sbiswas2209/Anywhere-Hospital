import 'package:anywhere_hospital/authentication/startScreen.dart';
import 'package:anywhere_hospital/models/user.dart';
import 'package:anywhere_hospital/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return StartScreen();
    }
    else{
      return HomePage();
    }
  }
}