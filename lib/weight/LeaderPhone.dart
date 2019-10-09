
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 点击拨打电话界面

class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; //店长电话

  LeaderPhone({Key key, this.leaderImage,this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){_launchURL();},
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:'+leaderPhone;
    print('店长电话：${leaderPhone}');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
