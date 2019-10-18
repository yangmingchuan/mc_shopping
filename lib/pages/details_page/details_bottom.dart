import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 商品详情 底部控件

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: (){},
            child: Container(
              width: ScreenUtil().setWidth(110) ,
              alignment: Alignment.center,
              child:Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.pink,
              ),
            ) ,
          ),
          InkWell(
            onTap: (){},
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
              ),
            ) ,
          ),
          InkWell(
            onTap: (){},
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
              ),
            ) ,
          ),
        ],
      ),
    );
  }
}
