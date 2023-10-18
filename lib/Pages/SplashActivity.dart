import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loveria/Pages/LoginPage.dart';
import 'package:loveria/Pages/MainPage.dart';

import '../Utils/routes.dart';
import '../Utils/routesName.dart';


class SplashActivity extends StatefulWidget {
  const SplashActivity({Key? key}) : super(key: key);

  @override
  State<SplashActivity> createState() => _SplashActivityState();
}

class _SplashActivityState extends State<SplashActivity> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    _startNavigation();
    super.initState();
  }
  void _startNavigation() async {
    await Future.delayed(Duration(milliseconds: 1000)); // Adjust the delay as needed
    _checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery
        .of(context)
        .size;

    return AnimatedSplashScreen(
      splash: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Loveria",
              style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'cursive',
                  color: Colors.white
              ),),
          ],
        ),
      ),
      nextScreen: _auth.currentUser != null ? Mainpage() : Login(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.red,
      duration: 8000,
    );
  }

  void _checkAuthentication() async {

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Utils.flushBarErrorMessage("user is not null", context);
        final uid = user.uid;
        // Check if the user has required data (name and profile pic) in the database
        DocumentSnapshot userData = await FirebaseFirestore.instance.collection(
            'LoveriaUsers').doc(uid).get();

        if (userData.exists ) {
          // User is authenticated and has required data, navigate to the main screen
          Navigator.push(
            context,
            Routes.generateRoute(RouteSettings(name: RoutesName.MainPage)),
          );
        }
        // else {
        //   // User is authenticated but doesn't have required data, navigate to the details screen
        //   Navigator.push(
        //     context,
        //     Routes.generateRoute(RouteSettings(name: RoutesName.DetailsScreen)),
        //   );
        // }
      }
      else {

        Navigator.push(
          context,
          Routes.generateRoute(RouteSettings(name: RoutesName.login)),
        );
      }
    }catch(e){

      print("the error of log in is:-" +e.toString());

    }

  }
}
