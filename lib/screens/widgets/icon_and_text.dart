import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final String text;
  final IconData icon;
  const IconAndText({Key? key, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(text),
        ),
      ],
    );
  }
}
