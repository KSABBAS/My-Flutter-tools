import 'package:flutter/material.dart';

List<T> MyListBuilder<T>({
  required int itemCount,
  required T Function(int index) builder,
  void Function(List<T> finalList)? onComplete,
}) {
  List<T> list = [];
  for (int i = 0; i < itemCount; i++) {
    list.add(builder(i));
  }
  if (onComplete != null) {
    onComplete(list);
  }
  return list;
}
