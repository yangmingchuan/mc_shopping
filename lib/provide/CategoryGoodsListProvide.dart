import 'package:flutter/material.dart';
import 'package:mc_shopping/model/CategoryGoodsList.dart';

/// -------   监听 分类详细商品列表 修改监听器  -------
///
///
class CategoryGoodsListProvide with ChangeNotifier{

  List<CategoryListData> goodsList = [];

  //点击大类时更换商品列表
  getGoodsList(List<CategoryListData> list){

    goodsList=list;
    notifyListeners();
  }

  //上拉加载列表
  addGoodsList(List<CategoryListData> list){
    goodsList.addAll(list);
    notifyListeners();
  }

}