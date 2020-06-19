import 'package:anywhere_hospital/authentication/loginPage.dart';
import 'package:anywhere_hospital/authentication/signUpPage.dart';
import 'package:anywhere_hospital/models/user.dart';
import 'package:anywhere_hospital/pages/chatbot.dart';
import 'package:anywhere_hospital/pages/doctorsList.dart';
import 'package:anywhere_hospital/pages/home.dart';
import 'package:anywhere_hospital/pages/registerStore.dart';
import 'package:anywhere_hospital/services/auth.dart';
import 'package:anywhere_hospital/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String  , WidgetBuilder>{
    HomePage.tag : (context) => new HomePage(),
    LoginPage.tag : (context) => new LoginPage(),
    SignUpPage.tag : (context) => new SignUpPage(),
    ChatbotPage.tag : (context) => new ChatbotPage(),
    DoctorsListPage.tag : (context) => new DoctorsListPage(),
    RegisterStorePage.tag : (context) => new RegisterStorePage(),
  };
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        theme: ThemeData(
          primaryColor: Colors.lightGreenAccent,
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.grey,
          primaryColorDark: Colors.black,
          primaryColorLight: Colors.blue,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
            bodyText1: TextStyle(
              color: Colors.blue,
              fontSize: 15.0,
              fontStyle: FontStyle.italic,
            ),
            bodyText2: TextStyle(
              color: Colors.blue[900],
              fontSize: 20.0,
            ),
          ),
          fontFamily: 'Ubuntu',
        ),
      ),
    );
  }
}

