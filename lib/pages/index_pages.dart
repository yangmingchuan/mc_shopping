import 'package:flutter/material.dart';
/// ios 风格
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cart_page.dart';
import 'category_page.dart';
import 'home_page.dart';
import 'member_page.dart';

/// 首页
///Dart中的可选参数，直接使用“{}”(大括号)就可以了。
///可选参数在调用的时候必须使用 paramName:value 的形式。

class IndexPages extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<IndexPages> {
  /// 底部 bar 列表
  final List<BottomNavigationBarItem> bottomBars = [
    BottomNavigationBarItem(
      title: Text('首页'),
      icon: Icon(CupertinoIcons.home)
    ),
    BottomNavigationBarItem(
        title: Text('分类'),
        icon: Icon(CupertinoIcons.search)
    ),
    BottomNavigationBarItem(
        title: Text('购物车'),
        icon: Icon(CupertinoIcons.shopping_cart)
    ),
    BottomNavigationBarItem(
        title: Text('我的'),
        icon: Icon(CupertinoIcons.profile_circled)
    )
  ];

  /// 各个界面 集合
  final List<Widget> tabBodies = [
    HomePage(),CategoryPage(),CartPage(),MemberPage()
  ];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///初始化 宽高适配工具
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1280)..init(context);
    //print('屏幕高度${ScreenUtil().scaleHeight}');
    //print('屏幕宽度${ScreenUtil().scaleWidth}');

    return Scaffold(
      backgroundColor: Color.fromARGB(1, 244, 244, 244),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomBars,
        onTap: (index){
          /// 改变状态
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        },
      ),
        /// 为了可以保存状态 需要嵌套一个 IndexedStack （堆栈需要 传入tab列表和下标）
        body: IndexedStack(
            index: currentIndex,
            /// 列表需要的对象是 list<Widget> 需要及时更正对象类型是否正确
            children: tabBodies
        )
    );
  }
}
