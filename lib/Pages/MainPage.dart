import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loveria/Api/firebaseApi.dart';
import 'package:loveria/Pages/Homepage.dart';
import 'package:loveria/Pages/MatchesScreen.dart';
import 'package:loveria/Pages/MatchesSend.dart';
import 'package:loveria/Pages/ProfilePage.dart';
import 'package:loveria/Providers/MainScreenProvider.dart';
import 'package:loveria/Utils/AppComponentsColor.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'ChatsScreen.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  FirebaseApi firebaseApi = new FirebaseApi();


  @override
  void initState() {
    super.initState();
    FirebaseApi.getFirebaseMessagingToken();
    firebaseApi.firebaseinit(context);
    firebaseApi.SetupInteractMessage(context);

  }


  @override
  Widget build(BuildContext context) {
    print("starting sai ho rha hai");
    List Screen  = [
      const HomePage(), const MatchesScreen(), const ChatScreen(), const ProfilePage()
    ];
    final mainScreenProvider = Provider.of<MainScreenProvider>(context);


    return Scaffold(
      body: Screen[mainScreenProvider.selectedindex.index],
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Appcolors.buttomnavbarbg,
          border: Border(
            top: BorderSide(
              color: Appcolors.borderColorTextformfield,
              width: 2,
            ),
          ),
        ),
        child: GNav(
          onTabChange: (index) {
            mainScreenProvider.changeSelectedIndex(index);
            print("change kaam kar rha hai sirf");
          },
          gap: 16, // Set the desired gap between tabs
          activeColor: Colors.red,
          iconSize: 30, // Set the desired icon size

          tabs: [
            GButton(icon: Icons.home, iconColor: Appcolors.inactive),
            GButton(icon: Ionicons.heart, iconColor: Appcolors.inactive),
            GButton(icon: Icons.chat, iconColor: Appcolors.inactive),
            GButton(icon: Icons.person, iconColor: Appcolors.inactive),
          ],
        ),
      )
    );
  }
}
