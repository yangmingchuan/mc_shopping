import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///商品推荐界面
class Recommend extends StatelessWidget {
  final List  recommendList;


  Recommend({Key key,this.recommendList}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(330),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _getTitleWidget(),
          _recommedHorList()
        ],
      ),
    );
  }



  ///设置推荐GridView item  （复用抽离）
  Widget _recommendItem(index){
    return InkWell(
      onTap: (){
        print('点击 推荐 item');
      },
      child: Container(
        height: ScreenUtil().setHeight(250),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        /// 设置 左右间隔分割线
        decoration:BoxDecoration(
            color:Colors.white,
            border:Border(
                left: BorderSide(width:0.2,color:Colors.black12)
            )
        ),

        child: Column(
            children: <Widget>[
              Image.network(recommendList[index]['image']),
              Text('￥${recommendList[index]['mallPrice']}'),
              Text(
                '￥${recommendList[index]['price']}',
                style: TextStyle(
                    // 中划线
                    decoration: TextDecoration.lineThrough,
                    color:Colors.grey
                ),
              )
            ]
        ),
      ),
    );
  }


  /// 横向列表
  Widget _recommedHorList(){
    return Container(
      height: ScreenUtil().setHeight(260),
      /// 设置列表创建者
      child: ListView.builder(
        itemBuilder: (context, index){
            return _recommendItem(index);
        },
        itemCount: recommendList.length,
        scrollDirection: Axis.horizontal ,

      ),
    );
  }

}

///公用标题  （可复用抽离）
Widget _getTitleWidget(){
  return Container(
    /// 布局内 对齐方式
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.fromLTRB(20.0, 5.0, 0,5.0),
    /// 盒子装饰
    decoration: BoxDecoration(
        color:Colors.white,
        /// 边界设置
        border: Border(
            bottom: BorderSide(width:0.2,color:Colors.black12)
        )
    ),
    child: Text('推荐商品',
      style: TextStyle(color: Colors.pink,fontSize: 16),),
  );
}

