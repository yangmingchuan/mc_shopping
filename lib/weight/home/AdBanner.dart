
import 'package:flutter/material.dart';

///广告栏
/// 其实就是一个图片
class AdBanner extends StatelessWidget {
  final String advertesPicture;

  AdBanner({Key key,this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: InkWell(
        onTap: (){
          print('点击了广告栏');
        },
        child: Image.network(advertesPicture),
      )
    );
  }
}
