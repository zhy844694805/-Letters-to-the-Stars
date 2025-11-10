import 'package:flutter/material.dart';
import 'main_navigation.dart';

void main() {
  runApp(const HuiXiangApp());
}

class HuiXiangApp extends StatelessWidget {
  const HuiXiangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '星空寄语',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A1128),
        fontFamily: 'PingFang SC',
      ),
      home: const MainNavigation(),
    );
  }
}
