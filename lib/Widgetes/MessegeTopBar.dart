import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loveria/Utils/dateTimeUtils.dart';

import '../Api/firebaseApi.dart';
import '../Models/Profile.dart';

class MessegeTopBar extends StatefulWidget {
  const MessegeTopBar({Key? key, required this.user}) : super(key: key);

  final ProfileModel user;

  @override
  State<MessegeTopBar> createState() => _MessegeTopBarState();
}

class _MessegeTopBarState extends State<MessegeTopBar> {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    List<ProfileModel> list = [];

    final mq = MediaQuery.of(context).size;
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black, // Specify the border color here
            width: 1.0, // Specify the border width here
          ),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: mq.width*0.02,right: mq.width*0.02),
        child: Expanded(
          child: Row(

            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back,size: 32,)),
              SizedBox(width: mq.width*0.03,),
              CachedNetworkImage(
                width: mq.width*.12,
                imageUrl: widget.user.image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover, // You can use BoxFit.cover to ensure the image fits within the circle
                    ),
                  ),
                ),
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(width: mq.width*0.03,),
              SizedBox(
                height: preferredSize.height,


                child: Padding(
                  padding: EdgeInsets.only(right: 10,bottom: 1),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(widget.user.name,style: TextStyle(
                          fontFamily: 'cursive',
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),),

                        //for last seen
                        StreamBuilder(
                          stream: FirebaseApi.getUserInfo(widget.user),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data = snapshot.data!.docs;
                              print("the data is:"+data.toString());


                              list = data
                                  .map((e) => ProfileModel.fromJson(e.data() as Map<String, dynamic>))
                                  .toList();

                              print("the list is:"+list.toString());

                              return Text( list[0].isOnline ? 'online' : MyDateUtil.getLastActiveTime(context: context, lastActive: list[0].lastActive),
                              style: TextStyle(fontFamily: 'cursive',fontWeight: FontWeight.bold,fontSize: 16,color: Colors.black),);
                            } else {
                              return CircularProgressIndicator(); // or any other loading indicator
                            }
                          },
                        )

                      ],
                    ),
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
