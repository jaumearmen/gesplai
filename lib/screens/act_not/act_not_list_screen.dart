import 'package:flutter/material.dart';

class ActNotListScreen extends StatefulWidget {
  const ActNotListScreen({Key? key}) : super(key: key);

  @override
  State<ActNotListScreen> createState() => _ActNotListScreenState();
}

class _ActNotListScreenState extends State<ActNotListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('ATC_NOT'),
      ),
    );
  }
}
