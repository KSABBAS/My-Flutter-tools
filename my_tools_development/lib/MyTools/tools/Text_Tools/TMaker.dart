import 'package:flutter/material.dart';
class TMaker extends StatelessWidget {
  TMaker(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.textAlign,
      this.fontFamily,
      this.maxLines,
      this.overflow,
      this.textDirection});
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  int? maxLines;
  TextOverflow? overflow;
  TextAlign? textAlign;
  TextDirection? textDirection;
  String? fontFamily;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: overflow ?? TextOverflow.ellipsis,
      textDirection: textDirection ?? TextDirection.rtl,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color),
    );
  }
}