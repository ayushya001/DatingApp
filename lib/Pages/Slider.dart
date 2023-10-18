import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:loveria/Components/RoundButton.dart';
import 'package:loveria/Utils/routes.dart';

import '../Utils/routesName.dart';

class SliderPage extends StatefulWidget {

  const SliderPage({Key? key}) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  final List<Image> images = [
    Image(image:AssetImage("assets/images/g1.jpg",)),
    Image(image:AssetImage("assets/images/g2.jpg",)),
    Image(image:AssetImage("assets/images/g3.jpg",)),

  ];
  final List<String> FeaturesName = [
    "Algorithm",
    "Matches",
    "Premium",
  ];
  final List<String> Description = [
    "Users going through a vetting process to ensure you never match with bots.",
    "We match you with people that have a large array of similar interests.",
    "Sign up today and enjoy the first month of premium benefits on us.",
  ];

  bool _isPlaying = true;

  late CarouselSliderController _sliderController;

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height*0.76,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                unlimitedMode: true,
                controller: _sliderController,
                slideBuilder: (index) {
                  return Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.6,
                            width: MediaQuery.of(context).size.width*0.8,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:images[index].image,
                                )
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                            child: Center(
                              child: Text(FeaturesName[index],
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 32,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.7,
                              child: Center(
                                  child: Text(
                                      Description[index],
                                    textAlign: TextAlign.center,
                                  )
                              ),

                            ),
                          )

                        ],
                      ),
                    ),
                  );
                },
                slideTransform: BackgroundToForegroundTransform(),
                itemCount: images.length,
                initialPage: 0,
                enableAutoSlider: true,
                slideIndicator: CircularSlideIndicator(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.0),
                  currentIndicatorColor: Colors.red,
                  indicatorBackgroundColor: Colors.grey
                ),
              ),
            ),
            
          ),
          // ElevatedButton(onPressed: onPressed, child: child)
          Padding(
            padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
            child: Center(
              child: RoundButton(title: "Create an account",onpress:(){
                Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.CreateAccount)));

    } ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Already have an account ? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Signin",
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {

                          Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.login)));

                        },
                    ),
                  ],
                ),
              ),
            ),
          )


        ],
      ),
    );
  }
}
