import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MapPage extends StatefulWidget {
  static final String tag = 'map-page';
  final List<DocumentSnapshot> data;
  MapPage({this.data});
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _center;
  bool _loading = true;
  GoogleMapController _mapController;
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      _loading = true;
    });
    new Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value){
        setState(() {
          if(value.latitude != null || value.longitude != null){
          _center = new LatLng(value.latitude, value.longitude);
          }
        });
      });
    setState(() {
      int i=0;
      while(i<widget.data.length){
        _markers.add(Marker(
          markerId: MarkerId('${widget.data[i]['storeName']}'),
          position: LatLng(widget.data[i]['position'].latitude , widget.data[i]['position'].longitude),
          icon: BitmapDescriptor.defaultMarker,
        ));
        i++;
      }
    });
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map of all pharmacies',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: _loading ? LinearProgressIndicator() :
      Container(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}