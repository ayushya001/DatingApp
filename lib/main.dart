import 'dart:developer';



import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loveria/Api/firebaseApi.dart';

import 'package:loveria/Pages/AutomationPage.dart';
import 'package:loveria/Providers/ChooseGenderProvider.dart';
import 'package:loveria/Providers/InterestsProvider.dart';
import 'package:loveria/Providers/MainScreenProvider.dart';
import 'package:provider/provider.dart';

import 'Pages/Slider.dart';
import 'Providers/AuthProvider.dart';
import 'Providers/ImagePickerProvider.dart';
import 'Providers/ProfileProvider.dart';
import 'Utils/routes.dart';
import 'Utils/routesName.dart';

  //global object for accessing device Screen Size
  late Size mediaq;



@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final firebaseApi = FirebaseApi();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) =>  MainScreenProvider()),
          ChangeNotifierProvider(create: (_) =>  ImageProviderClass()),
          ChangeNotifierProvider(create: (_) =>  Authprovider()),
          ChangeNotifierProvider(create: (_) =>  Interestprovider()),
          ChangeNotifierProvider(create: (_) =>  GenderProvidr()),
          ChangeNotifierProvider(create: (_) =>  ProfileProvider()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // set to false to remove debug banner
        initialRoute:  RoutesName.MainPage,
        onGenerateRoute: Routes.generateRoute,
      ),

    );
  }
}


