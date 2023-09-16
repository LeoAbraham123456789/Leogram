import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leogram/models/post.dart';
import 'package:leogram/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profIm,
  ) async {
    String res = "some err occured";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePub: DateTime.now(),
        postUrl: photoUrl,
        profIm: profIm,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    try {
      if(text.isNotEmpty){
        String commenId=Uuid().v1();
        await _firestore.collection('posts').doc(postId).collection('comments').doc(commenId).set({
          'profilePic':profilePic,
          'name': name,
          'uid': uid,
          'text':text,
          'commenId': commenId,
          'datePub': DateTime.now(),
        });
      }else{
        print('Text is empty');
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> deletePost(String postId) async{
    try{
      await _firestore.collection('posts').doc(postId).delete();
    }catch(err){
      print(err.toString());
    }
  }
}
