
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leogram/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers=false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobBackCol,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(labelText: 'Search for a user'),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers=true;
            });
          },
        ),
      ),
      body: isShowUsers? FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('userName', isGreaterThanOrEqualTo: searchController.text)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(snapshot.data!.docs[index]['photoUrl']),
                  ),
                  title: Text(snapshot.data!.docs[index]['userName']),
                );
              });
        },
      ) : Text('Posts'),
    );
  }
}
