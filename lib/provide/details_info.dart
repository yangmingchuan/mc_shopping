import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mc_shopping/model/details.dart';
import 'package:mc_shopping/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier{

  // 商品详情
  DetailsModel goodsInfo =null;

  /// 从后台获取商品信息
  void getGoodsInfo(String id ){
    var formData = { 'goodId':id, };

    requestPost('getGoodDetailById',formData:formData).then((val){
      var responseData= json.decode(val.toString());
      print('详情数据，$responseData');
      goodsInfo=DetailsModel.fromJson(responseData);
      notifyListeners();
    });


  }
}