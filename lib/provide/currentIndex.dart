import 'package:flutter/material.dart';

///
/// index page  下标
///

class CurrentIndexProvide with ChangeNotifier{

  int currentIndex=0;

  changeIndex(int newIndex){
    currentIndex=newIndex;
    notifyListeners();
  }

}