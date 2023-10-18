import 'package:flutter/material.dart';

import '../Utils/AppComponentsColor.dart';

class CardUsers extends StatelessWidget {
  const CardUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          bottom: MediaQuery.of(context).size.width * 0.02),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Appcolors.borderColorApplogo, width: 1),
        ),
      ),
    );
  }
}
