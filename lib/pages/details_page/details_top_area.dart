
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/provide/details_info.dart';
import 'package:provide/provide.dart';

/// 商品详情界面 头部布局显示  包括商品 图片/ 商品名称/ 商品价格

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Provide Widget 如何数据发生改变 布局也会修改
    return Provide<DetailsInfoProvide>(
      builder: (context,child,value){
        var goodsInfo=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;

        if(goodsInfo != null){
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName ),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('暂时没有数据');
        }
      }
    );
  }

  //商品图片
  Widget _goodsImage(url){
    return  Image.network(
        url,
        width:ScreenUtil().setWidth(740)
    );
  }

  //商品名称
  Widget _goodsName(name){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0,top: 5.0,right: 5.0,bottom: 5.0),
      child: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }


  // 商品编号
  Widget _goodsNum(num){
    return  Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Text(
        '编号:$num',
        style: TextStyle(
            color: Colors.black26
        ),
      ),

    );
  }

  //商品价格方法
  Widget _goodsPrice(presentPrice,oriPrice){
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left:15.0),
      margin: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥$presentPrice',
            style: TextStyle(
              color:Colors.pink,
              fontSize: ScreenUtil().setSp(30),
            ),

          ),
          Text(
            '市场价:￥$oriPrice',
            style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough
            ),

          )
        ],
      ),
    );
  }

}
