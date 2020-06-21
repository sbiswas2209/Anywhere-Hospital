import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class StoreDetailsPage extends StatefulWidget {
  static final String tag = 'store-details-page';
  final DocumentSnapshot data;
  StoreDetailsPage({this.data});

  @override
  _StoreDetailsPageState createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {

  GoogleMapController _mapController;

  Set<Marker> _marker = {};

  bool _loading;

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

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId(widget.data['storeName']),
        position: LatLng(widget.data['position'].latitude , widget.data['position'].longitude),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.data['storeName']} Details',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/images/store.png'),
              height: 300.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('${widget.data['storeName']}',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Contact us at,',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${widget.data['phone']}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  FlatButton(
                    child: Icon(Icons.phone , color: Theme.of(context).primaryColorDark,),
                    onPressed: () {
                      launch(('tel://${widget.data['phone']}'));
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Loaction',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: _marker,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.data['position'].latitude , widget.data['position'].longitude),
                  zoom: 11.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}