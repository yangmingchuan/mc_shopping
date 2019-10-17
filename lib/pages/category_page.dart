
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mc_shopping/model/CategoryGoodsList.dart';
import 'package:mc_shopping/model/CategoryModel.dart';
import 'package:mc_shopping/provide/CategoryGoodsListProvide.dart';
import 'package:mc_shopping/provide/ChildCategory.dart';
import 'package:mc_shopping/service/service_method.dart';
import 'package:mc_shopping/weight/RightCategoryNav.dart';
import 'package:provide/provide.dart';

///分类界面

class CategoryPage extends StatefulWidget {

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList()
              ],
            )
          ],
        ),
      ),
    );
  }

}


///-------------   左侧 一级分类列表   ---------------
///
///
class LeftCategoryNav extends StatefulWidget {

  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  /// 一级分类 数据集合
  List list = [];

  var listIndex = 0; //索引

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context,child,val){
        ///加载一级列表的同时 开始加载二级列表数据
        _getGoodList(context);

        return Container(
          width: ScreenUtil().setWidth(170),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(width: 0.2,color:Colors.black12)
              )
          ),
          child: ListView.builder(
            itemCount:list.length,
            itemBuilder: (context,index){
              return _leftInkWel(index);
            },
          ),

        );
      },
    );

  }


  ///item 标题 widget
  Widget _leftInkWel(int index){
    // 是否被点击  用于 一级目录选中高亮
    bool isClick=false;
    isClick=(index==listIndex)?true:false;

    return InkWell(
      /// 左侧一类分类 点击事件
      onTap: (){
        // 更新下标 修改颜色
        setState(() {
          listIndex=index;
        });
        var childList = list[index].bxMallSubDto;
        /// 默认第一个都是全全部，所以可以获取 大类的 id 进行所有商品的查询
        var categoryId= list[index].mallCategoryId;
        Provide.value<ChildCategory>(context).changeCategory(categoryId,index);
        Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
        _getGoodList(context,categoryId:categoryId);
      },

      child: Container(
        height: ScreenUtil().setHeight(100),
        padding:EdgeInsets.only(left:10,top:20),
        decoration: BoxDecoration(
            color: isClick?Colors.red:Colors.white,
            border:Border(
                bottom:BorderSide(width: 1,color:Colors.black12)
            )
        ),
        child: Text(list[index].mallCategoryName,
          style: TextStyle(
              fontSize:ScreenUtil().setSp(28),
              color: isClick?Colors.white:Colors.black,
          ),
        ),
      ),
    );
  }


  /// 获取左侧 一级分类信息
  void _getCategory()async{
    await requestPost('getCategory').then((val){
      var data = json.decode(val.toString());
      CategoryModel category= CategoryModel.fromJson(data);
      setState(() {
        list =category.data;
      });
      /// 默认查询 id=4 数据
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto,'4');
    });
  }


  /// 得到二级分类商品列表数据
  ///
  void _getGoodList(context,{String categoryId }) {
    var data={
      'categoryId':categoryId==null?Provide.value<ChildCategory>(context).categoryId:categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).subId,
      'page':1
    };

    requestPost('getMallGoods',formData:data ).then((val){
      var  data = json.decode(val.toString());
      CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
      // Provide.value<CategoryGoodsList>(context).getGoodsList(goodsList.data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }

}



/// ------------    右侧底部商品列表，可以上拉加载    --------------
///
///
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}
class _CategoryGoodsListState extends State<CategoryGoodsList> {

  var scrollController=new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){
        try{
          if(Provide.value<ChildCategory>(context).page==1){
            scrollController.jumpTo(0.0);
          }
        }catch(e){
          print('进入页面第一次初始化：$e');
        }

        if(data.goodsList.length>0){
          return Expanded(
            child:Container(
                width: ScreenUtil().setWidth(570) ,
                child:EasyRefresh(
                  footer: MaterialFooter(
                    backgroundColor: Colors.white,
                  ),
                  child:ListView.builder(
                    controller: scrollController,
                    itemCount: data.goodsList.length,
                    itemBuilder: (context,index){
                      return _ListWidget(data.goodsList,index);
                    },
                  ) ,
                  onLoad: ()async{
                    if(Provide.value<ChildCategory>(context).noMoreText=='没有更多了'){
                      Fluttertoast.showToast(
                          msg: "已经到底了",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black12,
                          fontSize: 16.0
                      );
                    }else{

                      _getMoreList();
                    }

                  },
                )

            ) ,
          );
        }else{
          return  Text('暂时没有数据');
        }


      },

    );
  }

  //上拉加载更多的方法
  void _getMoreList(){

    Provide.value<ChildCategory>(context).addPage();
    var data={
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).subId,
      'page':Provide.value<ChildCategory>(context).page
    };

    requestPost('getMallGoods',formData:data ).then((val){
      var  data = json.decode(val.toString());
      CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);

      if(goodsList.data==null){
        Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
      }else{
        Provide.value<CategoryGoodsListProvide>(context).addGoodsList(goodsList.data);

      }
    });


  }

  /// 分类 详细商品信息 列表item
  ///
  Widget _ListWidget(List newList,int index){
    return InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.only(top: 5.0,bottom: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1.0,color: Colors.black12)
              )
          ),

          child: Row(
            children: <Widget>[
              _goodsImage(newList,index)
              ,
              Column(
                children: <Widget>[
                  _goodsName(newList,index),
                  _goodsPrice(newList,index)
                ],
              )
            ],
          ),
        )
    );
  }

  /// 分类商品 内部
  Widget _goodsImage(List newList,index){

    return  Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );

  }

  /// 商品名称
  Widget _goodsName(List newList,index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  /// 商品价格
  Widget _goodsPrice(List newList,index){
    return Container(
      margin: EdgeInsets.only(top:20.0),
      width: ScreenUtil().setWidth(350),
        child:Row(
            children: <Widget>[
              Text(
                '价格:￥${newList[index].presentPrice}',
                style: TextStyle(color:Colors.pink,fontSize:ScreenUtil().setSp(30)),
              ),
              Text(
                '￥${newList[index].oriPrice}',
                style: TextStyle(
                    color: Colors.black26,
                    decoration: TextDecoration.lineThrough
                ),
              )
            ]
        )
    );
  }




}







