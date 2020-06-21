import 'package:anywhere_hospital/models/item.dart';
import 'package:anywhere_hospital/models/userData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  CollectionReference userData = Firestore.instance.collection('users');
  CollectionReference storeData = Firestore.instance.collection('stores');
  Future setUserData(String name, String email, String password, String gender,
      bool isDoctor, DateTime birthday) async {
    await userData.document(uid).setData({
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'isDoctor': isDoctor,
      'joined': DateTime.now(),
      'birthday': birthday,
      'uid': uid,
      'ownStatus': false,
    });
  }

  Future setStoreData(String storeName, String ownerName, LatLng position,
      List<Item> stock, String phoneNumber) async {
    Map _stockMap = Map.fromIterable(stock,
        key: (value) => value.name, value: (value) => value.stock);
    await storeData.document().setData({
      'storeName': storeName,
      'ownerName': ownerName,
      'position': GeoPoint(position.latitude, position.longitude),
      'stock': _stockMap,
      'phone': phoneNumber,
    });
    await userData.document(uid).updateData({
      'ownStatus': true,
    });
  }

  Future<UserData> getUserData() async {
    DocumentSnapshot snapshot;
    UserData userData;
    await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((value) => userData = new UserData(
              email: snapshot.data['email'],
              password: snapshot.data['password'],
              isDoctor: snapshot.data['isDoctor'],
              gender: snapshot.data['gender'],
              name: snapshot.data['name'],
            ));
    return userData;
  }
}
