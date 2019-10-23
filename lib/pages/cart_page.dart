
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mc_shopping/provide/cart.dart';
import 'package:provide/provide.dart';

import 'cart_page/cart_bottom.dart';
import 'cart_page/cart_item.dart';

///
/// 购物车界面
///

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        /// FutureBuilder 主要是 设置网络请求 完成后的布局
        body:FutureBuilder(
            future:_getCartInfo(context),
            builder: (context, snapshot){
              List cartList = Provide.value<CartProvide>(context).cartList;
              if(snapshot.hasData && cartList!=null){
                return Stack(
                  /// 如果 Provide 发生变化 实时更新则需要 Provide 组件
                  children: <Widget>[
                    Provide<CartProvide>(
                      builder: (context,child,childCategory){
                        cartList= Provide.value<CartProvide>(context).cartList;
                        return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (context,index){
                            return CartItem(cartList[index]);
                          },
                        );
                      },
                    ),


                    /// 底部的购物车 信息按钮
                    Positioned(
                      bottom:0,
                      left:0,
                      child: CartBottom(),
                    )
                  ],
                );
              }else{
                return Text('正在加载');
              }
            }
        )
    );
  }

  /// 获取购物车信息
  Future<String> _getCartInfo(BuildContext context) async{
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }

}




