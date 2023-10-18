
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'dart:math';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:loveria/Models/MessegesModel.dart';
import 'package:loveria/Pages/MessegesScreen.dart';

import '../Models/MatchRequestModel.dart';
import '../Models/Profile.dart';

class FirebaseApi{

  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;


  // to return current user
  static User get user => auth.currentUser!;


  // for accessing firebase messaging (Push Notification)
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;


  final FlutterLocalNotificationsPlugin _flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

  // for getting firebase messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    await fMessaging.getToken().then((t) {
      if (t != null) {
        FirebaseFirestore.instance.collection('LoveriaUsers').doc(user.uid).update({
          'pushToken': t,
        });
        print('Push Token: $t');
      }
    });
  }



  void initLocalNotification(BuildContext context,RemoteMessage message) async {
    var androidInitilizationSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSetting = DarwinInitializationSettings();


    var initilizationSetting = InitializationSettings(
      android: androidInitilizationSetting,
      iOS: iosInitializationSetting
    );
    // Define a static function as the backgroundHandler
     Future<void> backgroundHandler(String payload) async {
      // Handle background notifications here
      //  handleMessage(context, message);
    }

    await _flutterNotificationPlugin.initialize(
        initilizationSetting,
        onDidReceiveNotificationResponse: (payload){
          // handle interaction when app is active for android
          handleMessage(context, message);
        }
    );




  }

   void firebaseinit(BuildContext context) {

     FirebaseMessaging.onMessage.listen((message) {

       // if (kDebugMode) {
       //   print("notifications title:${notification!.title}");
       //   print("notifications body:${notification.body}");
       //   print('count:${android!.count}');
       //   print('data:${message.data.toString()}');
       // }

       print("Title is:-"+message.notification!.title.toString());
       print("Body is:-"+message.notification!.body.toString());

       if (Platform.isAndroid) {
         initLocalNotification(context,message);
         showNotification(message);
       }
     });
  }

  Future<void> showNotification(RemoteMessage message) async {


    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString() ,
        importance: Importance.max  ,
        showBadge: true ,
        playSound: true,
        sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')
    );

    // function to show visible notification when app is active


    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        channelDescription: "your channel Description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker'
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero,(){
      _flutterNotificationPlugin.show(
      0,
    message.notification!.title.toString(),
    message.notification!.body.toString(),
    notificationDetails);

    });



  }


  Future<void> SetupInteractMessage(BuildContext context) async {

    // when app is terminated

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage!=null){
      handleMessage(context, initialMessage);
    }

    // when app is inbackground
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    
    // if(message.data['Type']==Type.text){
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>
    //       MessegeScreens(user: message.data['User'])
    //   ));
    // }

    // if(message.data['type']=='msg'){[
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => MessegeScreens(user: user)))
    // ]

    // if(message.data.isNotEmpty){
    //   print("Object is not empty");
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => MessegeScreens(user: message.data['User'])));
    //   print("messege accomplished");
    // }else{
    //   print("data is emptyy...");
    // }



  }





  // for sending push notification
  static Future<void> sendPushNotification(
      ProfileModel chatUser, String msg) async {
    try {
      final data = {
        "to": chatUser.pushToken,
        "notification": {
          "title": chatUser.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        // "data": {
        //   "User": chatUser ,
        //   "Type" : Type ,
        // },
      };



      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=AAAA7t6ofbw:APA91bEI5QHffGWfTV865CL6BYb8LpQdtnPGWWEJsqYA9KslgZsM7ug0eXcEJVTEzkpS-a7S7YhfpTDZ_wBOJhRWPJToZt6HNQu6FU-qthIdJCX1HYgXQXSyZuEoglJaQEraluOEZf8K'
          },
          body: jsonEncode(data));
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }

  // for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ProfileModel chatUser) {
    return FirebaseFirestore.instance
        .collection('LoveriaUsers')
        .where('uid', isEqualTo: chatUser.uid)
        .snapshots();
  }


  // update online or last active status of user
  static Future<void> updateActiveStatus(bool isOnline) async {
    FirebaseFirestore.instance.collection('LoveriaUsers').doc(user.uid).update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().millisecondsSinceEpoch.toString(),
      // 'push_token': me.pushToken,
    });
  }


  // for adding an user to my user when first message is send
  static Future<void> sendFirstMessage(
      ProfileModel chatUser, String msg, Type type) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(chatUser.uid)
        .collection('my_users')
        .doc(user.uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }


  // useful for getting conversation id
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';
  
  

  // for getting all messages of a specific conversation from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ProfileModel user) {
    return FirebaseFirestore.instance
        .collection('chats/${getConversationID(user.uid)}/messages/')
        .orderBy('sent', descending:false)
        .snapshots();
  }

  static Future<void> sendMessage(
      ProfileModel chatUser, String msg, Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final MessegesModel message = MessegesModel(
        toid: chatUser.uid,
        msg: msg,
        read: '',
        type: type,
        fromid: user.uid,
        sent: time);

    final ref = FirebaseFirestore.instance
        .collection('chats/${getConversationID(chatUser.uid)}/messages/').doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(chatUser, type == Type.text ? msg : 'image'));

  }

  static  Stream<QuerySnapshot<Map<String, dynamic>>> getMatchRequestedUser()  {


    return FirebaseFirestore.instance
        .collection("MatchesRequest")
        .where("SenderId", isEqualTo: FirebaseApi.auth.currentUser!.uid)
        .snapshots();




  }

  //get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ProfileModel user) {
    return FirebaseFirestore.instance
        .collection('chats/${getConversationID(user.uid)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }


//
//   //update read status of message
//   static Future<void> updateMessageReadStatus(Message message) async {
//     firestore
//         .collection('chats/${getConversationID(message.fromId)}/messages/')
//         .doc(message.sent)
//         .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
//   }
//
//   //get only last message of a specific chat
//   static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
//       ChatUser user) {
//     return firestore
//         .collection('chats/${getConversationID(user.id)}/messages/')
//         .orderBy('sent', descending: true)
//         .limit(1)
//         .snapshots();
//   }
//
  //send chat image
  static Future<void> sendChatImage(ProfileModel chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.uid)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }





  
}