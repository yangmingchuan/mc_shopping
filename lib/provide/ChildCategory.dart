import 'package:flutter/material.dart';
import 'package:mc_shopping/model/CategoryModel.dart';

/// 分类二级列表 状态管理
class ChildCategory with ChangeNotifier{

  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list){
    BxMallSubDto all=  BxMallSubDto();
    all.mallSubId='00';
    all.mallCategoryId='00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList=[all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

}