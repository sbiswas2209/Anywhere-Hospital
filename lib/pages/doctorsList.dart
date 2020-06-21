import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chat.dart';

class DoctorsListPage extends StatefulWidget {
  static final String tag = 'doctors-list';
  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctors',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context).primaryColorDark,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                name: snapshot.data.documents[index]['name'],
                                receiverUid: snapshot.data.documents[index]
                                    ['uid'],
                              ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            child: Image.asset(
                              'assets/images/doctor.png',
                            )),
                        trailing: Icon(Icons.arrow_right,
                            color: Theme.of(context).primaryColor),
                        title: Text(
                          'Dr. ${snapshot.data.documents[index]['name']}',
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${snapshot.data.documents[index]['type']}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white),
                        ),
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
