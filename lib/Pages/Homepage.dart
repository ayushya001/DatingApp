

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loveria/Widgetes/DragWidget.dart';
import 'package:loveria/Widgetes/HomeScreenButton.dart';
import 'package:loveria/Widgetes/HomeTopbar.dart';
import 'package:loveria/Widgetes/ProfileCard.dart';
import 'package:loveria/Widgetes/SwipbleCard.dart';
import 'package:provider/provider.dart';


import '../Components/practise.dart';
import '../Providers/ProfileProvider.dart';
import '../Utils/AppComponentsColor.dart';

import '../Widgetes/CardsStackWidget.dart';
import '../Widgetes/Cardusers.dart';

class HomePage extends StatefulWidget {

   const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ProfileProvider _profileProvider;





  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(
        context, listen: false);
    print("whole rebuilt homePage");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopbarHome(),
            Expanded(
                child:  FutureBuilder<void>(
                  future: profileProvider.fetchDataFromFirestore(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting  ) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return CardsStackWidget();
                    }
                  },
                ),
            ),

          ],
        )


      )
    );
  }
}
