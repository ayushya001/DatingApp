import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loveria/Models/Profile.dart';
import 'package:loveria/Utils/AppComponentsColor.dart';

class RequestSendWidget extends StatefulWidget {

  const RequestSendWidget({Key? key, required this.user}) : super(key: key);
  final ProfileModel user;


  @override
  State<RequestSendWidget> createState() => _RequestSendWidgetState();
}

class _RequestSendWidgetState extends State<RequestSendWidget> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.only(top: mq.height*0.02),
      child: SizedBox(
        height: mq.height * 0.1,
        child: Padding(
          padding:  EdgeInsets.only(left: mq.width*0.01,right: mq.width*0.01),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.white54,width: 2 ),
            ),

            child: Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: mq.width*0.02,right: mq.width*0.02),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: CachedNetworkImage(

                      width: mq.width * .12,
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
                ),
          RichText(
            maxLines: 1,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text:widget.user.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'cursive'
                  ),
                ),
                TextSpan(text: "   "),
                TextSpan(
                  text: 'Send you Match Request',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'cursive',
                    fontSize: 18

                  ),
                ),
              ],
            ),
          )








          ],
            ),




          ),
        ),
            ),
    );



  }
}
