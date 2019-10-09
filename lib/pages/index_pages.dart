import 'package:flutter/material.dart';
/// ios 风格
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cart_page.dart';
import 'category_page.dart';
import 'home_page.dart';
import 'member_page.dart';

/// 首页

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
  final List tabBodies = [
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
      body: currentPage,
    );
  }
}
