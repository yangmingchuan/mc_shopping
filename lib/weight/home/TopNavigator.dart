import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/model/CategoryModel.dart';
import 'package:mc_shopping/provide/ChildCategory.dart';
import 'package:mc_shopping/provide/currentIndex.dart';
import 'package:mc_shopping/service/service_method.dart';
import 'package:provide/provide.dart';

/// 顶部 表格导航栏
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  /// 构造方法 key我真的很费解
  TopNavigator({Key key ,this.navigatorList}) : super(key: key);

  /// 将每个 item 抽取出来
  Widget _gridViewItemUI(context,item,index){
    ///InkWell: 点击水波纹效果
    return InkWell(
      onTap: (){
        _goCategory(context,index,item['mallCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(90)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  /// 分类点击事件
  void _goCategory(context,int index,String categroyId) async {
    await requestPost('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      List list = category.data;
      Provide.value<ChildCategory>(context).changeCategory(categroyId,index);
      Provide.value<ChildCategory>(context).getChildCategory(list[index].bxMallSubDto,categroyId);
      /// 改变下标 home 界面会同步刷新 模拟出界面跳转的效果
      Provide.value<CurrentIndexProvide>(context).changeIndex(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    var intdex = -1;
    return Container(
      height: ScreenUtil().setHeight(250),
      padding:EdgeInsets.all(3.0),

      /// gridview 一行5个，遍历设置 item
      child: GridView.count(crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        // GridView 禁止滑动
        physics: NeverScrollableScrollPhysics(),
        children: navigatorList.map((f){
          intdex++;
          return _gridViewItemUI(context,f,intdex);
        }).toList(),
      ),
    );
  }
}