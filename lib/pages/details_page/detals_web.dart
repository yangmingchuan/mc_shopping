import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mc_shopping/provide/details_info.dart';
import 'package:provide/provide.dart';

/// 商品详情界面 （web 界面嵌入）

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provide<DetailsInfoProvide>(
      builder: (context,child,val){
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        /// 商品信息 放在Provide 内部如果对象变化则会同步变化更新
        var goodsDetail=Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
        /// 如果是左侧 显示网页 商品详情web
        if(isLeft && goodsDetail!= null){
          return  Container(
            child: Html(
                data:goodsDetail
            ),
          );
        }else{
          return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child:Text('暂时没有数据')
          );
        }
      },
    );
  }
}
