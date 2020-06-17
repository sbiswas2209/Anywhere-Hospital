import 'package:anywhere_hospital/services/auth.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  static final String tag = 'login-page';
  final Function toggleView;
  LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  String _email = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();
  Future<void> _showNullDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
          title: Text('One or more fields are empty.',
            style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.blue[900]),
          ),
          content: Text('Please fill up all fields',
            style: Theme.of(context).textTheme.bodyText1.copyWith(color : Colors.blue[900]),
          ),
          actions: <Widget>[
            FlatButton(
      onPressed: () => Navigator.pop(context), 
      child: Text('OK'),
            )
          ],
        ),
    );
  }
  Future<void> _showErrorDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
          title: Text('Some error occured',
            style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.blue[900]),
          ),
          content: Text('Please retry later.',
            style: Theme.of(context).textTheme.bodyText1.copyWith(color : Colors.blue[900]),
          ),
          actions: <Widget>[
            FlatButton(
      onPressed: () => Navigator.pop(context), 
      child: Text('OK'),
            )
          ],
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _loading ? LinearProgressIndicator(backgroundColor: Theme.of(context).primaryColorDark) : SizedBox(),
            SizedBox(height:50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email , color: Theme.of(context).primaryColorLight,),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Theme.of(context).primaryColorLight , width: 5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark , width: 5.0)
                  ),
                  labelStyle: Theme.of(context).textTheme.headline1,
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock , color: Theme.of(context).primaryColorLight,),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Theme.of(context).primaryColorLight , width: 5.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark , width: 5.0)
                  ),
                  labelStyle: Theme.of(context).textTheme.headline1,
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80.0 , 8.0 , 80.0 , 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                            child: RaisedButton.icon(
                  onPressed: () async {
                     if(_email == '' || _password == ''){
                  _showNullDialog(context);
                }
                else{
                  try{
                    setState(() {
                      _loading = true;
                    });
                    await new AuthService().signIn(_email, _password);
                    setState(() {
                      _loading = false;
                    });
                  }
                  catch(e){
                    _showErrorDialog(context);
                  }
                }
                  },
                  color: Theme.of(context).primaryColorLight,
                  icon: Icon(Icons.keyboard_arrow_right , color: Theme.of(context).primaryColorDark,),
                  label: Text('Log In',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ),
            FlatButton.icon(
              onPressed: widget.toggleView, 
              icon: Icon(Icons.add , color: Theme.of(context).primaryColorLight,), 
              label: Text('Sign Up',
                style: Theme.of(context).textTheme.bodyText2,
              )
            ),
          ],
        ),
      ),
    );
  }
}