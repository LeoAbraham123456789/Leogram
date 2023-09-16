import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leogram/resources/storage_methods.dart';
import 'package:leogram/models/user.dart' as model;

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async{
    User currentUser=_auth.currentUser!;
    DocumentSnapshot snap=await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpuser({
    required String email,
    required String pass,
    required String userName,
    required String bio,
    required Uint8List file,
})async{
  String res="Some error occured...";
  try{
    if(email.isNotEmpty||pass.isNotEmpty||userName.isNotEmpty||bio.isNotEmpty||file!=null){
      UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      String photoUrl=await StorageMethods().uploadImageToStorage('profilePics', file, false);
      model.User user=model.User(
        userName: userName,
        uid: cred.user!.uid,
        email: email,
        bio: bio,
        followers:[],
        following: [],
        photoUrl:photoUrl,
      );
      await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
      res="success";
    }
  }
  catch(err){
    res=err.toString();
  }
  return res;
}
  Future<String>  loginUser({
    required String email,
    required String password
})async{
    String res="Some error occured";
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res="success";
      }else{
        res="Please enter all the fields";
      }
    }catch(err){
      res=err.toString();
    }
    return res;
  }
}