import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leogram/dimensions.dart';
import 'package:leogram/providers/user_provider.dart';
import 'package:leogram/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:leogram/models/user.dart' as model;

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  late PageController pgCont;
  int _page=0;
  void navigTap(int page){
    pgCont.jumpToPage(page);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pgCont=PageController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pgCont.dispose();
  }
  void onPgChngd(int page){
    _page=page;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pgCont,
        onPageChanged: onPgChngd,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobBackCol,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: _page==0? primCol:secCol,), label: '', backgroundColor: primCol),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,color: _page==1? primCol:secCol), label: '', backgroundColor: primCol),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,color: _page==2? primCol:secCol), label: '', backgroundColor: primCol),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,color: _page==3? primCol:secCol), label: '', backgroundColor: primCol),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,color: _page==4? primCol:secCol), label: '', backgroundColor: primCol),
          ],
        onTap: navigTap,
      ),
    );
  }
}
