import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 顶部 表格导航栏
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  /// 构造方法 key我真的很费解
  TopNavigator({Key key ,this.navigatorList}) : super(key: key);

  /// 将每个 item 抽取出来
  Widget _gridViewItemUI(BuildContext context,item){
    ///InkWell: 点击水波纹效果
    return InkWell(
      onTap: (){
        print('点击了itme');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width:ScreenUtil().setWidth(90)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(250),
      padding:EdgeInsets.all(3.0),
      /// gridview 一行5个，遍历设置 item
      child: GridView.count(crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        // GridView 禁止滑动
        physics: NeverScrollableScrollPhysics(),
        children: navigatorList.map((f){
          return _gridViewItemUI(context,f);
        }).toList(),
      ),
    );
  }
}