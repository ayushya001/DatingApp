import 'package:flutter/material.dart';

import '../Utils/AppComponentsColor.dart';


class Applogo extends StatelessWidget {
  final ImageProvider<Object> image;
  const Applogo({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.08 ,
      width: MediaQuery.of(context).size.width*0.1,
      // color: Colors.grey,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Appcolors.borderColorApplogo),

      ),
      child: Center(
        child: Container(
          height:MediaQuery.of(context).size.height*0.05 ,
          width: MediaQuery.of(context).size.width*0.1,

          decoration: BoxDecoration(
            image: DecorationImage(image: image,

                fit: BoxFit.fill),

            borderRadius: BorderRadius.circular(5),

            border: Border.all(color: Appcolors.borderColorApplogo,width: 2),

            // color: Colors.yellowAccent,

          ),


        ),
      ),
    );
  }
}
