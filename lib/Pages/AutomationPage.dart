import 'package:flutter/material.dart';



class AutomationPage extends StatelessWidget {
  const AutomationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.6,
                  width: MediaQuery.of(context).size.width*0.7,
                  alignment: Alignment.center,


                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                        image:AssetImage(
                          "assets/images/g2.jpg",
                        ),

                    )
                  ),


                ),
              ),
            )
          ],
        ),

      ),

    );

  }
}
