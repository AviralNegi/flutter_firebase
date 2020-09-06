import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/models/user.dart';

class DatabaseServices{

  final String uid;
  DatabaseServices({this.uid});

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection(('brew'));

  Future updateUserData(String sugars, String name, int strength) async{
    return await brewCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength,
    });
  }
  // brew list from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
          name: doc.data()["name"] ?? ' ',
          strength: doc.data()['strength'] ?? 0,
          sugars: doc.data()['sugars'] ?? '0');
    }).toList();
  }
  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name:snapshot.data()['name'],
      sugars:snapshot.data()['sugars'],
      strength:snapshot.data()['strength']
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapShot);
  }
  // get user doc stream
Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
}
}