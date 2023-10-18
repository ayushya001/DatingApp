import 'package:flutter/material.dart';
import 'package:loveria/Components/RoundButton.dart';
import 'package:loveria/Providers/InterestsProvider.dart';
import 'package:provider/provider.dart';

import '../Providers/AuthProvider.dart';
import '../Utils/AppComponentsColor.dart';
import '../Utils/routes.dart';
import '../Utils/routesName.dart';

class Intersted extends StatefulWidget {
  const Intersted({Key? key}) : super(key: key);

  @override
  State<Intersted> createState() => _InterstedState();
}

class _InterstedState extends State<Intersted> {

  final List<String> Interests = ["Photography","Shopping","Yoga","Cooking","Cricket",
    "Run","Swimming","Art","Traveling","Music","Drink"

  ];



  // Create a Map to associate each interest with its corresponding icon
  Map<String, IconData> interestIcons = {
    "Photography": Icons.camera_alt_outlined,
    "Shopping": Icons.shopping_bag_outlined,
    "Yoga": Icons.accessibility_new_outlined,
    "Cooking": Icons.restaurant_outlined,
    "Cricket": Icons.sports_cricket_outlined,
    "Run": Icons.directions_run_outlined,
    "Swimming": Icons.pool_outlined,
    "Art": Icons.brush_outlined,
    "Traveling": Icons.airplanemode_active_outlined,
    "Music": Icons.music_note_outlined,
    "Drink": Icons.local_drink_outlined,
    // "Dancing": Icons.,
  };



  @override
  Widget build(BuildContext context) {
    final interestprovider = Provider.of<Interestprovider>(context,listen: false);
    final authprovider = Provider.of<Authprovider>(context,listen: false);

    print("whole rebuild");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.08,
            left: MediaQuery.of(context).size.width * 0.1,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                      child: InkWell(
                        onTap: () {

                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Appcolors.borderColorApplogo, width: 2),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Appcolors.featuresNamecolor, // Set the arrow color here
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                      child: InkWell(
                        onTap: () {
                          print("Skip is touched in choose gender");
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Appcolors.featuresNamecolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05,left: MediaQuery.of(context).size.width * 0.06),

                  child: Text(
                    "Your interests",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02,left: MediaQuery.of(context).size.width * 0.06),

                  child: Container(
                    // color: Colors.redAccent,
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Text(
                      "Select a few of your interests and let everyone know what you’re passionate about.",
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Appcolors.lowerblackshade,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemCount: Interests.length,


                  itemBuilder: (context, index) {
                    // final interest = Interests[index];
                    // final isSelected = interestprovider.selectedItem.contains(Interests[index]);
                    return Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: InkWell(
                        onTap: () {
                          print("ayush clcik too ho rha hai");
                            if (interestprovider.selectedItem.contains(Interests[index])) {
                              interestprovider.removeItem(Interests[index]);
                            } else {
                              interestprovider.addItem(Interests[index]);
                              print(Interests[index]);
                            }

                        },
                        child:Padding(
                          padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                          child:Consumer<Interestprovider>(
                           builder: (context, interestprovider, child) {

                          return Container(
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: interestprovider.selectedItem.contains(Interests[index]) ? Colors.red : Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                color: interestprovider.selectedItem.contains(Interests[index])? Appcolors.featuresNamecolor : Appcolors.borderColorApplogo,
                                width: 3,
                              ),
                              boxShadow: interestprovider.selectedItem.contains(Interests[index])
                                  ? [
                                BoxShadow(
                                  color: Appcolors.featuresNamecolor.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: Offset(0, 3),
                                ),
                              ]
                                  : null,

                            ),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.18),
                                    child: Icon(
                                      // Use the specific icon for each interest
                                      interestIcons[Interests[index]],
                                      size: 28,
                                      color: interestprovider.selectedItem.contains(Interests[index]) ? Colors.black : Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    Interests[index],
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: interestprovider.selectedItem.contains(Interests[index]) ? Colors.white : Colors.black,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
    }
                          )
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),

                  child: RoundButton(title: "Continue", onpress: (){

                    interestprovider.StoreInterests(context);



                    // Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.HomePage)));


                  }),
                )

              ],
            ),
          ),
        ),
      )
    );
  }
}
