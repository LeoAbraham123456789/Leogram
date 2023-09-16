import 'package:flutter/material.dart';
import 'package:leogram/screens/addpost.dart';
import 'package:leogram/screens/feeds.dart';
import 'package:leogram/screens/profile_screen.dart';
import 'package:leogram/screens/search_screen.dart';
const web=600;

const homeScreenItems=[
  Feedscreen(),
  SearchScreen(),
  AddPost(),
  Text('notify'),
  ProfileScreen(),
];