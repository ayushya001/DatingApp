import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loveria/Api/firebaseApi.dart';
import 'package:loveria/Models/ModelsClass.dart';
import 'package:loveria/Models/Profile.dart';
import 'package:loveria/Widgetes/ChatCard.dart';

import '../Models/ChatUserModel.dart';

class MatchSends extends StatelessWidget {
  const MatchSends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      List<ProfileModel>  chatuser =[];
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
        stream: FirebaseFirestore.instance.collection("MatchesRequest").where("SenderId",isEqualTo:FirebaseApi.auth.currentUser!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("this is still waiting");
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {

            if (snapshot.hasError) {
              return const Text('Error');
            }
            else if (snapshot.hasData) {
              print("this mean snapshot has data");


              // final data = snapshot.data?.docs;
              final data = snapshot.data!.docs;

              chatuser = data
                  .map((e) => ProfileModel.fromJson(e.data() as Map<String, dynamic>))
                  .toList();

              // print("the length of chatuser is"+ chatuser.toString());


              return ListView.builder(
                itemCount:chatuser.length,
                itemBuilder: (context, index) {
                  return ChatCard(user: chatuser[index],);
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
