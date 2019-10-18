
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/provide/details_info.dart';
import 'package:provide/provide.dart';

/// 自定义 tab
///
class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 如果 Provide 中的数据变动 会自动修改,有点绑定的意思了
    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        var isRight = Provide.value<DetailsInfoProvide>(context).isRight;
        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _myTabBarLeft(context,isLeft),
                  _myTabBarRight(context,isRight)
                ],
              ),
            ],
          ),

        ) ;
      },
    );
  }


  /// 左侧的 Tab Bar
  Widget _myTabBarLeft(BuildContext context,bool isLeft){
    return InkWell(
      onTap: (){

        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('left');
      },
      child: Container(

        padding:EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: isLeft?Colors.pink:Colors.black12
                )
            )
        ),
        child: Text(
          '详细',
          style: TextStyle(
              color:isLeft?Colors.pink:Colors.black
          ),
        ),
      ),
    );
  }


  /// 右侧的 Tab Bar
  Widget _myTabBarRight(BuildContext context,bool isRight){
    return InkWell(
      onTap: (){

        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('right');
      },
      child: Container(

        padding:EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: isRight?Colors.pink:Colors.black12
                )
            )
        ),
        child: Text(
          '评论',
          style: TextStyle(
              color:isRight?Colors.pink:Colors.black
          ),
        ),
      ),
    );
  }
}
