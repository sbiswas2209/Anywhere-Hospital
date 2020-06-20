import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class StoreDetailsPage extends StatelessWidget {
  static final String tag = 'store-details-page';
  final DocumentSnapshot data;
  StoreDetailsPage({this.data});
  GoogleMapController _mapController;
  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data['storeName']} Details',
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
              child: Text('${data['storeName']}',
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
              child: Text('Loaction',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
                      child: Container(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(data['position'].latitude , data['position'].longitude),
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