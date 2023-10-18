import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loveria/Api/firebaseApi.dart';
import 'package:loveria/Models/Profile.dart';
import 'package:loveria/Pages/MessegesScreen.dart';

import '../Models/ChatUserModel.dart';
import '../Pages/newpractise.dart';


class ChatCard extends StatefulWidget {
  final ProfileModel user;

  const ChatCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {


  @override
  Widget build(BuildContext context) {

    List<String> lastMesseges=[];

    final mq = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: SizedBox(
        height: mq.height * 0.1,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          // color: Colors.green,
          margin: EdgeInsets.only(
              left: mq.width * 0.04, right: mq.width * 0.04, bottom: 4),
          elevation: 2,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MessegeScreens(user: widget.user),
                ),
              );
            },
            child: Center(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: mq.height * 0.01, horizontal: mq.width * 0.015),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(

                    width: mq.width * .1,
                    imageUrl: widget.user.image,
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit
                                  .cover, // You can use BoxFit.cover to ensure the image fits within the circle
                            ),
                          ),
                        ),
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                title: Text(widget.user.name),

                subtitle:

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseApi.getLastMessage(widget.user),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> Snapshot) {
                    if (Snapshot.hasData) {
                      final data = Snapshot.data!.docs;
                      lastMesseges = Snapshot.data!.docs
                          .map((doc) => doc['msg'] as String)
                          .toList();

                      if (lastMesseges.isNotEmpty) {
                        return Text(lastMesseges[0]);
                      } else {
                        return Text("Say hello!!");
                      }
                    } else {
                      return Text("Say hello !!");
                    }
                  },
                ),

            //     trailing: Padding(
            //   padding:EdgeInsets.only(right: mq.width*0.02,),
            //   child: Text(
            //     "12:00 PM",
            //     style: TextStyle(
            //         color: Colors.black54
            //     ),
            //   ),
            // ),
          ),


        ),
      ),
    ),)
    ,
    );

  }
}