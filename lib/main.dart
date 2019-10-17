import 'package:flutter/material.dart';
import 'package:mc_shopping/pages/index_pages.dart';
import 'package:fluro/fluro.dart';
import 'package:mc_shopping/routers/Application.dart';
import 'package:mc_shopping/routers/routes.dart';


/// 首页

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    /// 主界面配置路由
    final router = Router();
    Routes.configureRoutes(router);
    Application.router=router;


    return Container(
      child: MaterialApp(
        title: '大白商城',
        debugShowCheckedModeBanner: false,


        /// 配置 router
        onGenerateRoute: Application.router.generator,

        theme: ThemeData(
          primaryColor: Colors.red
        ),
        home:IndexPages(),
      ),
    );
  }
}

