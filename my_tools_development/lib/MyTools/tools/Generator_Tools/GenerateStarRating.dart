import 'dart:math';
import 'package:flutter/material.dart';

//====================================
// use it like this :
// StarRatingDisplay(
//             key: ValueKey((rating1+rating2+rating3)/3),
//             rating: (rating1+rating2+rating3)/3,
//             starSpacing: 10,
//             unselectedStrokeColor: Colors.red,
//           ),

//====================================

/// Controls the style of the star’s edges: sharp or smooth.
enum StarEdgeShape {
  /// Star corners have a sharp/miter join.
  sharp,

  /// Star corners are rounded.
  smooth,
}

/// A read-only star rating display widget.
/// It animates from 0 up to [rating] (which can be fractional, e.g. 3.2).
class StarRatingDisplay extends StatefulWidget {
  /// The total number of stars. Default is 5.
  final int starCount;

  /// The final rating to display (e.g., 3.2 means 3 full stars + 0.2 partial).
  final double rating;

  /// The duration of the "fill" animation from 0.0 up to [rating].
  final Duration animationDuration;

  /// The size (width/height) of each star.
  final double starSize;

  /// The spacing between adjacent stars.
  final double starSpacing;

  /// The color used to fill any portion of a star.
  final Color selectedFillColor;

  /// Whether to show a border around partially/fully filled stars.
  final bool showSelectedBorder;

  /// The stroke color for partially/fully filled stars (only used if showSelectedBorder == true).
  final Color selectedStrokeColor;

  /// The stroke width for partially/fully filled stars (only used if showSelectedBorder == true).
  final double selectedStrokeWidth;

  /// The stroke color for stars with zero fill.
  final Color unselectedStrokeColor;

  /// The stroke width for stars with zero fill.
  final double unselectedStrokeWidth;

  /// Sharp or smooth corners for the star’s edges.
  final StarEdgeShape starEdgeShape;

  /// Decoration for the container that holds the entire row of stars.
  final BoxDecoration? decoration;

  const StarRatingDisplay({
    Key? key,
    this.starCount = 5,
    required this.rating,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.starSize = 40.0,
    this.starSpacing = 4.0,
    this.selectedFillColor = Colors.amber,
    this.showSelectedBorder = true,
    this.selectedStrokeColor = Colors.amber,
    this.selectedStrokeWidth = 2.0,
    this.unselectedStrokeColor = Colors.grey,
    this.unselectedStrokeWidth = 2.0,
    this.starEdgeShape = StarEdgeShape.smooth,
    this.decoration,
  }) : super(key: key);

  @override
  _StarRatingDisplayState createState() => _StarRatingDisplayState();
}

class _StarRatingDisplayState extends State<StarRatingDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _ratingAnimation;

  @override
  void initState() {
    super.initState();

    // Clamp the final rating to [0, starCount].
    final double finalRating = widget.rating.clamp(0, widget.starCount).toDouble();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _ratingAnimation = Tween<double>(begin: 0.0, end: finalRating).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start the animation.
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _ratingAnimation,
        builder: (context, child) {
          // The current rating value from 0..(starCount).
          final double currentRating = _ratingAnimation.value;

          // Build the row of stars, each star partially filled if needed.
          final stars = <Widget>[];
          for (int i = 0; i < widget.starCount; i++) {
            // portion for star i: how much of star i is filled? Range [0..1].
            // e.g. if currentRating=2.2, star i=0 => portion=1.0, star i=1 => portion=1.0, star i=2 => portion=0.2, star i=3 => portion=0, etc.
            final double portion = (currentRating - i).clamp(0.0, 1.0);

            stars.add(CustomPaint(
              size: Size(widget.starSize, widget.starSize),
              painter: _PartialStarPainter(
                portion: portion,
                starSize: widget.starSize,
                selectedFillColor: widget.selectedFillColor,
                showSelectedBorder: widget.showSelectedBorder,
                selectedStrokeColor: widget.selectedStrokeColor,
                selectedStrokeWidth: widget.selectedStrokeWidth,
                unselectedStrokeColor: widget.unselectedStrokeColor,
                unselectedStrokeWidth: widget.unselectedStrokeWidth,
                starEdgeShape: widget.starEdgeShape,
              ),
            ));

            // Add spacing except after the last star
            if (i < widget.starCount - 1) {
              stars.add(SizedBox(width: widget.starSpacing));
            }
          }

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: stars,
          );
        },
      ),
    );
  }
}

