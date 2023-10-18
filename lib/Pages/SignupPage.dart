import 'package:flutter/material.dart';
import 'package:loveria/Providers/AuthProvider.dart';
import 'package:loveria/Utils/AppComponentsColor.dart';
import 'package:provider/provider.dart';

import '../Components/RoundButton.dart';
import '../Utils/general_utils.dart';
import '../Utils/routes.dart';
import '../Utils/routesName.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  ValueNotifier<bool> _obsecurepassword = ValueNotifier<bool>(true);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ConfirmpasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode ConfirmpasswordFocusNode = FocusNode();


  @override
  void dispose() {



    _passwordController.dispose();
    _emailController.dispose();
    _ConfirmpasswordController.dispose();
    _obsecurepassword.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    ConfirmpasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("whole build");
    final authProvider = Provider.of<Authprovider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
          child:Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 80, // adjust the radius as needed
                      backgroundImage: AssetImage('assets/images/loveria.jpg'), // replace with your image path
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      decoration: InputDecoration(
                          hintText: "Enter your email",
                          hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                          labelText: "Email",
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


                          prefixIcon: Icon(Icons.alternate_email,color: Appcolors.TextformIconColor,)
                      ),
                      onFieldSubmitted: (val){
                        Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                      },

                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  ValueListenableBuilder(valueListenable: _obsecurepassword,
                      builder: (context,value,child) {
                        return  Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obsecurepassword.value,
                            focusNode: passwordFocusNode,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                                hintText: "Enter your Password",
                                hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock,color: Appcolors.TextformIconColor),

                                suffixIcon: InkWell(
                                    onTap: (){
                                      _obsecurepassword.value = !_obsecurepassword.value;
                                    },
                                    child: Icon(_obsecurepassword.value? Icons.visibility_off_outlined: Icons.visibility, color: _obsecurepassword.value ? Appcolors.TextformIconColor : Appcolors.TextformIconColor, )),
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
                        );
                      }
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  ValueListenableBuilder(valueListenable: _obsecurepassword,
                      builder: (context,value,child) {
                        return  Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),
                          child: TextFormField(
                            controller: _ConfirmpasswordController,
                            obscureText: _obsecurepassword.value,
                            focusNode: ConfirmpasswordFocusNode,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              hintText: "Confirm your Password",
                              hintStyle: TextStyle(color: Appcolors.hintTextcolor),
                              labelText: "Confirm Password",
                              prefixIcon: Icon(Icons.lock,color: Appcolors.TextformIconColor),

                              suffixIcon: InkWell(
                                  onTap: (){
                                    _obsecurepassword.value = !_obsecurepassword.value;
                                  },
                                  child: Icon(_obsecurepassword.value? Icons.visibility_off_outlined: Icons.visibility, color: _obsecurepassword.value ? Appcolors.TextformIconColor : Appcolors.TextformIconColor, )),
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
                        );
                      }
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                  RoundButton(title: 'Signup', onpress: (

                      ){
                    print("click hoo rha hai");

                    bool isValidEmail(String email) {
                      // Define a regular expression pattern for a basic email format
                      final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

                      return emailRegExp.hasMatch(email);
                    }

                    if(_emailController.text.isEmpty){
                      Utils.flushBarErrorMessage("Email Cannot be empty", context);
                    } else if (!isValidEmail(_emailController.text)) {
                      Utils.flushBarErrorMessage("Invalid email format", context);
                    }
                    else if(_passwordController.text.isEmpty){
                      Utils.flushBarErrorMessage("Password cannot be empty", context);
                    }else if(_passwordController.text.length<6){
                      Utils.flushBarErrorMessage("Lenght of password must be of six character", context);
                    }else if(_ConfirmpasswordController.text.isEmpty){
                      Utils.flushBarErrorMessage("Password cannot be empty", context);
                    }else if (_passwordController.text != _ConfirmpasswordController.text) {
                      Utils.flushBarErrorMessage("Password and Confirm Password must be the same", context);
                    }
                    else{
                      authProvider.Register(context,_emailController.text.toString(),_passwordController.text.toString());
                      // Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.ProfileDetails)));
                      print("api hit");
                    }

                  })
                ],
              ),
            ),
          ),
        )
    );
  }
}
