import 'package:flutter/material.dart';
import 'package:loveria/Models/ChatUserModel.dart';

import '../Models/ModelsClass.dart';

class Newpractise extends StatefulWidget {


  const Newpractise({Key? key, required this.user}) : super(key: key);

  // final Models user;

  final MessageCardModel user;



  // List<String>

  @override
  State<Newpractise> createState() => _NewpractiseState();
}

class _NewpractiseState extends State<Newpractise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
         "the name is :-${widget.user.name}"
        ),
      ),
    );
  }
}
