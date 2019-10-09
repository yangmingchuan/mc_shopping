
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mc_shopping/config/httpHeaders.dart';
import 'package:mc_shopping/service/service_method.dart';
import 'package:mc_shopping/weight/AdBanner.dart';
import 'package:mc_shopping/weight/LeaderPhone.dart';
import 'package:mc_shopping/weight/SwiperDiy.dart';
import 'package:mc_shopping/weight/TopNavigator.dart';

/// 首页
/// 宽高适配学习地址 https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('大白商城',style: TextStyle(color: new Color(0xffffffff)),),
        ),
        ///FutureBuilder 是用来等待异步请求的
        body:FutureBuilder(
          future: getHomePageContent(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var data=json.decode(snapshot.data.toString());
              print('总体数据${data['data']}');
              /// 获取轮播图资源
              List<Map> swiperDataList = (data['data']['slides'] as List).cast();
              /// 获取类别列表
              List<Map> navigatorList =(data['data']['category'] as List).cast();
              /// 如果超过10个 就截取下
              if(navigatorList.length>10){
                navigatorList.removeRange(10, navigatorList.length);
              }
              /// 广告图片
              String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
              /// 店长的图片 及 电话信息
              String  leaderImage= data['data']['shopInfo']['leaderImage'];
              //String  leaderPhone = data['data']['shopInfo']['leaderPhone'];
              String  leaderPhone = '18768880074';

              /// ScrollView 同android
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
                    TopNavigator(navigatorList:navigatorList),  //导航组件
                    AdBanner(advertesPicture : advertesPicture),  //广告组件
                    LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  // 拨打电话
                    
                  ],
                ),
              );
            }else{
              return Center(
                child: Text('加载中'),
              );
            }
          },
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

