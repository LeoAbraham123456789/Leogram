import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leogram/providers/user_provider.dart';
import 'package:leogram/responsive/mobile_screen_layout.dart';
import 'package:leogram/responsive/responsive_layout_screen.dart';
import 'package:leogram/responsive/web_screen_layout.dart';
import 'package:leogram/screens/login.dart';
import 'package:leogram/screens/signup.dart';
import 'package:leogram/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Leogram',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobBackCol,
        ),
        // home: ResponsiveLayout(mobScreen: MobileScreen(),webScreen: WebScreen(),),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                    mobScreen: MobileScreen(), webScreen: WebScreen());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primCol,
                ),
              );
            }
            return Login();
          },
        ),
      ),
    );
  }
}
