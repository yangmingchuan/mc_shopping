import 'package:flutter/material.dart';

import 'main.dart';

/// 欢迎界面

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

///因为初始化animationController的时候需要一个TickerProvider类型的参数Vsync参数，
///所以我们混入了TickerProvider的子类SingleTickerProviderStateMixin
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  /// 动画管理器  /  图片资源路径
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync:this,duration:Duration(milliseconds:2000));
    animation = Tween(begin: 0.0,end:1.0).animate(controller);
    /// 检测动画结束，就跳转到首页
    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context)=>MyApp()),
                (route)=> route==null);
      }
    });
    /// 开始动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animation,
        child: Image.network(  //网络图片
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec='
              '1546851657199&di=fdd278c2029f7826790191d59279dbbe&imgtype=0&src='
              'http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0112cb554438090000019ae93094f1.jpg'
              '%401280w_1l_2o_100sh.jpg',
          scale: 2.0,  //进行缩放
          fit:BoxFit.cover  // 充满父容器
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }

}
