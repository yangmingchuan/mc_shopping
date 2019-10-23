
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/model/cartInfo.dart';
import 'package:mc_shopping/provide/cart.dart';
import 'package:provide/provide.dart';

/// 购物车 数量变化

class CartCount extends StatelessWidget {
  CartInfoMode item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top:5.0),
      decoration: BoxDecoration(
          border:Border.all(width: 0.4, color:Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),

    );
  }


  /// 减少按钮
  Widget _reduceBtn(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(item,'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count>1?Colors.white:Colors.black12,
            border:Border(
                right:BorderSide(width:0.4,color:Colors.black12)
            )
        ),
        child:item.count>1? Text('-'):Text(' '),
      ),
    );
  }


  /// 增加按钮
  Widget _addBtn(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(item,'add');

      },
      child: Container(
        width: ScreenUtil().setWidth(48),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border:Border(
                left:BorderSide(width:0.4,color:Colors.black12)
            )
        ),
        child: Text('+'),
      ),
    );
  }


  //中间数量显示区域
  Widget _countArea(){
    return Container(
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}
