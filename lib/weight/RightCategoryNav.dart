import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/model/CategoryModel.dart';
import 'package:mc_shopping/provide/ChildCategory.dart';
import 'package:provide/provide.dart';

///分类右侧 列表
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
            height: ScreenUtil().setHeight(80),
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
                  return _rightInkWell(childCategory.childCategoryList[index]);
                }
            ),);

        },
      ),

    );
  }


  /// 右侧 title 文字
  Widget _rightInkWell(BxMallSubDto item){

    return InkWell(
      onTap: (){},
      child: Container(
        padding:EdgeInsets.fromLTRB(15.0,15.0,15.0,15.0),

        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize:ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}
