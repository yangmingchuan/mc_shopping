import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 购物车 Provide
///

class CartProvide with ChangeNotifier{
  String cartString="[]";

  // 通过 sp 保存商品的详细信息
  save(goodsId,goodsName,count,price,images) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    /// 获取sp key 的字符串，如果为空则进行 赋值
    var temp=cartString==null?[]:json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList= (temp as List).cast();
  }

}