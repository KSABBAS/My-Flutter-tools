import 'package:flutter/material.dart';
class CMaker extends StatefulWidget {
  CMaker(
      {super.key,
      this.child,
      this.height,
      this.width,
      this.boxShadow,
      this.border,
      this.BackGroundimage,
      this.margin,
      this.padding,
      this.alignment,
      this.color,
      this.gradient,
      this.circularRadius,
      this.transform});
  Color? color;
  double? height;
  double? width;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  DecorationImage? BackGroundimage;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
  Matrix4? transform;
  BoxBorder? border;
  double? circularRadius;
  Widget? child;
  @override
  State<CMaker> createState() => _CMakerState();
}

class _CMakerState extends State<CMaker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      transform: widget.transform,
      alignment: widget.alignment,
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
          gradient: widget.gradient,
          image: widget.BackGroundimage,
          border: widget.border,
          color: widget.color,
          boxShadow: widget.boxShadow,
          borderRadius: BorderRadius.circular(
            widget.circularRadius ?? 0,
          )),
      height: widget.height,
      width: widget.width,
      child: widget.child,
    );
  }
}