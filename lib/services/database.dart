import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  CollectionReference userData = Firestore.instance.collection('users');
  Future setUserData(String name , String email , String password , String gender , bool isDoctor) async {
    await userData.document(uid).setData({
      'name' : name,
      'email' : email,
      'password' : password,
      'gender' : gender,
      'isDoctor' : isDoctor,
      'joined' : DateTime.now(),
    });
  }
}