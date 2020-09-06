import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/Services/database.dart';
import 'package:flutter_firebase/models/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object from firebase
  FireUser _fireUser(User user) {
    return user != null ? FireUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<FireUser> get user {
    return (_auth.authStateChanges()).map((User user) => _fireUser(user));
  }

  //anonymous signing in
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _fireUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //logging out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //registering in with email and password
Future registerWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //create a new document for the user with the uid
      await DatabaseServices(uid: user.uid).updateUserData('0', 'new crew member', 700);

      return _fireUser(user);
    }catch(e){
      print("${e.toString()} errrrror ");
      return null;
    }
}

//signing in with email and password
  Future signInWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _fireUser(user);
    }catch(e){
      print("${e.toString()} error");
      return null;
    }
  }
}
