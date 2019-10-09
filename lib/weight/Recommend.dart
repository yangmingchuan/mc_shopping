import 'package:flutter/material.dart';

///商品推荐界面
class Recommend extends StatelessWidget {
  final List  recommendList;


  Recommend({Key key,this.recommendList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}

///公用标题
Widget _getTitleWidget(){
  return Container(
    /// 布局内 对齐方式
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.fromLTRB(10.0, 5.0, 0,5.0),
    /// 盒子装饰
    decoration: BoxDecoration(
        color:Colors.white,
        /// 边界设置
        border: Border(
            bottom: BorderSide(width:0.2,color:Colors.black12)
        )
    ),
    child: Text('推荐商品',
      style: TextStyle(color: Colors.pink),),
  );
}


