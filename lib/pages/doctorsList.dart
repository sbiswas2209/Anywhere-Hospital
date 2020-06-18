import 'package:flutter/material.dart';
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
        title: Text('Doctors',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}