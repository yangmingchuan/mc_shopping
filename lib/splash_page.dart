
import 'package:flutter/material.dart';

import 'SplashScreen.dart';

/// 欢迎界面
void main() => runApp(SplashPage());

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'YMCFlutter Demo',
        theme: ThemeData(
          primarySwatch:Colors.blue,
        ),
        home:SplashScreen()
    );
  }
}
