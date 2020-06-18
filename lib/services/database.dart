import 'package:anywhere_hospital/models/userData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  CollectionReference userData = Firestore.instance.collection('users');
  Future setUserData(String name , String email , String password , String gender , bool isDoctor , DateTime birthday) async {
    await userData.document(uid).setData({
      'name' : name,
      'email' : email,
      'password' : password,
      'gender' : gender,
      'isDoctor' : isDoctor,
      'joined' : DateTime.now(),
      'birthday' : birthday,
      'uid' : uid,
    });
  }
  Future<UserData> getUserData() async {
    DocumentSnapshot snapshot;
    UserData userData;
    await Firestore.instance.collection('users').document(uid).get().then((value) =>
      userData = new UserData(
        email: snapshot.data['email'],
        password: snapshot.data['password'],
        isDoctor: snapshot.data['isDoctor'],
        gender: snapshot.data['gender'],
        name: snapshot.data['name'],
      )
    );
    return userData;
  }
}