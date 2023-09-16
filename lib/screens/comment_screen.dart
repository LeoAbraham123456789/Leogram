import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leogram/providers/user_provider.dart';
import 'package:leogram/resources/firestore_methods.dart';
import 'package:leogram/utils/colors.dart';
import 'package:leogram/models/user.dart' as model;
import 'package:provider/provider.dart';
import '../widgets/comment_card.dart';

class CommentScreen extends StatefulWidget {
  final snap;

  const CommentScreen({Key? key, required this.snap}):super(key:key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commController=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final model.User user = Provider
        .of<UserProvider>(context)
        .getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobBackCol,
        title: Text('Comments'),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').doc(widget.snap['postId']).collection('comments').orderBy('datePublished', descending: true).snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context,index)=>CommentCard(
            snap: snapshot.data!.docs[index].data()
          ));
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom),
          padding: EdgeInsets.only(left: 60, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    controller:_commController,
                    decoration: InputDecoration(
                      hintText: "Write your comment",
                      border: InputBorder.none,
                    ),

                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirestoreMethods().postComment(
                      widget.snap['postId'], _commController.text, user.uid,
                      user.userName, user.photoUrl);
                  setState(() {
                    _commController.text="";
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    'Post', style: TextStyle(color: Colors.blueAccent),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

