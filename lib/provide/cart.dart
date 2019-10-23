import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mc_shopping/model/cartInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// 购物车 Provide
///

class CartProvide with ChangeNotifier{
  String cartString="[]";
  /// 将购物车信息保存到 该 对象中
  List<CartInfoMode> cartList=[];

  double allPrice =0 ;   //总价格
  int allGoodsCount =0;  //商品总数量

  bool isAllCheck= true; //是否全选

  /// 通过 sp 保存商品的详细信息  但是sharedPreferences不持支对象的持久化。
  save(goodsId,goodsName,count,price,images) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    cartString = sp.getString('cartInfo');
    /// 获取sp key 的字符串，如果为空则进行 赋值
    var temp=cartString==null?[]:json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList= (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave= false;  //默认为没有

    int ival=0; //用于进行循环的索引使用

    allPrice=0;
    allGoodsCount=0;  //把商品总数量设置为0

    /// 循环判断是否存在 已有物品则 将商品 数量+1
    /// 如果 不存在 则将参数 已对象方式添加 进去
    tempList.forEach((item){
      //如果存在，数量进行+1操作
      if(item['goodsId']==goodsId){
        tempList[ival]['count']=item['count']+1;
        //关键代码-----------------start
        cartList[ival].count++;
        isHave=true;
      }

      /// 保存 如果有判断 是否选中 添加价格
      if(item['isCheck']){
        allPrice+= (cartList[ival].price* cartList[ival].count);
        allGoodsCount+= cartList[ival].count;
      }

      ival++;
    });

    //  如果没有，进行增加
    if(!isHave){
      Map<String, dynamic> newGoods={
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images,
        'isCheck': true  //是否已经选择
      };
      tempList.add(newGoods);
      cartList.add(new CartInfoMode.fromJson(newGoods));
      /// 设置价格
      allPrice+= (count * price);
      allGoodsCount+=count;
    }
    //把字符串进行encode操作，
    cartString= json.encode(tempList).toString();
    print(cartString);
    sp.setString('cartInfo', cartString);//进行持久化
    notifyListeners();
  }

  /// 获取购物车中的商品
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    cartString=prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    cartList=[];
    //判断得到的字符串是否有值，如果不判断会报错
    if(cartString==null){
      cartList=[];
    }else{
      List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
      allPrice=0;
      allGoodsCount=0;
      isAllCheck=true;
      tempList.forEach((item){
        // 循环计算价格
        if(item['isCheck']){
          allPrice+=(item['count']*item['price']);
          allGoodsCount+=item['count'];
        }else{
          isAllCheck=false;
        }
        cartList.add(new CartInfoMode.fromJson(item));
      });
    }
    notifyListeners();
  }


  /// 根绝 商品id 删除某一个商品
  /// 根据 商品id 比较删除 更新sp
  deleteOneGoods(String goodsId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    // 部分标志位
    int tempIndex =0;
    int delIndex=0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId){
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString= json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  ///清空 sp 的购物车信息
  removeAll() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    print('清空完成-----------------');
    notifyListeners();
  }


  /// 改变单个商品选中状态
  changeCheckState(CartInfoMode cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList =  (json.decode(cartString.toString()) as List).cast();

    int tempIndex =0;  //循环使用索引
    int changeIndex=0; //需要修改的索引

    tempList.forEach((item){
      if(item['goodsId']==cartItem.goodsId){
        //找到索引进行复制
        changeIndex=tempIndex;
      }
      tempIndex++;
    });
    // 替换内容
    tempList[changeIndex]=cartItem.toJson();
    cartString= json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);//进行持久化
    await getCartInfo();  //重新读取列表
  }

  /// 全选 按钮操作
  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    //新建一个List，用于组成新的持久化数据。
    List<Map> newList=[];
    for(var item in tempList ){
      var newItem = item; //复制新的变量，因为Dart不让循环时修改原值
      newItem['isCheck']=isCheck; //改变选中状态
      newList.add(newItem);
    }
    //sp 更新
    cartString= json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  /// 商品添加
  ///
  /// cartItem:修改的项   todo：是加 还是减
  addOrReduceAction(CartInfoMode cartItem, String todo )async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo');
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

    //循环使用
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId']==cartItem.goodsId){
        changeIndex=tempIndex;
      }
      tempIndex++;
    });

    if(todo=='add'){
      cartItem.count++;
    }else if(cartItem.count>1){
      cartItem.count--;
    }

    tempList[changeIndex]=cartItem.toJson();
    cartString= json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();

  }

}