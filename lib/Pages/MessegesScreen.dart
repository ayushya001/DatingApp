import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loveria/Api/firebaseApi.dart';
import 'package:loveria/Models/Profile.dart';
import 'package:loveria/Widgetes/MessegeTopBar.dart';
import 'package:loveria/main.dart';

import '../Models/ChatUserModel.dart';
import '../Models/MessegesModel.dart';
import '../Widgetes/messege_card.dart';

class MessegeScreens extends StatefulWidget {
  const MessegeScreens({Key? key, required this.user}) : super(key: key);

  final ProfileModel user;



  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<MessegeScreens> createState() => _MessegeScreensState();
}

class _MessegeScreensState extends State<MessegeScreens> {

  List<MessegesModel> _chats = [];

  final _textController = TextEditingController();

  bool _showEmoji = false,
  _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
         child: SafeArea(
          child: WillPopScope(
          //if emojis are shown & back button is pressed then hide emojis
          //or else simple close current screen on back button click
        onWillPop: () {
           if (_showEmoji) {
            setState(() => _showEmoji = !_showEmoji);
           return Future.value(false);
           } else {
          return Future.value(true);
        }
    },
          child:

      Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MessegeTopBar(user: widget.user,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseApi.getAllMessages(widget.user),
                // stream: FirebaseFirestore.instance.collection("LoveriaUsers").snapshots(),
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


                      final data = snapshot.data!.docs;

                      _chats = data
                          .map((e) => MessegesModel.fromJson(e.data() as Map<String, dynamic>))
                          .toList();


                      return ListView.builder(
                        // reverse: true,

                        itemCount:_chats.length,
                        itemBuilder: (context, index) {
                          return MessegeCard(chats: _chats[index],user: widget.user,);
                        },
                      );
                    } else {
                      return const Text('No data available.'); // Handle case when snapshot has no data
                    }
                  }

                  return Expanded(child: Center(child: const Text('Say hii! 👋'))); // Fallback in case none of the conditions match
                },

              ),
            ),
            if (_isUploading)
              const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: CircularProgressIndicator(strokeWidth: 2))),

            chatInput(),
            if (_showEmoji)
              SizedBox(
                height: MediaQuery.of(context).size.height * .35,
                child: EmojiPicker(
                  textEditingController: _textController,
                  config: Config(
                    bgColor: Colors.white,
                    columns: 8,
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                  ),
                ),
              )
          ],
        )
      )
    )
    )
    )
    );
  }
  Widget chatInput(){
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*.01,horizontal:MediaQuery.of(context).size.width*0.03),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color:  Color(0xFFE8E6EA),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: (){
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);

                      },
                      icon: Icon(Icons.emoji_emotions) , color: Colors.redAccent,),

                  Expanded(
                    child: TextField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onTap: () {
                        if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                      },
                      decoration: InputDecoration(
                          hintText: "Write Something",
                        hintStyle: TextStyle(color: Colors.redAccent),
                        border: InputBorder.none
                      ),

                    ),
                  ),

                  //pick image from gallery button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                        await picker.pickMultiImage(imageQuality: 70);

                        // uploading & sending image one by one
                        for (var i in images) {
                          log('Image Path: ${i.path}');
                          setState(() => _isUploading = true);
                          await FirebaseApi.sendChatImage(widget.user, File(i.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.image,
                          color: Colors.redAccent, size: 26)),
                  //take image from camera button
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 70);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() => _isUploading = true);

                          await FirebaseApi.sendChatImage(
                              widget.user, File(image.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(Icons.camera_alt_rounded,
                          color: Colors.redAccent, size: 26)),


                ],
              ),
            ),
          ),
          MaterialButton(onPressed: (){
            if (_textController.text.isNotEmpty) {
              if (_chats.isEmpty) {
                //on first message (add user to my_user collection of chat user)
                FirebaseApi.sendFirstMessage(
                    widget.user, _textController.text, Type.text);
              } else {
                //simply send message
                FirebaseApi.sendMessage(
                    widget.user, _textController.text, Type.text);
              }
              _textController.text = '';
            }

          },
            padding: EdgeInsets.only(left: 3),
            shape: CircleBorder(),
            minWidth: 0,
            color: Colors.redAccent,
            child: Icon(Icons.send , color: Colors.white, size: 28,),


          )
        ],
      ),
    );
  }
}
