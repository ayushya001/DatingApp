import 'package:flutter/material.dart';

class Code extends StatelessWidget {
  const Code({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



                                                ///profile card
// class ProfileCard extends StatelessWidget {
//   final String name;
//   const ProfileCard({Key? key, required this.name}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  EdgeInsets.only(
//           left: MediaQuery.of(context).size.width * 0.05,
//           right: MediaQuery.of(context).size.width * 0.05,
//           bottom: MediaQuery.of(context).size.width * 0.02),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//               border: Border.all(color: Appcolors.borderColorApplogo, width: 1),
//               image: DecorationImage(
//                 image: AssetImage("assets/images/g1.jpg"),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//
//                 colors: [
//                   Colors.black,
//                   Colors.transparent,
//                 ],
//                 stops: [0.0, 0.5],
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//               border: Border.all(color: Appcolors.borderColorApplogo, width: 1),
//             ),
//           ),
//           Positioned(
//               bottom: 0,
//
//               child: Padding(
//                 padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.06),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//
//                   children: [
//                     Text(
//                       "Shardha",style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 24
//                     ),
//
//
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height*0.006,),
//                     Text(
//                       " 24"+" km away",style: TextStyle(
//                       color: Colors.white,
//
//                     ),
//
//
//                     ),
//                   ],
//                 ),
//               )
//           )
//
//
//         ],
//       ),
//     );
//   }
// }

