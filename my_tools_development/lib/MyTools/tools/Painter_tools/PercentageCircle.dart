import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';

class PercentageCirclePainter extends StatelessWidget {
  const PercentageCirclePainter({
    super.key,
    required this.percentage,
    this.strokeWidth,
    this.addText,
    this.backgroundColor,
    this.fillColor,
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
    this.transform,
    this.clipBehavior,
    this.shape,
    this.textStyle
  });
  final double percentage;
  final Color? fillColor;
  final Color? backgroundColor;
  final bool? addText;
  final Color? color;
  final double? height;
  final double? width;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final DecorationImage? BackGroundimage;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final Matrix4? transform;
  final BoxBorder? border;
  final double? circularRadius;
  final Clip? clipBehavior;
  final BoxShape? shape;
  final double? strokeWidth;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return CMaker(
      height: height ?? 300,
      width: width ?? 300,
      clipBehavior: clipBehavior,
      transform: transform,
      alignment: alignment,
      padding: padding,
      margin: margin,
      shape: shape,
      gradient: gradient,
      BackGroundimage: BackGroundimage,
      border: border,
      color: color,
      boxShadow: boxShadow,
      circularRadius: 0,
      child: CustomPaint(
          painter: PercentageCircle(percentage / 100,
              backgroundColor: backgroundColor ?? Colors.white,
              fillColor: fillColor ?? Colors.blueAccent,
              strokeWidth: strokeWidth ?? 20),
          child: (addText ?? false)
              ? Center(
                  child: Text(
                    '${(percentage).toInt()}%',
                    style: textStyle ??
                        TextStyle(fontSize: 30, color: Colors.black),
                  ),
                )
              : null),
    );
  }
}

class PercentageCircle extends CustomPainter {
  final double percentage;
  final Color fillColor;
  final Color backgroundColor;
  final double strokeWidth;

  PercentageCircle(this.percentage,
      {this.fillColor = Colors.blueAccent,
      this.backgroundColor = Colors.white,
      this.strokeWidth = 20});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth // Adjust stroke width
      ..strokeCap = StrokeCap.round;

    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth // Adjust stroke width
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius =
        size.width / 2 - strokeWidth; // Adjust for stroke width

    // Draw the background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw the filled arc with rounded edges
    final double startAngle = -90 * (3.14159265358979323846 / 180);
    final double sweepAngle = percentage * 360 * (3.14159265358979323846 / 180);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(PercentageCircle oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
