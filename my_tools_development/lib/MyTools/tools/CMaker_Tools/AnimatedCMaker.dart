import 'package:flutter/material.dart';
class ACMaker extends StatefulWidget {
  ACMaker(
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
      this.duration,
      this.transform});
  Color? color;
  Duration? duration;
  double? height;
  double? width;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Matrix4? transform;
  DecorationImage? BackGroundimage;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
  BoxBorder? border;
  double? circularRadius;
  Widget? child;
  @override
  State<ACMaker> createState() => _ACMakerState();
}

class _ACMakerState extends State<ACMaker> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: widget.transform,
      duration: widget.duration ?? const Duration(milliseconds: 300),
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