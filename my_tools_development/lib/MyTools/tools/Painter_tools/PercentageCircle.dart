import 'package:flutter/material.dart';
class PercentageCircle extends CustomPainter {
  final double percentage;
  final Color fillColor;
  final Color backgroundColor;

  PercentageCircle(this.percentage,
      {this.fillColor = Colors.blueAccent,
      this.backgroundColor = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20 // Adjust stroke width
      ..strokeCap = StrokeCap.round;

    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20 // Adjust stroke width
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2 - 20; // Adjust for stroke width

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