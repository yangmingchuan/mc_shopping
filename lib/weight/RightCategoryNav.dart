import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/model/CategoryGoodsList.dart';
import 'package:mc_shopping/model/CategoryModel.dart';
import 'package:mc_shopping/provide/CategoryGoodsListProvide.dart';
import 'package:mc_shopping/provide/ChildCategory.dart';
import 'package:provide/provide.dart';
import 'package:mc_shopping/service/service_method.dart';

/// ---------    分类右侧 列表   ---------
///
///
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {

  @override
  Widget build(BuildContext context) {
    return Container(
      /// 如果要使用状态管理 需要包裹 UI Provide<ChildCategory>
      child: Provide<ChildCategory>(
        builder: (context,child,childCategory){
          return Container(
            height: ScreenUtil().setHeight(90),
            width: ScreenUtil().setWidth(570),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 0.2,color: Colors.black12)
                )
            ),
            child: ListView.builder(
                itemCount: childCategory.childCategoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                  return _rightInkWell(index,childCategory.childCategoryList[index]);
                }
            ),);
        },
      ),

    );
  }


  /// 右侧 title 文字
  Widget _rightInkWell(int index,BxMallSubDto item){
    bool isCheck = false;
    isCheck =(index==Provide.value<ChildCategory>(context).childIndex)?true:false;

    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildIndex(index,item.mallSubId);
        _getGoodList(context,item.mallSubId);
      },
      child: Container(
        padding:EdgeInsets.fromLTRB(15.0,15.0,15.0,15.0),

        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize:ScreenUtil().setSp(28),
              color:isCheck?Colors.pink:Colors.black ),
        ),
      ),
    );
  }


  /// 得到二级商品列表数据
  void _getGoodList(context,String categorySubId) {

    var data={
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };

    requestPost('getMallGoods',formData:data ).then((val){
      var  data = json.decode(val.toString());
      CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
      /// 同步数据
      if(goodsList.data==null){
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      }else{
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);

      }
    });
  }
}
