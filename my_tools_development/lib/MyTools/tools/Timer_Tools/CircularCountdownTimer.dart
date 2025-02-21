import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A data class that holds the full breakdown of remaining time.
class CountdownTime {
  final int years;
  final int months;
  final int weeks;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  CountdownTime({
    required this.years,
    required this.months,
    required this.weeks,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  String toString() {
    return "$years : $months : $weeks : $days : $hours : $minutes : $seconds";
  }
}

/// Converts a total number of seconds into a CountdownTime using fixed factors:
/// 1 year = 365 days, 1 month = 30 days, 1 week = 7 days.
CountdownTime convertSecondsToCountdownTime(int totalSeconds) {
  int rem = totalSeconds;
  int years = rem ~/ (365 * 86400);
  rem %= (365 * 86400);
  int months = rem ~/ (30 * 86400);
  rem %= (30 * 86400);
  int weeks = rem ~/ (7 * 86400);
  rem %= (7 * 86400);
  int days = rem ~/ 86400;
  rem %= 86400;
  int hours = rem ~/ 3600;
  rem %= 3600;
  int minutes = rem ~/ 60;
  int seconds = rem % 60;
  return CountdownTime(
    years: years,
    months: months,
    weeks: weeks,
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}

/// A customizable countdown timer widget that displays a smooth circular progress arc
/// and a center text showing a chain of time units (from the highest specified to the lowest)
/// arranged from left to right (largest on the left, smallest on the right).
///
/// You define the countdown via separate optional relative amounts for each unit.
/// Only the chain between your highest and lowest “specified” unit is displayed.
/// All callbacks return the full breakdown as a [CountdownTime] object.
///
/// In addition, you have full control over the control button appearance:
/// • You can set the container width/height, icon size, background color, icon color, and border radius.
/// • A bottom overlay appears on mouse hover; you can control its color and height.
class MyCircularCountdownTimer extends StatefulWidget {
  // Countdown input – if you want a unit to be considered in the display chain,
  // pass a nonzero value. (Units left as 0 are omitted from the display chain.)
  final int years;
  final int months;
  final int weeks;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  /// Called when the countdown completes.
  final VoidCallback? onComplete;

  /// Called when the timer is started/resumed.
  final ValueChanged<CountdownTime>? onPlay;

  /// Called when the timer is paused.
  final ValueChanged<CountdownTime>? onPause;

  /// Called whenever the remaining whole seconds change.
  final ValueChanged<CountdownTime>? onChangedTime;

  // Circular progress customization.
  final double size;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Gradient? progressGradient;
  final TextStyle textStyle;
  final bool autoStart;

  // Control button customization.
  final bool showControlButton;
  final Alignment controlButtonAlignment;
  final double controlButtonContainerWidth;
  final double controlButtonContainerHeight;
  final double controlButtonIconSize;
  final Color controlButtonBackgroundColor;
  final Color controlButtonIconColor;
  final double controlButtonBorderRadius;

  // Bottom overlay customization.
  final double bottomOverlayHeight;

  const MyCircularCountdownTimer({
    Key? key,
    this.years = 0,
    this.months = 0,
    this.weeks = 0,
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.onComplete,
    this.onPlay,
    this.onPause,
    this.onChangedTime,
    this.size = 200,
    this.strokeWidth = 10,
    this.backgroundColor = Colors.transparent,
    this.progressColor = Colors.green,
    this.progressGradient,
    this.textStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    this.autoStart = true,
    this.showControlButton = true,
    this.controlButtonAlignment = Alignment.bottomCenter,
    this.controlButtonContainerWidth = 60,
    this.controlButtonContainerHeight = 60,
    this.controlButtonIconSize = 30,
    this.controlButtonBackgroundColor = Colors.white,
    this.controlButtonIconColor = Colors.black,
    this.controlButtonBorderRadius = 30,
    this.bottomOverlayHeight = 40,
  }) : super(key: key);

  @override
  _MyCircularCountdownTimerState createState() => _MyCircularCountdownTimerState();
}

class _MyCircularCountdownTimerState extends State<MyCircularCountdownTimer>
    with SingleTickerProviderStateMixin {
  late final int _totalSeconds;
  late AnimationController _controller;
  int? _lastReportedWholeSeconds;
  bool _isRunning = false;

  // For the display chain, we use the fixed order:
  // [years, months, weeks, days, hours, minutes, seconds]
  late int _displayStartIndex;
  late int _displayEndIndex;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    // Compute total seconds using fixed conversion factors.
    _totalSeconds = ((widget.years * 365 +
                widget.months * 30 +
                widget.weeks * 7 +
                widget.days) *
            86400) +
        (widget.hours * 3600) +
        (widget.minutes * 60) +
        widget.seconds;

    // Build a list of provided units in the order: [years, months, weeks, days, hours, minutes, seconds]
    List<int> providedUnits = [
      widget.years,
      widget.months,
      widget.weeks,
      widget.days,
      widget.hours,
      widget.minutes,
      widget.seconds,
    ];

    // Determine which indices were explicitly specified (nonzero).
    List<int> providedIndices = [];
    for (int i = 0; i < providedUnits.length; i++) {
      if (providedUnits[i] != 0) providedIndices.add(i);
    }
    // If nothing is specified, default to seconds (index 6).
    if (providedIndices.isEmpty) {
      providedIndices.add(6);
    }
    // The display chain spans from the highest specified unit (smallest index)
    // to the lowest specified unit (largest index) in this fixed order.
    _displayStartIndex = providedIndices.first;
    _displayEndIndex = providedIndices.last;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _totalSeconds),
    );

    _controller.addListener(() {
      setState(() {});
      final int remaining = _remainingSeconds;
      if (_lastReportedWholeSeconds == null ||
          remaining != _lastReportedWholeSeconds) {
        _lastReportedWholeSeconds = remaining;
        if (widget.onChangedTime != null) {
          widget.onChangedTime!(convertSecondsToCountdownTime(remaining));
        }
      }
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isRunning = false;
        if (widget.onComplete != null) widget.onComplete!();
      }
    });

