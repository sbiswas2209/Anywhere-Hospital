import 'package:anywhere_hospital/models/user.dart';
import 'package:anywhere_hospital/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }
  User _userFromFirebase(FirebaseUser user){
    return user!=null ? User(uid: user.uid) : null;
  }
  Future<dynamic> signUp(String name , String email , String password , bool isDoctor , String gender) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await new DatabaseService(uid: user.uid).setUserData(name, email, password, gender, isDoctor);
      return _userFromFirebase(user);
    }
    catch(e){
      return e;
    }
  }
  Future<dynamic> signIn(String email , String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    }
    catch(e){
      return e;
    }
  }
  Future<void> signOut() async {
    return _auth.signOut();
  }
}