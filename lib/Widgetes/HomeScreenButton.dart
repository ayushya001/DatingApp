import 'package:flutter/material.dart';

import '../Utils/AppComponentsColor.dart';

class HomeScreenbutton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const HomeScreenbutton({Key? key, required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Appcolors.borderColorApplogo, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 8,
            blurRadius: 8,
            offset: Offset(0, 2), // Specifies the offset of the shadow
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 58,
        color: color,
      ),
    );
  }
}
