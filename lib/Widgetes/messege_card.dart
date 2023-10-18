import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loveria/Models/MessegesModel.dart';
import 'package:loveria/Utils/AppComponentsColor.dart';
import 'package:loveria/Utils/dateTimeUtils.dart';

import '../Models/Profile.dart';

class MessegeCard extends StatefulWidget {
  const MessegeCard({Key? key, required this.chats, required this.user}) : super(key: key);

  final MessegesModel chats;
  final ProfileModel user;


  @override
  State<MessegeCard> createState() => _MessegeCardState();
}

class _MessegeCardState extends State<MessegeCard> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom: MediaQuery.of(context).size.width*0.01),
      child: widget.user.uid == widget.chats.fromid ? _redMessege() : _whiteMessege(),
    );
  }
  Widget _redMessege(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: MediaQuery.of(context).size.width*0.04),
              padding: EdgeInsets.all(widget.chats.type == Type.image?
              MediaQuery.of(context).size.width*0.005:MediaQuery.of(context).size.width*0.04 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)
                ),
                color: Colors.red, // Customize the color as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2), // Adjust shadow position as needed
                  ),
                ],
              ),
              child: widget.chats.type == Type.text?Text(
                widget.chats.msg,
                style: TextStyle(
                  color: Colors.white,
                ),
              ):
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(

                      imageUrl: widget.chats.msg,
                      errorWidget: (context,url,error)=> const Icon(Icons.image,size: 70,),
                    ),
                  )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.04),
            child: Text(
              MyDateUtil.getFormattedTime(context: context, time: widget.chats.sent),
              style: TextStyle(
                fontSize: 12,
                color: Colors.black
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _whiteMessege(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04),
            child: Text(
              MyDateUtil.getFormattedTime(context: context, time: widget.chats.sent),
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: MediaQuery.of(context).size.width*0.04),
            padding: EdgeInsets.all(widget.chats.type == Type.image?
            MediaQuery.of(context).size.width*0.005:MediaQuery.of(context).size.width*0.04 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
              ),
              color: Colors.white, // Customize the color as needed
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // Adjust shadow position as needed
                ),
              ],
            ),
            child: widget.chats.type == Type.text?Text(
              widget.chats.msg,
              style: TextStyle(
                color: Colors.black,
              ),
            ):
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(

                imageUrl: widget.chats.msg,
                errorWidget: (context,url,error)=> const Icon(Icons.image,size: 70,),
              ),
            )
          ),
        ),

      ],
    );
  }

}
