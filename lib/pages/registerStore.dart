import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class RegisterStorePage extends StatefulWidget {
  static final String tag = 'register-store-page';
  @override
  _RegisterStorePageState createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  GoogleMapController _mapController;
  bool _loading = false;
  String _storeName = '';
  String _ownerName = '';
  Position position;
  LatLng _center;
  final _formKey = GlobalKey<FormState>();

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
  }

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
  void initState(){
    super.initState();
    Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      setState(() {
        _loading = true;
        position = value;
        print(position);
      });
      setState(() {
        _center = new LatLng(position.latitude , position.longitude);
      });
      setState(() {
        _loading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rgister your store',
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
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'Store name',
                  prefixIcon: Icon(Icons.store , color: Theme.of(context).primaryColorLight,),
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
                    _storeName = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'Owner name',
                  prefixIcon: Icon(Icons.person , color: Theme.of(context).primaryColorLight,),
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
                    _ownerName = value;
                  });
                },
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                constraints: BoxConstraints(
                  maxWidth: (MediaQuery.of(context).size.width),
                  maxHeight: (MediaQuery.of(context).size.height),
                ),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center != null ? _center : const LatLng(45.521563, -122.677433),
                    zoom: 11.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80.0 , 8.0 , 80.0 , 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                            child: RaisedButton.icon(
                  onPressed: () async {
                     if(_storeName == '' || _ownerName == ''){
                  _showNullDialog(context);
                }
                else{
                  try{
                    setState(() {
                      _loading = true;
                    });
                    
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
                  label: Text('Register Store',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}