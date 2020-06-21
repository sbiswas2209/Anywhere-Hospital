import 'package:anywhere_hospital/models/user.dart';
import 'package:anywhere_hospital/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  SharedPreferences prefs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future<dynamic> signUp(String name, String email, String password,
      bool isDoctor, String gender, DateTime birthday) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await new DatabaseService(uid: user.uid)
          .setUserData(name, email, password, gender, isDoctor, birthday);
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', user.uid);
      return _userFromFirebase(user);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', user.uid);
      return _userFromFirebase(user);
    } catch (e) {
      return e;
    }
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }
}
