import 'package:anywhere_hospital/models/item.dart';
import 'package:anywhere_hospital/services/database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class RegisterStorePage extends StatefulWidget {
  static final String tag = 'register-store-page';
  final String uid;
  RegisterStorePage({this.uid});
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
  LatLng _lastPosition;
  String _phoneNumber = '';
  Set<Marker> _marker = {};
  List<Item> _stock = [];
  String _itemName = null;
  int _itemCount = null;
  final _formKey = GlobalKey<FormState>();

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position){
    _lastPosition = position.target;
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
        _lastPosition = _center;
      });
      setState(() {
        _marker.clear();
        _marker.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: _center,
        infoWindow: InfoWindow(
          title: 'Your Store'
         ),
         icon: BitmapDescriptor.defaultMarker,
         ));
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
        title: Text('Register your store',
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
                textCapitalization: TextCapitalization.words,
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
                textCapitalization: TextCapitalization.words,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  prefixIcon: Icon(Icons.phone , color: Theme.of(context).primaryColorLight,),
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
                    _phoneNumber = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Set Location of store',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            _center != null ? ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                constraints: BoxConstraints(
                  maxWidth: (MediaQuery.of(context).size.width),
                  maxHeight: 400,
                ),
                child:Stack(
                  children: <Widget>[
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      onCameraMove: _onCameraMove,
                      markers: _marker,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target:  _center,
                        zoom: 11.0,
                      ),
                      onTap: (argument) {
                        setState(() {
                          _marker.clear();
                          _marker.add(Marker(
                            markerId: MarkerId(_lastPosition.toString()),
                            position: argument,
                            infoWindow: InfoWindow(
                              title: 'Your Store'
                            ),
                            icon: BitmapDescriptor.defaultMarker,
                          ));
                          _lastPosition = argument;
                        });
                      },
                    ),
                    FloatingActionButton(
                      onPressed: (){
                        setState(() {
                          _marker.clear();
                          _marker.add(Marker(
                            markerId: MarkerId(_lastPosition.toString()),
                            position: _lastPosition,
                            infoWindow: InfoWindow(
                              title: 'Your Store'
                            ),
                            icon: BitmapDescriptor.defaultMarker,
                          ));
                        });
                      },
                      child: Icon(Icons.pin_drop),
                      mini: true,
                    )
                  ],
                ),
              ),
            ): SizedBox(),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                      labelText: 'Item name',
                      prefixIcon: Icon(Icons.add , color: Theme.of(context).primaryColorLight,),
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
                        _itemName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    style: Theme.of(context).textTheme.bodyText2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Item number',
                      prefixIcon: Icon(Icons.add , color: Theme.of(context).primaryColorLight,),
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
                        _itemCount = int.parse(value);
                      });
                    },
                  ),
                ),
                FlatButton.icon(
                  onPressed: (){
                    if(_itemName != null || _itemCount != null){
                      Item temp = new Item(name: _itemName , stock: _itemCount);
                      setState(() {
                        _itemName = null;
                        _stock.add(temp);
                        _itemCount = null;
                      });
                    }
                    else{
                      _showNullDialog(context);
                    }
                  }, 
                  icon: Icon(Icons.add , color: Theme.of(context).primaryColorDark), 
                  label: Text('ADD',
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                )
              ],
            ),
            _stock.isEmpty == false ? 
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _stock.length,
                  itemBuilder: (context , index){
                    return Card(
                      color: Theme.of(context).primaryColorDark,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image(image: AssetImage('assets/images/pill.png')),
                        ),
                        title: Text('${_stock[index].name}',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
                        ),
                        subtitle: Text('${_stock[index].stock}',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                        ),
                        trailing: FlatButton(
                          onPressed: (){
                            setState(() {
                              _stock.remove(_stock[index]);
                            });
                          }, 
                          child: Icon(Icons.delete , color: Colors.white,)
                        ),
                      ),
                    );
                  },
                ),
              ):SizedBox(),
            Padding(
              padding: const EdgeInsets.fromLTRB(80.0 , 8.0 , 80.0 , 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                            child: RaisedButton.icon(
                  onPressed: () async {
                     if(_storeName == '' || _ownerName == '' || _stock.isEmpty == true || _phoneNumber == ''){
                  _showNullDialog(context);
                }
                else{
                  try{
                    setState(() {
                      _loading = true;
                    });
                    new DatabaseService(uid: widget.uid).setStoreData(_storeName, _ownerName, _lastPosition , _stock , _phoneNumber);
                    setState(() {
                      _loading = false;
                    });
                    Navigator.pop(context);
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