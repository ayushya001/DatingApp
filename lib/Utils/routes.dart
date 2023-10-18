

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveria/Components/practise.dart';
import 'package:loveria/Pages/ChooseGender.dart';
import 'package:loveria/Pages/FullPhoto.dart';
import 'package:loveria/Pages/Homepage.dart';
import 'package:loveria/Pages/Intersts.dart';
import 'package:loveria/Pages/LoginPage.dart';
import 'package:loveria/Pages/CreateAccount.dart';
import 'package:loveria/Pages/MainPage.dart';
import 'package:loveria/Pages/MatchesScreen.dart';
import 'package:loveria/Pages/MatchesSend.dart';
import 'package:loveria/Pages/MessegesScreen.dart';
import 'package:loveria/Pages/ProfileDetails.dart';
import 'package:loveria/Pages/ProfilePage.dart';
import 'package:loveria/Pages/Slider.dart';
import 'package:loveria/Pages/SplashActivity.dart';
import 'package:loveria/Utils/routesName.dart';

import '../Pages/SignupPage.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.Signup:
        return MaterialPageRoute(builder: (BuildContext context) => const Signup());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context ) => const Login());

      case RoutesName.Slider:
        return MaterialPageRoute(builder: (BuildContext context ) => const SliderPage());

      case RoutesName.CreateAccount:
        return MaterialPageRoute(builder: (BuildContext context ) => const CreateAccount());

      case RoutesName.ProfileDetails:
        return MaterialPageRoute(builder: (BuildContext context ) => const ProfileDetails());

      case RoutesName.ProfilePage:
        return MaterialPageRoute(builder: (BuildContext context ) => const ProfilePage());

      case RoutesName.ChooseGender:
        return MaterialPageRoute(builder: (BuildContext context ) => const ChooseGender());

      case RoutesName.InterstedPage:
        return MaterialPageRoute(builder: (BuildContext context ) => const Intersted());

      case RoutesName.HomePage:
        return MaterialPageRoute(builder: (BuildContext context ) => HomePage());

      case RoutesName.MatchesScreen:
        return MaterialPageRoute(builder: (BuildContext context ) => const MatchesScreen());

      case RoutesName.MatchesSendsScreen:
        return MaterialPageRoute(builder: (BuildContext context ) => const MatchSends());

      // case RoutesName.MessegeScreen:
      //   return MaterialPageRoute(builder: (BuildContext context ) => const MessegeScreens(u,));

      case RoutesName.FullPhotoScreen:
        return MaterialPageRoute(builder: (BuildContext context ) => const FullPhotoScreen());

      case RoutesName.code:
        return MaterialPageRoute(builder: (BuildContext context ) => const Code());

      case RoutesName.MainPage:
        return MaterialPageRoute(builder: (BuildContext context ) => const Mainpage());

      case RoutesName.SplashActivity:
        return MaterialPageRoute(builder: (BuildContext context ) => const SplashActivity());



      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text(
                  "No routes selected"
              ),
            ),
          );
        });
    }
  }
}