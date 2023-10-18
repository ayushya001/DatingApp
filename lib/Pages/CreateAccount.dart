import 'package:flutter/material.dart';
import 'package:loveria/Components/Appslogo.dart';
import 'package:loveria/Components/RoundButton.dart';
import 'package:loveria/Utils/AppComponentsColor.dart';

import '../Utils/routes.dart';
import '../Utils/routesName.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
              child: Center(
                child: CircleAvatar(
                  radius: 80, // adjust the radius as needed
                  backgroundImage: AssetImage('assets/images/loveria.jpg'), // replace with your image path
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
              child: Container(
                height:MediaQuery.of(context).size.height*0.25 ,
                width: MediaQuery.of(context).size.width*0.8,


                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                      child: Center(child: Text("Signup to continue",style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,

                          fontSize: 26
                      )),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                      child: RoundButton(title: "Continue with email", onpress: (){
                        Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.Signup)));
                      }),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                      child: Text("Use Phone number",style: TextStyle(
                        fontSize: 16,
                        color: Appcolors.featuresNamecolor,
                      ),),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.03 ,),
            Container(
              height:MediaQuery.of(context).size.height*0.2 ,
              width: MediaQuery.of(context).size.width*0.8,
              // color: Colors.yellowAccent,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 1.0, // Adjust the height of the line as needed
                      color:Appcolors.borderColorApplogo, // Set the color to grey here
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01 ),
                    child: Text("or sign up with"),
                  ),
                  Padding(
                      padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02 ),
                      child: Container(
                        height:MediaQuery.of(context).size.height*0.1 ,
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(),

                        child: Center(
                          child: Padding(
                            padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1 ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:MediaQuery.of(context).size.height*0.08 ,
                                  width: MediaQuery.of(context).size.width*0.13,
                                  child: Applogo(image: AssetImage("assets/images/fbhd.png")),
                                ),
                                Spacer(),
                                Container(
                                  height:MediaQuery.of(context).size.height*0.08 ,
                                  width: MediaQuery.of(context).size.width*0.13,
                                  child: Applogo(image: AssetImage("assets/images/googleicon.png")),
                                ),
                                Spacer(),
                                Container(
                                  height:MediaQuery.of(context).size.height*0.08 ,
                                  width: MediaQuery.of(context).size.width*0.13,
                                  child: Applogo(image: AssetImage("assets/images/appleicon.png")),
                                ),





                              ],
                            ),
                          ),
                        ),
                      )
                  )
                ],
              ),

            ),
            Container(
              width: MediaQuery.of(context).size.width*0.6,
              child: Row(
                children: [
                  Text("Terms of use",style: TextStyle(
                      color: Colors.red,
                      fontSize: 16

                  ),),
                  Spacer(),
                  Text("Privacy Policy",style: TextStyle(
                      color: Colors.red,
                      fontSize: 16
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

