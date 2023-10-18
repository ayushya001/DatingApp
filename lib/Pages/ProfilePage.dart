import 'package:flutter/material.dart';
import 'package:loveria/Api/firebaseApi.dart';

import '../Models/ModelsClass.dart';
import 'newpractise.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Center(
        child: Text(FirebaseApi.auth.currentUser!.uid),
      )
    );
  }
}
