import "package:dio/dio.dart";
import 'dart:async';
import 'package:mc_shopping/config/service_url.dart';

/// 网络请求工具类

/// 公用 post dio请求方法
Future requestPost(url,{formData})async{
  try{
    Response response;
    Dio dio = new Dio();
    dio.options.contentType="application/x-www-form-urlencoded";
    if(formData==null){
      response = await dio.post(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url],data:formData);
    }
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>$e');
  }

}

/// 获取首页信息
Future getHomePageContent() async{

  try{
    print('开始获取首页数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType= "application/x-www-form-urlencoded";
    var formData = {'lon':'115.02932','lat':'35.76189'};
    response = await dio.post(servicePath['homePageContext'],data:formData);
    if(response.statusCode==200){
      print('首页轮播信息：${response.data}');
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>$e');
  }

}


/// 获得火爆专区商品的方法
Future getHomePageBeloConten() async{

  try{
    print('开始获取下拉商品信息........');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType= "application/x-www-form-urlencoded";
    int page = 1;
    response = await dio.post(servicePath['homePageBelowConten'],data:page);
    if(response.statusCode==200){
      return response.data;
    }else{
      throw Exception('错误码：${response.statusCode} .后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch (e){
    return print('下拉获取商品ERROR:======>$e');
  }

}