import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mc_shopping/model/details.dart';
import 'package:mc_shopping/service/service_method.dart';

///
/// 商品详情 Provide
///
class DetailsInfoProvide with ChangeNotifier{

  // 商品详情
  DetailsModel goodsInfo =null;

  /// 管理 Tab Bar 状态
  bool isLeft = true;
  bool isRight = false;

  /// 异步 从后台获取商品信息
  void getGoodsInfo(String id ) async {
    var formData = { 'goodId':id, };

    await requestPost('getGoodDetailById',formData:formData).then((val){
      var responseData= json.decode(val.toString());
      print('详情数据，$responseData');
      goodsInfo=DetailsModel.fromJson(responseData);
      notifyListeners();
    });

  }


  ///改变tabBar的状态
  changeLeftAndRight(String changeState){
    if(changeState=='left'){
      isLeft=true;
      isRight=false;
    }else{
      isLeft=false;
      isRight=true;
    }
    notifyListeners();

  }
}