    if (widget.autoStart) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Computes the remaining seconds (smoothed via the AnimationController).
  int get _remainingSeconds {
    final rem = ((1 - _controller.value) * _totalSeconds).ceil();
    return rem < 0 ? 0 : rem;
  }

  /// Returns the progress (0.0 to 1.0) for the circular slider.
  double get _progress => 1 - _controller.value;

  /// Formats the remaining time as a chain of units in the fixed order:
  /// [years, months, weeks, days, hours, minutes, seconds].
  /// Only units from _displayStartIndex to _displayEndIndex are shown.
  String _formatRemainingTime() {
    CountdownTime ct = convertSecondsToCountdownTime(_remainingSeconds);
    List<int> breakdown = [
      ct.years,
      ct.months,
      ct.weeks,
      ct.days,
      ct.hours,
      ct.minutes,
      ct.seconds,
    ];
    List<String> parts = [];
    for (int i = _displayStartIndex; i <= _displayEndIndex; i++) {
      parts.add(breakdown[i].toString().padLeft(2, '0'));
    }
    return parts.join(" : ");
  }

  void _startTimer() {
    _isRunning = true;
    _controller.forward(from: _controller.value);
    if (widget.onPlay != null) {
      widget.onPlay!(convertSecondsToCountdownTime(_remainingSeconds));
    }
  }

  void _pauseTimer() {
    _controller.stop();
    _isRunning = false;
    if (widget.onPause != null) {
      widget.onPause!(convertSecondsToCountdownTime(_remainingSeconds));
    }
  }

  void _toggleTimer() {
    if (_isRunning) {
      _pauseTimer();
    } else {
      _startTimer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Smooth circular progress arc.
            CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _CircularCountdownPainter(
                progress: _progress,
                strokeWidth: widget.strokeWidth,
                progressColor: widget.progressColor,
                progressGradient: widget.progressGradient,
                backgroundColor: widget.backgroundColor,
              ),
            ),
            // Center text displaying the countdown chain.
            Text(
              _formatRemainingTime(),
              style: widget.textStyle,
              textAlign: TextAlign.center,
            ),
            // Control button with full styling.
            if (widget.showControlButton)
              Align(
                alignment: widget.controlButtonAlignment,
                child: Container(
                  width: widget.controlButtonContainerWidth,
                  height: widget.controlButtonContainerHeight,
                  decoration: BoxDecoration(
                    color: widget.controlButtonBackgroundColor,
                    borderRadius: BorderRadius.circular(widget.controlButtonBorderRadius),
                  ),
                  child: IconButton(
                    iconSize: widget.controlButtonIconSize,
                    icon: Icon(
                      _isRunning ? Icons.pause : Icons.play_arrow,
                      color: widget.controlButtonIconColor,
                    ),
                    onPressed: _toggleTimer,
                  ),
                ),
              ),
            // Bottom overlay that appears on mouse hover.
          ],
        ),
      ),
    );
  }
}

/// CustomPainter for drawing the smooth circular progress arc.
class _CircularCountdownPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Gradient? progressGradient;
  final Color backgroundColor;

  _CircularCountdownPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    this.progressGradient,
    this.backgroundColor = Colors.transparent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width / 2) - (strokeWidth / 2);

    // Optionally draw a background circle.
    if (backgroundColor != Colors.transparent) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawCircle(center, radius, backgroundPaint);
    }

    // Draw the progress arc.
    final Paint progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    if (progressGradient != null) {
      progressPaint.shader = progressGradient!.createShader(
        Rect.fromCircle(center: center, radius: radius),
      );
    } else {
      progressPaint.color = progressColor;
    }
    double sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularCountdownPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        strokeWidth != oldDelegate.strokeWidth ||
        progressColor != oldDelegate.progressColor ||
        progressGradient != oldDelegate.progressGradient ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
