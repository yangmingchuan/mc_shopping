import 'package:flutter/material.dart';

/// ChangeNotifier 不用管理听众
class Counter with ChangeNotifier{
  int value =0 ;

  increment(){
    value++;
    ///通知听众刷新
    notifyListeners();
  }
}