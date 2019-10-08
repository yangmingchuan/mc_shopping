import 'package:flutter/material.dart';
import 'package:mc_shopping/pages/index_pages.dart';

/// 首页

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '大白商城',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.lightBlue
        ),
        home:IndexPages(),
      ),
    );
  }
}

