import 'package:flutter/material.dart';
List<Widget>? WidgetListMaker(int number, Widget widget) {
  List<Widget>? list = [];
  for (int i = 0; i < number; i++) {
    list.add(widget);
  }
  return list;
}