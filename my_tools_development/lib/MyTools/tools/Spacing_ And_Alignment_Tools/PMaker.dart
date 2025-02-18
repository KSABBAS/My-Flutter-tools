import 'package:flutter/material.dart';
class PMaker extends StatelessWidget {
  PMaker({
    super.key,
    this.horizontal,
    this.vertical,
  });
  double? horizontal;
  double? vertical;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
      top: vertical ?? 0,
      left: horizontal ?? 0,
    ));
  }
}