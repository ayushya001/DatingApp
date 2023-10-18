
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loveria/Providers/AuthProvider.dart';
import 'package:provider/provider.dart';

import '../Utils/routes.dart';
import '../Utils/routesName.dart';

class Interestprovider with ChangeNotifier{


  List<String> _selectedItem =  [];

  List<String> get selectedItem => _selectedItem;

  void addItem(String value){
    _selectedItem.add(value);
    print("selectedlist"+_selectedItem.toString());
    notifyListeners();
  }

  void removeItem(String value){
    _selectedItem.remove(value);
    print("selectedlist"+_selectedItem.toString());

    notifyListeners();
  }

  void StoreInterests(BuildContext context ) async {

    try {
      final interestsMap = {'interests': _selectedItem};

      final CurrentUser  = FirebaseAuth.instance.currentUser;
      if(CurrentUser!=null){
        final authprovider = Provider.of<Authprovider>(context, listen: false); // Use the existing instance
        authprovider.setloading(true);
        final uid = CurrentUser.uid;
        await FirebaseFirestore.instance
            .collection("LoveriaUsers")
            .doc(uid)
            .update(interestsMap);


        authprovider.setloading(false);

        Navigator.push(context, Routes.generateRoute(RouteSettings(name:  RoutesName.MainPage)));

        _selectedItem.clear();

      }
    } catch (e) {
      print("Error storing interests: $e");
    }

  }

}