/// Painter that draws a single star partially filled by [portion].
class _PartialStarPainter extends CustomPainter {
  /// [portion] is how much of the star is filled: 0 => unfilled, 1 => full, 0.2 => partial fill.
  final double portion;
  final double starSize;

  // Selected star fill & border
  final Color selectedFillColor;
  final bool showSelectedBorder;
  final Color selectedStrokeColor;
  final double selectedStrokeWidth;

  // Unselected star border
  final Color unselectedStrokeColor;
  final double unselectedStrokeWidth;

  // Star edge style
  final StarEdgeShape starEdgeShape;

  _PartialStarPainter({
    required this.portion,
    required this.starSize,
    required this.selectedFillColor,
    required this.showSelectedBorder,
    required this.selectedStrokeColor,
    required this.selectedStrokeWidth,
    required this.unselectedStrokeColor,
    required this.unselectedStrokeWidth,
    required this.starEdgeShape,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double outerRadius = starSize / 2;
    // Adjust this ratio to change how "fat" the star arms are.
    final double innerRadius = outerRadius * 0.5;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Path starPath = _createStarPath(center, outerRadius, innerRadius, 5);

    // PARTIAL FILL: we fill a portion of the star horizontally from left to right.
    // 1) Clip to star path.
    canvas.save();
    canvas.clipPath(starPath);

    // 2) Fill a rectangle from left to [portion * width].
    final double fillWidth = portion * size.width;
    if (fillWidth > 0) {
      final Rect fillRect = Rect.fromLTWH(0, 0, fillWidth, size.height);
      final Paint fillPaint = Paint()
        ..color = selectedFillColor
        ..style = PaintingStyle.fill;
      canvas.drawRect(fillRect, fillPaint);
    }
    canvas.restore();

    // STROKE
    // If portion>0 => star is partially or fully selected => use selected stroke if [showSelectedBorder].
    // If portion==0 => star is unselected => use unselected stroke.
    if (portion > 0 && showSelectedBorder) {
      final Paint strokePaint = Paint()
        ..color = selectedStrokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = selectedStrokeWidth
        ..strokeJoin =
            (starEdgeShape == StarEdgeShape.smooth) ? StrokeJoin.round : StrokeJoin.miter;
      canvas.drawPath(starPath, strokePaint);
    } else if (portion == 0) {
      final Paint strokePaint = Paint()
        ..color = unselectedStrokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = unselectedStrokeWidth
        ..strokeJoin =
            (starEdgeShape == StarEdgeShape.smooth) ? StrokeJoin.round : StrokeJoin.miter;
      canvas.drawPath(starPath, strokePaint);
    }
  }

  /// Creates a 5-point star path. 
  /// [outerRadius] is the distance from center to a tip, 
  /// [innerRadius] is the distance from center to a valley,
  /// [points] is number of tips (default 5).
  Path _createStarPath(Offset center, double outerRadius, double innerRadius, int points) {
    final Path path = Path();
    double angle = -pi / 2; // start at the top
    final double step = pi / points;
    for (int i = 0; i < points * 2; i++) {
      final double r = (i.isEven) ? outerRadius : innerRadius;
      final double x = center.dx + r * cos(angle);
      final double y = center.dy + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      angle += step;
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(_PartialStarPainter oldDelegate) {
    return portion != oldDelegate.portion ||
        starSize != oldDelegate.starSize ||
        selectedFillColor != oldDelegate.selectedFillColor ||
        showSelectedBorder != oldDelegate.showSelectedBorder ||
        selectedStrokeColor != oldDelegate.selectedStrokeColor ||
        selectedStrokeWidth != oldDelegate.selectedStrokeWidth ||
        unselectedStrokeColor != oldDelegate.unselectedStrokeColor ||
        unselectedStrokeWidth != oldDelegate.unselectedStrokeWidth ||
        starEdgeShape != oldDelegate.starEdgeShape;
  }
}
