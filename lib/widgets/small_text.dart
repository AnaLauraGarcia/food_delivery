import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {

  Color? color;
  final String text;
  double size;
  double height;

  SmallText({Key? key, this.color = const Color(0xFFa6a6a6), 
    required this.text,
    this.size=18,
    this.height=1.2
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        height: height

      )
    );
  }
}