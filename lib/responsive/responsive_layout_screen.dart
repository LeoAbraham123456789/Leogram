import 'package:flutter/material.dart';
import 'package:leogram/dimensions.dart';
import 'package:leogram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreen;
  final Widget mobScreen;
  const ResponsiveLayout({required this.webScreen, required this.mobScreen,super.key});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }
  
  addData() async{
    UserProvider _userProvider=Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth>web){
            return widget.webScreen;
          }
          return widget.mobScreen;
        });
  }
}
