import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loveria/Widgetes/RequestSendWidget.dart';

import '../Api/firebaseApi.dart';
import '../Models/Profile.dart';
import '../Widgetes/ChatCard.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ProfileModel>  chatuser =[];

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("MatchesRequest")
          // .orderBy('lastActive',descending: false)
              .where('ReceiverId', isEqualTo: FirebaseApi.auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("this is still waiting");
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                print("this means snapshot has data");
                List<String> SenderId = snapshot.data!.docs
                    .map((doc) => doc['SenderId'] as String)
                    .toList();

                print("The sender ids are:-"+SenderId.toString());

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('LoveriaUsers')
                      .where('uid', whereIn: SenderId)
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

                    print("The chatuser lenght is"+chatuser.length.toString());

                    return ListView.builder(
                      itemCount: chatuser.length,
                      itemBuilder: (context, index) {
                        return RequestSendWidget( user: chatuser[index],);
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

      ),


    );
  }
}
