



import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../FireBase  and Network/Swipe.dart';
import '../Models/Profile.dart';
import 'dart:developer' as developer;

class ProfileProvider extends ChangeNotifier {
  List<ProfileModel> draggableItems = [];
  List<String> rejectuser = [];
  List<String> MatchrequestUser = [];
  final ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  final auth = FirebaseAuth.instance.currentUser!.uid;


  Future<void> fetchDataFromFirestore() async {
    try {

      // Get the ReceiverIDs from the "matchrequest" collection
      final matchRequestQuery = await FirebaseFirestore.instance
          .collection("MatchesRequest")
          .where('SenderId', isEqualTo: auth) // Replace 'auth' with your sender ID
          .get();

      // Extract the receiverIDs from the matchrequest query
      List receiverIDs = matchRequestQuery.docs.map((doc) => doc['ReceiverId']).toList();
      receiverIDs.add(auth);

      print("The receiver ids are:-"+receiverIDs.toString());

      // Query the "LoveriaUsers" collection and exclude the sender IDs
      final snapshot = await FirebaseFirestore.instance
          .collection("LoveriaUsers")
          .where('uid', whereNotIn: receiverIDs)
          .get();

      draggableItems = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print("Image URL: ${data['image']}");
        return ProfileModel(
          name: data['firstName'] ?? '',
          distance: '10 miles away',
          image: data['image'] ?? 'assets/images/fbhd.png',
          uid: data['uid'],
          isOnline: data['isOnline'],
          lastActive: data['lastActive'], pushToken: '',
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void removeLastProfile() {
    if (draggableItems.isNotEmpty) {
      draggableItems.removeLast();
      swipeNotifier.value = Swipe.none;
      notifyListeners();
    }
  }

  void removeProfileAtIndex(int index) {

    if (index >= 0 && index < draggableItems.length) {
      draggableItems.removeAt(index);
      developer.log(draggableItems.toString(), name: 'rejectuser', error: 'Debug Log');

      // print("removeProfileAtindex"+draggableItems[index].name.toString());
      notifyListeners();
    }
  }

  void rejectUser(int index) async {
    print("this is rejectuser and the index is:"+ index.toString());
    developer.log('', name: 'rejectuser', error: 'Debug Log');
    try{
      if (index >= 0 && index < draggableItems.length) {

        rejectuser.add(draggableItems[index].name);


        if (auth != null) {
          Map<String, dynamic> Rejecteduser = {
            "RejectedbyId":auth,
            "RejectedUserId":draggableItems[index].uid,
          };
          await FirebaseFirestore.instance.collection("RejectedUser").doc().set(Rejecteduser);
          notifyListeners();
        }
        notifyListeners();
      }else{
        developer.log("this is else means the index is more than lenght",name: "catchelse");


      }
    }catch(e){
      developer.log(e.toString(),name: "catcherror");
    }





  }

  void matchRequestUser(int index) async {
    print("the index is "+index.toString());


    if (index >= 0 && index < draggableItems.length) {
      MatchrequestUser.add(draggableItems[index].uid);



      if (auth != null) {
        Map<String, dynamic> matchRequest = {
        "SenderId":auth,
          "ReceiverId":draggableItems[index].uid,
          "Result":"",
      };
        await FirebaseFirestore.instance.collection("MatchesRequest").doc().set(matchRequest);
        notifyListeners();
    }





    }else{
      developer.log("this is else means the index is more than lenght",name: "catchelse");


    }
  }
}