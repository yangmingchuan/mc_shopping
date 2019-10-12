
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/model/CategoryModel.dart';
import 'package:mc_shopping/provide/ChildCategory.dart';
import 'package:mc_shopping/service/service_method.dart';
import 'package:mc_shopping/weight/RightCategoryNav.dart';
import 'package:provide/provide.dart';

///分类界面

class CategoryPage extends StatefulWidget {

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(1280),
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
              ],
            )
          ],
        ),
      ),
    );
  }

}


/// 左侧 一级分类列表
class LeftCategoryNav extends StatefulWidget {

  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  // 数据集合
  List list = [];

  var listIndex = 0; //索引

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(width: 0.2,color:Colors.black12)
          )
      ),
      child: ListView.builder(
        itemCount:list.length,
        itemBuilder: (context,index){
          return _leftInkWel(index);
        },
      ),

    );

  }


  ///item 标题 widget
  Widget _leftInkWel(int index){
    // 是否被点击  用于 一级目录选中高亮
    bool isClick=false;
    isClick=(index==listIndex)?true:false;
    return InkWell(
      onTap: (){
        // 更新下标 修改颜色
        setState(() {
          listIndex=index;
        });
        //
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding:EdgeInsets.only(left:10,top:20),
        decoration: BoxDecoration(
            color: isClick?Colors.red:Colors.white,
            border:Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: Text(list[index].mallCategoryName,
          style: TextStyle(
              fontSize:ScreenUtil().setSp(28),
              color: isClick?Colors.white:Colors.black,
          ),
        ),
      ),
    );
  }


  /// 获取分类信息
  void _getCategory()async{
    await requestPost('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel category= CategoryModel.fromJson(data);
      setState(() {
        list =category.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory( list[0].bxMallSubDto);
    });
  }

}






