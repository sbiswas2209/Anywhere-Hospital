import 'package:anywhere_hospital/services/auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  static final String tag = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            child: Icon(Icons.exit_to_app , color: Theme.of(context).primaryColorDark,)
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        backgroundColor: Theme.of(context).primaryColorLight,
        label: Text('Chatbot',
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).primaryColorDark),
        ),
        icon: Icon(Icons.chat_bubble , color: Theme.of(context).primaryColorDark,),
      ),
    );
  }
}