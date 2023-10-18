import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:loveria/Models/Profile.dart';
import 'package:loveria/Pages/ProfileDetails.dart';

import '../Utils/general_utils.dart';
import '../Utils/routes.dart';
import '../Utils/routesName.dart';

class Authprovider extends ChangeNotifier {

  final currentUser = FirebaseAuth.instance.currentUser;


  bool _loading = false;

  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void Register(BuildContext context, String email, String password) async {
    try {
      setloading(true);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        final uid = currentUser.uid;


        Map<String, dynamic> users = {
          'uid': uid,
          'email': email,
          'password': password,
        };

        await FirebaseFirestore.instance
            .collection("LoveriaUsers")
            .doc(uid)
            .set(users);

        // Navigation and setting loading should be inside the completion callback
        Navigator.push(
          context,
          Routes.generateRoute(RouteSettings(name: RoutesName.ProfileDetails)),
        );
        setloading(false);

        // .child('Users').child(uid).set(userr);

      }
    }
    catch (e) {
      print("users cannot be created because:-" + e.toString());
    }
  }

  void Login(BuildContext context, String email, String password) async {

    setloading(true);

    try {

      FirebaseAuth _auth = FirebaseAuth.instance;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
        context,
        Routes.generateRoute(RouteSettings(name: RoutesName.MainPage)),
      );
      setloading(false);

      // User successfully logged in, you can navigate to another screen here.
    } catch (e) {
      // Handle login errors (e.g., invalid credentials, user not found).
      print(e.toString());
      setloading(false);

      Utils.flushBarErrorMessage('please enter the hint username and password', context);
    }



  }

  void Details(BuildContext context, String firstName, String Lastname,
      String imagepath,TextEditingController firstnameController,
      TextEditingController lastnameController) async {
    setloading(true);
    final currentUser = this.currentUser;
    if (currentUser != null) {
      final uid = currentUser.uid;


      try {
        setloading(true);

        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final uid = currentUser.uid;

          final storageReference = FirebaseStorage.instance
              .ref()
              .child('profile_images/${DateTime
              .now()
              .millisecondsSinceEpoch}.jpg');

          final uploadTask = await storageReference.putFile(File(imagepath))
              .whenComplete(() {});
          final downloadUrl = await uploadTask.ref.getDownloadURL();

          Map<String, dynamic> details = {
            'firstName': firstName,
            'lastName': Lastname,
            'image': downloadUrl,
          };

          await FirebaseFirestore.instance
              .collection("LoveriaUsers").doc(uid)
              .update(details)
              .then((value) {
            Navigator.push(
              context,
              Routes.generateRoute(
                  RouteSettings(name: RoutesName.ChooseGender)),
            );
            setloading(false);
            firstnameController.clear();
            lastnameController.clear();
          });
        }
      } catch (e) {
        print("Error uploading data: $e");
        setloading(false);
      }
    }}}