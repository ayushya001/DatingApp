import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loveria/Components/RoundButton.dart';
import 'package:loveria/Utils/AppComponentsColor.dart';
import 'package:provider/provider.dart';

import '../Providers/AuthProvider.dart';
import '../Providers/ImagePickerProvider.dart';
import '../Utils/general_utils.dart';
import '../Utils/routes.dart';
import '../Utils/routesName.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  TextEditingController _Firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode lastnameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<Authprovider>(context,listen: false);
    final imageprovider = Provider.of<ImageProviderClass>(context,listen: false);


    print("whole rebuilt");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,
                      right: MediaQuery.of(context).size.width*0.1),
                  child: Text("Skip",style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.featuresNamecolor
                  ),),
                ),

              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.12),
                  child: Text("Profile details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    color: Colors.black,

                  ),),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Center(
                child: Stack(
                  children: [
                Consumer<ImageProviderClass>(
                builder: (context, imageProvider, child) {
                      return Container(
                        height:MediaQuery.of(context).size.height*0.2 ,
                        width: MediaQuery.of(context).size.width*0.4,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: imageProvider.imagePath.isNotEmpty
                            ? Image.file(File(imageProvider.imagePath),fit: BoxFit.fitWidth, )
                            : Image.asset("assets/images/male.jpg",fit: BoxFit.fitWidth, ),

                      );
                },
              ),

                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            final imagefile = await ImagePicker().pickImage(source: ImageSource.gallery);

                            if(imagefile !=null){
                              Provider.of<ImageProviderClass>(context, listen: false)
                                  .setImagePath(imagefile.path);

                              print("only image picker");
                            }


                          },
                          child: Container(
                            height: 30,
                            width: 30,

                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ))
                  ],

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                child: TextFormField(
                  controller: _Firstname,
                  keyboardType: TextInputType.text,
                  focusNode: firstnameFocusNode,
                  decoration: InputDecoration(
                      hintText: "Enter your First name",
                      hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                      labelText: "First name",
                      labelStyle: TextStyle(color: Appcolors.labelColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Appcolors.borderColorTextformfield)
                      ),


                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Appcolors.TextformIconColor), // Color when the TextFormField is in focus
                      ),

                  ),
                  onFieldSubmitted: (val){
                    Utils.fieldFocusChange(context, firstnameFocusNode, lastnameFocusNode);
                  },

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.8,
                child: TextFormField(
                  controller: _lastname,
                  keyboardType: TextInputType.text,
                  focusNode: lastnameFocusNode,
                  decoration: InputDecoration(
                    hintText: "Enter your Last name",
                    hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                    labelText: "Last name",
                    labelStyle: TextStyle(color: Appcolors.labelColor),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Appcolors.borderColorTextformfield)
                    ),


                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Appcolors.TextformIconColor), // Color when the TextFormField is in focus
                    ),

                  ),

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              InkWell(
                onTap: (){
                  print("touch");

                },
                child: Container(
                  height:MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.8,

                  decoration: BoxDecoration(
                      color: Appcolors.boxinsidecolor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 10),
                        child: Icon(Icons.calendar_month_outlined,color: Appcolors.TextformIconColor,size: 28,),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 10),
                        child: Text("Choose birthday date ",style: TextStyle(
                          color: Appcolors.featuresNamecolor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),)
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
          RoundButton(title: "Confirm", onpress: () {
            if (_Firstname.text.isEmpty) {
              Utils.flushBarErrorMessage("First name Cannot be empty", context);
            } else if (_lastname.text.isEmpty) {
              Utils.flushBarErrorMessage("Last name cannot be empty", context);
            }
            else if (imageprovider.imagePath.isEmpty) {
              Utils.flushBarErrorMessage("Please set your profile photo", context);
            }
            else {
              authprovider.Details(context, _Firstname.text.toString(), _lastname.text.toString(),imageprovider.imagePath,_Firstname,_lastname);
              // Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.ChooseGender)));
              print("api hit");
            }
          }),





            ],
          ),
        ),
      )
    );
  }
}
