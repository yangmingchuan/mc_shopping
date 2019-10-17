import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mc_shopping/routers/router_handler.dart';

/// 路由配置文件

class Routes{
  static String root='/';
  static String detailsPage = '/detail';

  static void configureRoutes(Router router){
    router.notFoundHandler= new Handler(
        handlerFunc: (BuildContext context,Map<String,List<String>> params){
          print('ERROR====>没有发现有可用的路由配置 !!!');
        }
    );

    /// 配置 商品详情界面路由
    router.define(detailsPage,handler:detailsHandler);
  }

}
