import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loveria/Models/MatchRequestModel.dart';

import '../Api/firebaseApi.dart';
import '../Models/Profile.dart';
import '../Widgetes/ChatCard.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseApi.updateActiveStatus(true);

    SystemChannels.lifecycle.setMessageHandler((message){
      print("kaam kar rha hai");
      log('Message: $message');

      if(message.toString().contains('resume')) FirebaseApi.updateActiveStatus(true);
      if(message.toString().contains('pause')) FirebaseApi.updateActiveStatus(false);
      return Future.value(message);
    }

    );
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    List<ProfileModel>  chatuser =[];
    
    List<MatchRequestModel>  Requestuser =[];
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Messages",
            style: TextStyle(
                color: Colors.white, // Change text color
                fontSize: 28, // Change font size
                fontWeight: FontWeight.bold,
                fontFamily: 'cursive'// Change font weight
            ),
          ),
          backgroundColor: Colors.blue, // Change background color
          elevation: 4.0, // Add shadow/elevation
          actions: [
            // Add any additional widgets/actions to your AppBar here
            IconButton(
              icon: Icon(Icons.search,
                size: 32,),
              onPressed: () {

              },
            ),
            IconButton(
              icon: Icon(Icons.settings,
                size: 32,),
              onPressed: () {

              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("MatchesRequest")
              // .orderBy('lastActive',descending: false)
              .where('SenderId', isEqualTo: FirebaseApi.auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("this is still waiting");
              return Center(child: Center(child: CircularProgressIndicator()));
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                print("this means snapshot has data");
                List<String> receiverIds = snapshot.data!.docs
                    .map((doc) => doc['ReceiverId'] as String)
                    .toList();

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('LoveriaUsers')
                      .where('uid', whereIn: receiverIds)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> loveriaSnapshot) {
                    if (loveriaSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Center(child: CircularProgressIndicator()));
                    }

                    if (loveriaSnapshot.hasError) {
                      return Text('Error: ${loveriaSnapshot.error}');
                    }

                    if (!loveriaSnapshot.hasData || loveriaSnapshot.data!.docs.isEmpty) {
                      return Text('No data available');
                    }

                    chatuser = loveriaSnapshot.data!.docs
                        .map((e) => ProfileModel.fromJson(e.data() as Map<String, dynamic>))
                        .toList();

                    return ListView.builder(
                      itemCount: chatuser.length,
                      itemBuilder: (context, index) {
                        return ChatCard(user: chatuser[index]);
                      },
                    );
                  },
                );
              } else {
                return const Text('No data available.'); // Handle case when snapshot has no data
              }
            }

            return const Text('Unknown error'); // Fallback in case none of the conditions match
          },
        )

    );
  }
}
