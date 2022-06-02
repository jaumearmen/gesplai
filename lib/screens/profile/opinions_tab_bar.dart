import 'package:flutter/material.dart';

class OpinionsTabBar extends StatefulWidget {
  const OpinionsTabBar({Key? key}) : super(key: key);

  @override
  State<OpinionsTabBar> createState() => _OpinionsTabBarState();
}

class _OpinionsTabBarState extends State<OpinionsTabBar> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('OPINIONS')),
    );
  }
}
