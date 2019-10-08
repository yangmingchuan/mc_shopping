
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mc_shopping/config/httpHeaders.dart';
import 'package:mc_shopping/service/service_method.dart';

/// 首页

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  String homePageContent='正在获取数据';
  @override
  void initState() {
    getHomePageContent().then((val){
      setState(() {
        homePageContent=val.toString();
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body:SingleChildScrollView(
          child:  Text(homePageContent) ,
        )


    );
  }
}


  /// getHttp().then((val){}) 调用
  /// Future，可以将任务加入到Event Queue的队尾
  Future getHttp() async {
    try{
      Response response;
      ///同步获取数据
      Dio dio = new Dio();
      dio.options.headers= httpHeaders;
      response = await dio.get(
        "https://time.geekbang.org/serv/v1/column/newAll",
      );
      return response.data;
    }catch(e){
      return e.toString();
    }

  }

