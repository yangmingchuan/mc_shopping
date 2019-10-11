
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:mc_shopping/config/httpHeaders.dart';
import 'package:mc_shopping/service/service_method.dart';
import 'package:mc_shopping/weight/AdBanner.dart';
import 'package:mc_shopping/weight/FloorContent.dart';
import 'package:mc_shopping/weight/LeaderPhone.dart';
import 'package:mc_shopping/weight/Recommend.dart';
import 'package:mc_shopping/weight/SwiperDiy.dart';
import 'package:mc_shopping/weight/TopNavigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// 首页
/// 宽高适配学习地址 https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();

}

/// 关于AutomaticKeepAliveClientMixin ：
/// 1.使用的页面必须是StatefulWidget,如果是StatelessWidget是没办法办法使用的。
/// 2.其实只有两个前置组件才能保持页面状态：PageView和IndexedStack。
/// 3.重写wantKeepAlive方法，如果不重写也是实现不了的。
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  //热门商品 集合
  int page = 1;
  List<Map> hotGoodsList=[];

  // 默认就加载 第一页的热门商品信息
  @override
  void initState() {
    _getHotGoods();
    super.initState();
  }

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
              List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐
              String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
              String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层2的标题图片
              String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层3的标题图片
              List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片
              List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层2商品和图片
              List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层3商品和图片


            /// ScrollView 同android  => 改为 EasyRefresh ，可提供上拉加载更多
              return EasyRefresh(
                footer: MaterialFooter(
                  backgroundColor: Colors.white,

                ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDataList:swiperDataList ),   //页面顶部轮播组件
                    TopNavigator(navigatorList:navigatorList),  //导航组件
                    AdBanner(advertesPicture : advertesPicture),  //广告组件
                    LeaderPhone(leaderImage:leaderImage,leaderPhone: leaderPhone),  // 拨打电话

                    Recommend(recommendList:recommendList),// 推荐列表

                    /// 添加楼层信息
                    FloorTitle(picture_address:floor1Title),
                    FloorContent(floorGoodsList:floor1),
                    FloorTitle(picture_address:floor2Title),
                    FloorContent(floorGoodsList:floor2),
                    FloorTitle(picture_address:floor3Title),
                    FloorContent(floorGoodsList:floor3),
                    /// 热门商品 列表部分
                    hotTitle,
                    _hotWrapList(),
                  ],
                ),
                onLoad: () async {
                  print('上拉记载更多：pageindex：$page');
                  _getHotGoods();
                },

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

  /// 设置为 true 才可以保存状态
  @override
  bool get wantKeepAlive => true;


  ///获取热门商品
  void _getHotGoods(){
    var formPage={'page': page};
    requestPost('homePageBelowConten',formData: formPage).then((onValue){
      // 获取数据 分析
      var data=json.decode(onValue.toString());
      print('上拉加载 page $page 热门商品内容：data：$data');
      List<Map> newGoodsList = (data['data'] as List ).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }



  ///这是 热门标题 （当然也可以写成 方法返回）
  Widget hotTitle = new Container(
    margin:EdgeInsets.only(top: 10.0),
    padding:EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
          bottom : BorderSide(color: Colors.black12,width: 0.2),
      ),
    ),
    child: Text('火爆商品',style: TextStyle(color: Colors.pink,fontSize: 16),),
  );

  /// 热门列表 使用流式布局替换 GridView （GridView听说性能不好）
  Widget _hotWrapList (){
    if(hotGoodsList.length!=0){
      //迭代数组 构建List<Widget> 数据
      List<Widget> listWidget = hotGoodsList.map((f){
        return InkWell(
          onTap: (){
            print('点击热销 商品');
          },
          child: Container(
            // 这里 我设置的 屏幕 750，所以设置一般的 距离
            width: ScreenUtil().setWidth(372),
            color:Colors.white,
            child: Column(
              children: <Widget>[
                Image.network(f['image'],width: ScreenUtil().setWidth(372),),
                Text(
                  f['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(16)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${f['mallPrice']}'),
                    Text('￥${f['price']}',
                      style: TextStyle(color: Colors.grey,
                          //添加 中划线
                          decoration:TextDecoration.lineThrough ),)
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      /// 返回流式布局
      return Wrap(
        spacing: 2,
        children: listWidget,
      );

    }else{

      return Text('暂无热门数据');
    }
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

