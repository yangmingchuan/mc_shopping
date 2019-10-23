import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/provide/cart.dart';
import 'package:mc_shopping/provide/currentIndex.dart';
import 'package:mc_shopping/provide/details_info.dart';
import 'package:provide/provide.dart';

/// 商品详情 底部控件

class DetailsBottom extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    if(Provide.value<DetailsInfoProvide>(context).goodsInfo == null){
      return Container(
        child: Text('暂无数据'),
      );

    }

    var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId= goodsInfo.goodsId;
    var goodsName =goodsInfo.goodsName;
    var count =1;
    var price =goodsInfo.presentPrice;
    var images= goodsInfo.image1;

    return Container(
      width:ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              /// 去购物车按钮
              InkWell(
                onTap: (){
                  /// 设置下标 然后回退 首页重新加载会 默认进入购物车
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
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

              Provide<CartProvide>(
                builder: (context,child,val){
                  int  goodsCount = Provide.value<CartProvide>(context).allGoodsCount;
                  return  Positioned(
                    top:0,
                    right: 10,
                    child: Container(
                      padding:EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                          color:Colors.pink,
                          border:Border.all(width: 2,color: Colors.white),
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Text(
                        '${goodsCount}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(22)
                        ),
                      ),
                    ),
                  ) ;
                },
              )

            ],
          ),
          /// 加入购物车
          InkWell(
            onTap: ()async{
              await Provide.value<CartProvide>(context).save(goodsId,goodsName,count,price,images);
            },
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

          /// 直接购买
          InkWell(
            onTap: ()async{
              await Provide.value<CartProvide>(context).removeAll();
            },
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
