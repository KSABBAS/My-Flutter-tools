import 'package:flutter/material.dart';
class DistributiveGView extends StatelessWidget {
  DistributiveGView(
      {required this.itemCount,
      required this.itemBuilder,
      required this.itemHeight,
      required this.itemWidth,
      this.mainAxisSpacing = 0,
      this.crossAxisSpacing = 0,
      this.surroundpadding});
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double itemHeight;
  final double itemWidth;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? surroundpadding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
            padding: surroundpadding ?? EdgeInsets.all(0),
            child: GridView.builder(
              itemCount: itemCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (constraints.maxWidth / itemWidth).floor(),
                childAspectRatio: itemWidth / itemHeight,
                mainAxisSpacing: mainAxisSpacing,
                crossAxisSpacing: crossAxisSpacing,
              ),
              itemBuilder: itemBuilder,
            ));
      },
    );
  }
}