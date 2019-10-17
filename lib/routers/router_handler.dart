
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mc_shopping/pages/details_page.dart';

///路由工具类


/// 跳转到详情的 路由 Handler
Handler detailsHandler =Handler(
    handlerFunc: (BuildContext context,Map<String,List<String>> params){
      String goodsId = params['id'].first;
      print('index>details goodsID is $goodsId');
      return DetailsPage(goodsId);
    }
);