
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/routers/Application.dart';

///楼层 内容
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key,this.floorGoodsList}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context),

        ],
      ),
    );
  }


  /// 第一行 商品
  Widget _firstRow(BuildContext context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context,floorGoodsList[1]),
            _goodsItem(context,floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  /// 第二行商品
  Widget _otherGoods(BuildContext context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[3]),
        _goodsItem(context,floorGoodsList[4]),
      ],
    );
  }

  /// 商品item
  Widget _goodsItem(BuildContext context,Map goods){

    return Container(
      width:ScreenUtil().setWidth(375),
      child: InkWell(
        onTap:(){
           Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }

}


///楼层图片 本质：网络图片加载
class FloorTitle extends StatelessWidget {
  final String picture_address; // 图片地址
  FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}