import 'package:flutter/material.dart';

import '../Utils/AppComponentsColor.dart';


class TopbarHome extends StatelessWidget {
  const TopbarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding:  EdgeInsets.only(top: 10),
        child: Container(
          height: MediaQuery.of(context).size.height*0.08 ,
          width: MediaQuery.of(context).size.width*0.8 ,
          // color: Colors.red,
          child: Row(
            children: [

              InkWell(
                onTap: () {

                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Appcolors.borderColorApplogo, width: 2),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Appcolors.featuresNamecolor, // Set the arrow color here
                  ),
                ),
              ),
              Spacer(),
              Text("Discover",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              ),),
              Spacer(),

              InkWell(
                onTap: () {

                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Appcolors.borderColorApplogo, width: 2),
                  ),
                  child: Icon(
                    Icons.filter_list,
                    color: Appcolors.featuresNamecolor, // Set the arrow color here
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
