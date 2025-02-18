import 'package:flutter/material.dart';
class MyResponsive {
  final double _widthFactor;
  final double _heightFactor;

  MyResponsive(BuildContext context,
      {double designWidth = 1536, double designHeight = 792})
      : _widthFactor = MediaQuery.of(context).size.width / designWidth,
        _heightFactor = MediaQuery.of(context).size.height / designHeight;

  double fontSizeByWidth(double fontSize) => fontSize * _widthFactor;
  double fontSizeByHeight(double fontSize) => fontSize * _heightFactor;
  double width(double value) => value * _widthFactor;
  double height(double value) => value * _heightFactor;
}