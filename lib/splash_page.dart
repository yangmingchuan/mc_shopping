
import 'package:flutter/material.dart';
import 'package:mc_shopping/provide/CategoryGoodsListProvide.dart';
import 'package:mc_shopping/provide/ChildCategory.dart';
import 'package:mc_shopping/provide/counter.dart';
import 'package:provide/provide.dart';
import 'SplashScreen.dart';


/// 欢迎界面
void main(){

  /// 实例化 providers 注册状态管理
  var counter = new Counter();
  var childCategory = new ChildCategory();
  var categoryGoodsListProvide = new CategoryGoodsListProvide();
  //Providers()
  //..provide(Provider<Counter>.value(counter));
  ///级联符号 '..'
  ///级联(…)允许您对同一对象执行一系列操作。
  ///除了函数调用，您还可以访问同一对象上的字段。
  ///这通常会省去创建临时变量的步骤，并允许您编写更多的级联代码。

  /// ↑ ↓  上边简写   下边原来的编写模式
  var providers  =Providers();
  providers.provide(Provider<Counter>.value(counter));
  providers.provide(Provider<ChildCategory>.value(childCategory));
  providers.provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide));
  runApp(ProviderNode(child: SplashPage(), providers: providers));
}



class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'YMCFlutter Demo',
        theme: ThemeData(
          primarySwatch:Colors.pink,
        ),
        home:SplashScreen()
    );
  }
}
