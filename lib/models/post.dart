import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePub;
  final String postUrl;
  final String profIm;
  final likes;

  const Post({
    required this.username,
    required this.uid,
    required this.description,
    required this.postId,
    required this.datePub,
    required this.postUrl,
    required this.profIm,
    required this.likes,
  });
  Map<String, dynamic> toJson()=>{
    "username": username,
    "uid":uid,
    "description": description,
    "postId": postId,
    "datePub": datePub,
    "postUrl": postUrl,
    "profIm": profIm,
    "likes": likes,
  };

  static Post fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String,dynamic>;
    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePub: snapshot['datePub'],
      postUrl: snapshot['postUrl'],
      profIm: snapshot['profIm'],
      likes: snapshot['likes'],
    );
  }
}