import 'package:anywhere_hospital/services/auth.dart';
import 'package:flutter/material.dart';
class SignUpPage extends StatefulWidget {
  static final String tag = 'sign-up-page';
  final Function toggleView;
  SignUpPage({this.toggleView});
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _loading = false;
  String _email = '';
  String _password = '';
  bool _isDoctor = null;
  String _name = '';
  String _confirmPassword = '';
  String gender = 'I do not want to say';
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
  Future<void> _showPasswordMismatchDialog(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: true,
      child: AlertDialog(
          title: Text('The passwords do not match',
            style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.blue[900]),
          ),
          content: Text('Check both fields again',
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
          title: Text('Some Error Occured',
            style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.blue[900]),
          ),
          content: Text('Please retry again.',
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
        title: Text('Sign Up',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _loading ? CircularProgressIndicator(backgroundColor: Colors.black,):SizedBox(),
            SizedBox(height:50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline , color: Theme.of(context).primaryColorLight,),
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
                    _name = value;
                  });
                },
              ),
            ),
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
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
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
                    _confirmPassword = value;
                  });
                },
              ),
            ),
            Center(
              child: Text('I am a',
                style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.blue[900]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: _isDoctor == true ? Theme.of(context).primaryColorLight : Colors.white,
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/doctor.png'),
                          height: 40,
                        ),
                        Text('Doctor',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    onPressed: (){
                      setState(() {
                        _isDoctor = true;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: _isDoctor == false ? Theme.of(context).primaryColorLight : Colors.white,
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/images/patient.png'),
                          height:40.0,
                        ),
                        Text('Patient',
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                    onPressed: (){
                      setState(() {
                        _isDoctor = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            Center(
              child: Text('My gender is',
                style: Theme.of(context).textTheme.headline1.copyWith(color: Colors.blue[900]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(120.0 , 8.0 , 120.0 , 8.0),
              child: DropdownButton<String>(
                value: gender,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                underline: Container(
                height: 2,
                color: Theme.of(context).primaryColorDark,
                ),
              onChanged: (String newValue) {
              setState(() {
                gender = newValue;
              });
               },
          items: <String>['I do not want to say', 'Male', 'Female', 'LGBTQ']
              .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
           value: value,
              child: Text(value),
          );
        }).toList(),
       ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80.0 , 8.0 , 80.0 , 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                            child: RaisedButton.icon(
                  onPressed: () async {
                     if(_email == '' || _password == '' || _isDoctor == null){
                  _showNullDialog(context);
                }
                else if(_password != _confirmPassword){
                  _showPasswordMismatchDialog(context);
                }
                else{
                  try{
                    setState(() {
                      _loading = true;
                    });
                    await new AuthService().signUp(_name, _email, _password, _isDoctor, gender);
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
                  label: Text('Sign Up',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ),
            FlatButton.icon(
              onPressed: widget.toggleView, 
              icon: Icon(Icons.add , color: Theme.of(context).primaryColorLight,), 
              label: Text('Log In',
                style: Theme.of(context).textTheme.bodyText2,
              )
            ),
          ],
        ),
      ),
    );
  }
}