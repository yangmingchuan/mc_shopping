import 'package:flutter/material.dart';
import 'package:mc_shopping/model/CategoryModel.dart';

/// 分类二级列表 状态管理
///
class ChildCategory with ChangeNotifier{

  // 右侧导航商品列表
  List<BxMallSubDto> childCategoryList = [];
  //二级分类索引值
  int childIndex = 0;
  //一级分类索引
  int categoryIndex=0;

  //一级分类 选中ID
  String categoryId = '4';
  //小类ID
  String subId ='';
  //列表页数，当改变大类或者小类时进行改变
  int page=1;
  //显示更多的表示
  String noMoreText = '';

  // 点击一级分类 同步数据
  getChildCategory(List<BxMallSubDto> list,String id){
    categoryId=id;
    childIndex=0;
    page=1;
    BxMallSubDto all=  BxMallSubDto();
    all.mallSubId='00';
    all.mallCategoryId='00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList=[all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引 ,
  changeChildIndex(int index,String id){
    //传递两个参数，使用新传递的参数给状态赋值
    childIndex=index;
    subId=id;
    page=1;
    noMoreText='';
    notifyListeners();
  }

  //首页点击类别是更改类别
  changeCategory(String id,int index){
    categoryId=id;
    categoryIndex=index;
    subId ='';
    notifyListeners();
  }

  //增加Page的方法f
  addPage(){
    page++;
  }
  //改变noMoreText数据
  changeNoMore(String text){
    noMoreText=text;
    notifyListeners();
  }


}