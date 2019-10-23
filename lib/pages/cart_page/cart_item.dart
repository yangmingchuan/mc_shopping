
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/model/cartInfo.dart';
import 'package:mc_shopping/provide/cart.dart';
import 'package:provide/provide.dart';

import 'cart_count.dart';

///
/// 购物车 list item 布局
///

class CartItem extends StatelessWidget {
  final CartInfoMode item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width:0.6,color:Colors.black12)
          )
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context,item),
          _cartImage(item),
          _cartGoodsName(item),
          _cartPrice(context,item)
        ],
      ),
    );
  }

  /// 选择按钮
  Widget _cartCheckBt(context,item){
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor:Colors.pink,
        onChanged: (bool val){
          // 更改状态 同步Provide
          item.isCheck=val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
      ),
    );
  }

  /// 商品图片
  Widget _cartImage(item){

    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5,color:Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }


  /// 商品名称
  Widget _cartGoodsName(item){
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(5),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          CartCount(item)
        ],
      ),
    );
  }

  /// 商品价格
  Widget _cartPrice(context,item){
    return Container(
      width:ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Text('￥${item.price}',style: TextStyle(color: Colors.pink,fontSize: 20),),
          Container(
            child: InkWell(
              // 调用 Provide 中删除操作
              onTap: (){
                Provide.value<CartProvide>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(

                Icons.delete_forever,
                color: Colors.black38,
                size: 25,
              ),
            ),
          )
        ],
      ),
    );
  }

}
