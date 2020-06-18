import 'package:anywhere_hospital/models/userData.dart';
import 'package:anywhere_hospital/pages/chatbot.dart';
import 'package:anywhere_hospital/pages/doctorsList.dart';
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
  // @override
  // void initState() {
  //   super.initState();
  //   DatabaseService database = new DatabaseService(uid: widget.uid);
  //   setState(() {
  //     _loading = true;
  //   });
  //   database.getUserData().then((value) {
  //     setState(() {
  //       data = value;
  //     });
  //   });
  //   setState(() {
  //     _loading = false;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Anywhere Doctor',
          style: Theme.of(context).textTheme.headline1,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => new AuthService().signOut(), 
            child: Icon(Icons.exit_to_app , color: Theme.of(context).primaryColorDark,),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('users').document(widget.uid).snapshots(),
        builder: (context , snapshot){
          return !snapshot.hasData ? LinearProgressIndicator() : ListView(
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
                        !snapshot.data['isDoctor'] ? 'assets/images/doctor_home.png' : 'assets/images/patient.png',
                          fit: BoxFit.fill,
                          height: 150.0,
                        ),
                        Text('Hi ${snapshot.data['name']}',
                          style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white, fontSize: 30.0),
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
                          height: 130.0,
                        ),
                        Text('Check out \nour \nfull \narsenal',
                          style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.white , fontSize: 30.0),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new DoctorsListPage())),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new ChatbotPage())),
        backgroundColor: Theme.of(context).primaryColorLight,
        label: Text('Chatbot',
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).primaryColorDark),
        ),
        icon: Icon(Icons.chat_bubble , color: Theme.of(context).primaryColorDark,),
      ),
    );
  }
}