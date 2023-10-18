
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../FireBase  and Network/Swipe.dart';
import '../Models/Profile.dart';
import '../Providers/ProfileProvider.dart';
import '../Utils/AppComponentsColor.dart';
import 'ActionButton.dart';
import 'DragWidget.dart';


class CardsStackWidget extends StatefulWidget {
  const CardsStackWidget({Key? key}) : super(key: key);

  @override
  State<CardsStackWidget> createState() => _CardsStackWidgetState();
}

class _CardsStackWidgetState extends State<CardsStackWidget>
    with SingleTickerProviderStateMixin {


  // ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Provider.of<ProfileProvider>(context, listen: false)
            .removeLastProfile();
        _animationController.reset();
      }
    });
    Provider.of<ProfileProvider>(context, listen: false)
        .fetchDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(
        context, listen: false);
    print("whole build Cardsstack");
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, _) =>
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: List.generate(
                        profileProvider.draggableItems.length, (index) {
                      final profile = profileProvider.draggableItems[index];
                      final isLastCard = index ==
                          profileProvider.draggableItems.length - 1;
                      return isLastCard
                          ? PositionedTransition(
                        rect: RelativeRectTween(
                          begin: RelativeRect.fromSize(
                            const Rect.fromLTWH(0, 0, 580, 340),
                            const Size(580, 340),
                          ),
                          end: RelativeRect.fromSize(
                            Rect.fromLTWH(
                              profileProvider.swipeNotifier.value != Swipe.none
                                  ? profileProvider.swipeNotifier.value ==
                                  Swipe.left
                                  ? -300
                                  : 300
                                  : 0,
                              0,
                              580,
                              340,
                            ),
                            const Size(580, 340),
                          ),
                        ).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: RotationTransition(
                          turns: Tween<double>(
                            begin: 0,
                            end: profileProvider.swipeNotifier.value !=
                                Swipe.none
                                ? profileProvider.swipeNotifier.value ==
                                Swipe.left
                                ? -0.1 * 0.3
                                : 0.1 * 0.3
                                : 0.0,
                          ).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: const Interval(
                                  0, 0.4, curve: Curves.easeInOut),
                            ),
                          ),
                          child: DragWidget(
                            profile: profile,
                            index: index,
                            swipeNotifier: profileProvider.swipeNotifier,
                            isLastCard: true,
                          ),
                        ),
                      )
                          : DragWidget(
                        profile: profile,
                        index: index,
                        swipeNotifier: profileProvider.swipeNotifier,
                      );
                    }),
                  ),
            ),
            Positioned(
              left: 0,
              child: DragTarget<int>(
                builder: (BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,) {
                  return IgnorePointer(
                    child: Container(
                      height: 700.0,
                      width: 80.0,
                      color: Colors.transparent,
                    ),
                  );
                },
                onAccept: (int index) async {
                  profileProvider.rejectUser(index);

                  profileProvider.removeProfileAtIndex(index);
                },
              ),
            ),
            Positioned(
              right: 0,
              child: DragTarget<int>(
                builder: (BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,) {
                  return IgnorePointer(
                    child: Container(
                      height: 700.0,
                      width: 80.0,
                      color: Colors.transparent,
                    ),
                  );
                },
                onAccept: (int index) async {
                  profileProvider.matchRequestUser(index);

                  profileProvider.removeProfileAtIndex(index);
                  // print(profileProvider.MatchrequestUser.toString());
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.005,
              left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.2,
              right: MediaQuery
                  .of(context)
                  .size
                  .width * 0.2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButtonWidget(
                  onPressed: () {
                    profileProvider.swipeNotifier.value = Swipe.left;
                    //left
                    _animationController.forward();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.grey,
                  ),
                ),
                Spacer(),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                        color: Appcolors.borderColorApplogo, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 8,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    FontAwesomeIcons.fire,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
                Spacer(),
                ActionButtonWidget(
                  onPressed: () {
                    profileProvider.swipeNotifier.value = Swipe.right;
                    _animationController.forward();
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
