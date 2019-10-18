import 'package:flutter/material.dart';
import 'package:mc_shopping/provide/details_info.dart';
import 'package:provide/provide.dart';

import 'details_page/details_bottom.dart';
import 'details_page/details_explain.dart';
import 'details_page/details_tabbar.dart';
import 'details_page/details_top_area.dart';
import 'details_page/detals_web.dart';



/// 商品详情界面
class DetailsPage extends StatelessWidget {
  // 商品 id
  final String goodsId;
  ///新版的Flutter已经不在要求key值，所以没必要再写了
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(Icons.arrow_back),
          onPressed: (){
            print('返回上一页');
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
    body:FutureBuilder(
      future: _getBackInfo(context),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return Container(
            /// 使用 row会出现 右侧 像素越界。
            /// 改为 stack + ListView
              child:Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      //DetailsExplain(),
                      DetailsTabbar(),
                      DetailsWeb(),

                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: DetailsBottom()
                  )
                ],
              )
          );
        }else{
          return Text('加载中........');
        }
      }
    )

    );
  }

  /// 获取 商品详情
  Future _getBackInfo(BuildContext context)async{
    Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
