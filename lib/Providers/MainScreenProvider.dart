import 'package:flutter/material.dart';

import 'MainScreenProvider.dart';



class MainScreenProvider extends ChangeNotifier{
  Selectedindex _selectedindex = Selectedindex(0);


  void changeSelectedIndex(int index){
    _selectedindex  = Selectedindex(index);
    notifyListeners();
    print("notified");
  }
  Selectedindex get selectedindex => _selectedindex;
}

class Selectedindex {
  final int index;

  Selectedindex(this.index);


}