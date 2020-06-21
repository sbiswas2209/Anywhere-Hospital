import 'package:anywhere_hospital/models/userData.dart';
import 'package:anywhere_hospital/pages/chatbot.dart';
import 'package:anywhere_hospital/pages/doctorsList.dart';
import 'package:anywhere_hospital/pages/registerStore.dart';
import 'package:anywhere_hospital/pages/shopsList.dart';
import 'package:anywhere_hospital/pages/statistics.dart';
import 'package:anywhere_hospital/services/auth.dart';
import 'package:anywhere_hospital/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  static final String tag = 'home-page';
  final String uid;
  HomePage({this.uid});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserData data;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'The Anywhere Doctor',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => new AuthService().signOut(),
            child: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(widget.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? LinearProgressIndicator()
              : ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        color: Theme.of(context).primaryColorLight,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                !snapshot.data['isDoctor']
                                    ? 'assets/images/doctor_home.png'
                                    : 'assets/images/patient.png',
                                fit: BoxFit.fill,
                                height: 150.0,
                              ),
                              Text(
                                'Hi ${snapshot.data['name']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                        color: Colors.white, fontSize: 30.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Card(
                          color: Theme.of(context).primaryColorDark,
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/doctor_list.png',
                                fit: BoxFit.fill,
                                height: 120.0,
                              ),
                              Text(
                                'Check out \nour full \narsenal',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    ),
                              ),
                              Icon(
                                Icons.arrow_right,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new DoctorsListPage())),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Card(
                          color: Theme.of(context).primaryColorLight,
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/store.png',
                                fit: BoxFit.fill,
                                height: 120.0,
                              ),
                              Text(
                                'Check out all\nour pharmacies',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    ),
                              ),
                              SizedBox(width: 20.0),
                              Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                                size: 25.0,
                              )
                            ],
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new ShopsListPage(
                                      uid: widget.uid,
                                    ))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Card(
                          color: Theme.of(context).primaryColorDark,
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/statistics.png',
                                fit: BoxFit.fill,
                                height: 120.0,
                              ),
                              Text(
                                'Check\nIndia\'s\nStatistics',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    ),
                              ),
                              SizedBox(width: 100.0),
                              Icon(
                                Icons.arrow_right,
                                color: Colors.white,
                                size: 25.0,
                              )
                            ],
                          ),
                        ),
                        onTap: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new StatisticsPage())),
                      ),
                    ),
                  ],
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new ChatbotPage())),
        backgroundColor: Theme.of(context).primaryColorLight,
        label: Text(
          'Chatbot',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Theme.of(context).primaryColorDark),
        ),
        icon: Icon(
          Icons.chat_bubble,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}