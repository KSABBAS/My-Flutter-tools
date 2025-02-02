import 'package:flutter/material.dart';

List<Widget> WidgetListBuilder ({required int itemCount ,required Widget Function(int index) builder ,void Function(List<Widget> finalList)? finalList}) {
  List<Widget> list = [];
  for (int i = 0; i < itemCount; i++) {
    list.add(builder(i));
  }
  if (finalList != null) {
    finalList(list);
  }
  return list;
}
