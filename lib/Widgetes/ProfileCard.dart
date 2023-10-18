import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Models/Profile.dart';
import '../Utils/AppComponentsColor.dart';


class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.profile}) : super(key: key);
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.65,
      width: MediaQuery.of(context).size.width*0.8,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Appcolors.borderColorApplogo, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(

                profile.image,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,

                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
                stops: [0.0, 0.5],
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Appcolors.borderColorApplogo, width: 1),
            ),
          ),
          Positioned(
              bottom: 0,

              child: Padding(
                padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      profile.name,style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    ),


                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.006,),
                    Text(
                      profile.distance,style: TextStyle(
                      color: Colors.white,

                    ),


                    ),
                  ],
                ),
              )
          )


        ],
      ),
    );
  }
}
