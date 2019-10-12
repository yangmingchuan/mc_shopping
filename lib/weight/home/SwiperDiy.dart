import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/// 轮播组件
///
class SwiperDiy extends StatelessWidget {
  ///轮播图 图片数据地址
  final List swiperDataList;
  SwiperDiy({Key key,this.swiperDataList}):super(key:key);

  @override
  Widget build(BuildContext context) {

//    print('屏幕像素密度：${ScreenUtil.pixelRatio}');
//    print('屏幕像素密度：${ScreenUtil.screenWidth}');
//    print('屏幕像素密度：${ScreenUtil.screenHeight}');
    return Container(
      height: ScreenUtil.getInstance().setHeight(250),
      /// 使用第三方轮播图
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return new Image.network("${swiperDataList[index]['image']}",
              fit:BoxFit.fill);
        },
        itemCount: swiperDataList.length,
        ///自动播放 默认下标点
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}