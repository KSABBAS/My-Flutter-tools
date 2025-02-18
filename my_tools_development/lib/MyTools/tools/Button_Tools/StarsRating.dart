import 'package:flutter/material.dart';
import 'dart:math';

/// Controls the style of the star’s edges.
enum StarEdgeStyle {
  /// Star corners have a sharper join.
  sharp,

  /// Star corners are rounded.
  smooth,
}

class StarRating extends StatefulWidget {
  /// Total number of stars (default is 5).
  final int starCount;

  /// The initial rating (how many stars are initially selected).
  final int initialRating;

  /// The width/height of each star.
  final double starSize;

  /// Spacing between stars.
  final double starSpacing;

  /// The fill color for selected stars.
  final Color selectedFillColor;

  /// Whether to show a border around selected stars.
  final bool showSelectedBorder;

  /// The stroke color for selected stars (only used if [showSelectedBorder] is true).
  final Color selectedStrokeColor;

  /// The stroke width for selected stars (only used if [showSelectedBorder] is true).
  final double selectedStrokeWidth;

  /// The fill color (actually just the stroke color) for unselected stars.
  final Color unselectedStrokeColor;

  /// The stroke width for unselected stars.
  final double unselectedStrokeWidth;

  /// Enum controlling the corners of the star (sharp or smooth).
  final StarEdgeStyle starEdgeStyle;

  /// Callback that returns the new rating when a star is tapped.
  final ValueChanged<int>? onRatingChanged;

  /// An optional decoration for the container that holds all the stars.
  final BoxDecoration? decoration;

  const StarRating({
    Key? key,
    this.starCount = 5,
    this.initialRating = 0,
    this.starSize = 40.0,
    this.starSpacing = 4.0,
    this.selectedFillColor = Colors.amber,
    this.showSelectedBorder = true,
    this.selectedStrokeColor = Colors.amber,
    this.selectedStrokeWidth = 2.0,
    this.unselectedStrokeColor = Colors.grey,
    this.unselectedStrokeWidth = 2.0,
    this.starEdgeStyle = StarEdgeStyle.smooth,
    this.onRatingChanged,
    this.decoration,
  }) : super(key: key);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating.clamp(0, widget.starCount);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildStarWidgets(),
      ),
    );
  }

  List<Widget> _buildStarWidgets() {
    final stars = <Widget>[];
    for (int i = 0; i < widget.starCount; i++) {
      final filled = (i < _currentRating);

      stars.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = i + 1;
            });
            widget.onRatingChanged?.call(_currentRating);
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: CustomPaint(
              // Key differentiates filled/unfilled states for AnimatedSwitcher
              key: ValueKey<bool>(filled),
              size: Size(widget.starSize, widget.starSize),
              painter: _StarPainter(
                filled: filled,
                starSize: widget.starSize,
                selectedFillColor: widget.selectedFillColor,
                showSelectedBorder: widget.showSelectedBorder,
                selectedStrokeColor: widget.selectedStrokeColor,
                selectedStrokeWidth: widget.selectedStrokeWidth,
                unselectedStrokeColor: widget.unselectedStrokeColor,
                unselectedStrokeWidth: widget.unselectedStrokeWidth,
                starEdgeStyle: widget.starEdgeStyle,
              ),
            ),
          ),
        ),
      );

      // Add spacing between stars except after the last one
      if (i < widget.starCount - 1) {
        stars.add(SizedBox(width: widget.starSpacing));
      }
    }
    return stars;
  }
}

/// CustomPainter that draws a single star with optional fill and stroke.
class _StarPainter extends CustomPainter {
  final bool filled;
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
  final StarEdgeStyle starEdgeStyle;

  _StarPainter({
    required this.filled,
    required this.starSize,
    required this.selectedFillColor,
    required this.showSelectedBorder,
    required this.selectedStrokeColor,
    required this.selectedStrokeWidth,
    required this.unselectedStrokeColor,
    required this.unselectedStrokeWidth,
    required this.starEdgeStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double outerRadius = starSize / 2;
    // Adjust inner radius ratio to control star's thickness.
    final double innerRadius = outerRadius * 0.5;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final path = _createStarPath(center, outerRadius, innerRadius, 5);

    // If the star is filled, paint the fill.
    if (filled) {
      final Paint fillPaint = Paint()
        ..color = selectedFillColor
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, fillPaint);

      // If we want a border on selected stars:
      if (showSelectedBorder) {
        final Paint strokePaint = Paint()
          ..color = selectedStrokeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = selectedStrokeWidth
          ..strokeJoin =
              (starEdgeStyle == StarEdgeStyle.smooth) ? StrokeJoin.round : StrokeJoin.miter;
        canvas.drawPath(path, strokePaint);
      }
    } else {
      // Unfilled star: only draw stroke.
      final Paint strokePaint = Paint()
        ..color = unselectedStrokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = unselectedStrokeWidth
        ..strokeJoin =
            (starEdgeStyle == StarEdgeStyle.smooth) ? StrokeJoin.round : StrokeJoin.miter;
      canvas.drawPath(path, strokePaint);
    }
  }

  /// Creates a 5-point star path. You can customize [points] if you want more.
  Path _createStarPath(Offset center, double outerRadius, double innerRadius, int points) {
    final Path path = Path();
    double angle = -pi / 2; // Start at the top
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
  bool shouldRepaint(_StarPainter oldDelegate) {
    return filled != oldDelegate.filled ||
        starSize != oldDelegate.starSize ||
        selectedFillColor != oldDelegate.selectedFillColor ||
        showSelectedBorder != oldDelegate.showSelectedBorder ||
        selectedStrokeColor != oldDelegate.selectedStrokeColor ||
        selectedStrokeWidth != oldDelegate.selectedStrokeWidth ||
        unselectedStrokeColor != oldDelegate.unselectedStrokeColor ||
        unselectedStrokeWidth != oldDelegate.unselectedStrokeWidth ||
        starEdgeStyle != oldDelegate.starEdgeStyle;
  }
}
