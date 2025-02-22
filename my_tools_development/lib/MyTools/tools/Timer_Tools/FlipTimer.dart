import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Defines the overall display mode.
enum DisplayMode {
  countdown,
  current12h,
  current24h,
}

/// Defines the animation style for digit transitions.
enum AnimationMode {
  flip,    // Card flips from top to bottom (flip clock style)
  rotate,  // Digit slides from top to center then slides down with opacity changes
}

/// The object returned by each flip callback.
class TimeFlipEvent {
  final int hour;
  final int minute;
  final int second;
  final String? period; // "AM" or "PM" (only in 12h mode)

  TimeFlipEvent({
    required this.hour,
    required this.minute,
    required this.second,
    this.period,
  });

  @override
  String toString() =>
      "Hour: $hour, Minute: $minute, Second: $second, Period: ${period ?? 'N/A'}";
}

/// Converts a DateTime into a TimeFlipEvent.
/// If is12 is true, converts to 12-hour format (with period), otherwise leaves as 24-hour.
TimeFlipEvent fromDateTime(DateTime dt, bool is12) {
  int hour = dt.hour;
  int minute = dt.minute;
  int second = dt.second;
  if (is12) {
    int hour12 = hour % 12 == 0 ? 12 : hour % 12;
    String period = hour < 12 ? "AM" : "PM";
    return TimeFlipEvent(hour: hour12, minute: minute, second: second, period: period);
  } else {
    return TimeFlipEvent(hour: hour, minute: minute, second: second, period: null);
  }
}

/// Increments the given TimeFlipEvent by one second, handling rollover.
/// [is12] indicates whether the time is in 12-hour format.
TimeFlipEvent incrementTime(TimeFlipEvent time, bool is12) {
  int h = time.hour;
  int m = time.minute;
  int s = time.second;
  s++;
  if (s >= 60) {
    s = 0;
    m++;
  }
  if (m >= 60) {
    m = 0;
    h++;
  }
  if (!is12 && h >= 24) {
    h = 0;
  } else if (is12 && h > 12) {
    // For 12-hour format, if hour exceeds 12, convert and toggle period.
    // We'll use a simple approach: if h becomes 13, then set it to 1 and toggle period.
    h = 1;
    String newPeriod = time.period == "AM" ? "PM" : "AM";
    return TimeFlipEvent(hour: h, minute: m, second: s, period: newPeriod);
  }
  if (is12) {
    // In 12-hour mode, determine period based on the underlying 24-hour logic.
    // Since our input is in 12-hour format, we assume period toggling is handled on rollover.
    return TimeFlipEvent(hour: h, minute: m, second: s, period: time.period);
  }
  return TimeFlipEvent(hour: h, minute: m, second: s, period: null);
}

/// PUBLIC WIDGET: MyFlipRotateTimer
///
/// Displays a timer (either as a countdown or showing the current time in 12h/24h mode)
/// using card-styled digits. Only hours, minutes, seconds (plus AM/PM in 12h mode) are shown.
/// Callback functions are provided for when the seconds, minutes, hours, or AM/PM flip.
/// In current time mode, if a custom time (as a TimeFlipEvent) is provided, it is used as the start,
/// and then incremented by one second on every tick.
class MyFlipRotateTimer extends StatefulWidget {
  final DisplayMode displayMode;
  final Duration initialDuration; // Used in countdown mode.
  final AnimationMode animationMode;
  final TextStyle digitTextStyle;
  final double cardWidth;
  final double cardHeight;
  final Duration digitAnimDuration;
  final VoidCallback? onComplete;
  // Callback functions.
  final ValueChanged<TimeFlipEvent>? onSecondFlip;
  final ValueChanged<TimeFlipEvent>? onMinuteFlip;
  final ValueChanged<TimeFlipEvent>? onHourFlip;
  final ValueChanged<TimeFlipEvent>? onAmPmFlip;
  /// In current time mode, if provided, overrides the system clock.
  final TimeFlipEvent? customTime;
  /// Custom decoration for each digit card.
  final BoxDecoration? cardDecoration;

  const MyFlipRotateTimer({
    Key? key,
    this.displayMode = DisplayMode.countdown,
    this.initialDuration = const Duration(seconds: 60),
    this.animationMode = AnimationMode.flip,
    this.digitTextStyle = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.cardWidth = 40,
    this.cardHeight = 60,
    this.digitAnimDuration = const Duration(milliseconds: 600),
    this.onComplete,
    this.onSecondFlip,
    this.onMinuteFlip,
    this.onHourFlip,
    this.onAmPmFlip,
    this.customTime,
    this.cardDecoration,
  }) : super(key: key);

  @override
  _MyFlipRotateTimerState createState() => _MyFlipRotateTimerState();
}

class _MyFlipRotateTimerState extends State<MyFlipRotateTimer> {
  // For countdown mode, we use remaining duration.
  Duration remaining = Duration.zero;
  Timer? _timer;
  // For current time mode, we use a TimeFlipEvent.
  TimeFlipEvent? _currentTimeEvent;

  int? prevHour, prevMinute, prevSecond;
  String? prevPeriod;

  @override
  void initState() {
    super.initState();
    if (widget.displayMode == DisplayMode.countdown) {
      remaining = widget.initialDuration;
      _startCountdownTimer();
    } else {
      bool is12 = widget.displayMode == DisplayMode.current12h;
      // If a custom time is provided, use it; otherwise, convert DateTime.now().
      _currentTimeEvent = widget.customTime ?? fromDateTime(DateTime.now(), is12);
      _startClockTimer();
    }
  }

  void _startCountdownTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remaining.inSeconds <= 0) {
        timer.cancel();
        if (widget.onComplete != null) widget.onComplete!();
      } else {
        setState(() {
          remaining -= const Duration(seconds: 1);
          int curHour = remaining.inHours;
          int curMinute = remaining.inMinutes.remainder(60);
          int curSecond = remaining.inSeconds.remainder(60);
          _checkAndCallCallbacks(curHour, curMinute, curSecond, null);
        });
      }
    });
  }

  void _startClockTimer() {
    _timer?.cancel();
    bool is12 = widget.displayMode == DisplayMode.current12h;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTimeEvent = _currentTimeEvent == null
            ? (widget.customTime ?? fromDateTime(DateTime.now(), is12))
            : incrementTime(_currentTimeEvent!, is12);
        int curHour = _currentTimeEvent!.hour;
        int curMinute = _currentTimeEvent!.minute;
        int curSecond = _currentTimeEvent!.second;
        String? curPeriod = _currentTimeEvent!.period;
        _checkAndCallCallbacks(curHour, curMinute, curSecond, curPeriod);
      });
    });
  }

  void _checkAndCallCallbacks(int curHour, int curMinute, int curSecond, String? curPeriod) {
    final event = TimeFlipEvent(
      hour: curHour,
      minute: curMinute,
      second: curSecond,
      period: curPeriod,
    );
    if (prevSecond == null || curSecond != prevSecond) {
      widget.onSecondFlip?.call(event);
      prevSecond = curSecond;
    }
    if (prevMinute == null || curMinute != prevMinute) {
      widget.onMinuteFlip?.call(event);
      prevMinute = curMinute;
    }
    if (prevHour == null || curHour != prevHour) {
      widget.onHourFlip?.call(event);
      prevHour = curHour;
    }
    if (widget.displayMode == DisplayMode.current12h) {
      if (prevPeriod == null || curPeriod != prevPeriod) {
        widget.onAmPmFlip?.call(event);
        prevPeriod = curPeriod;
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    if (widget.displayMode == DisplayMode.countdown) {
      final hours = _twoDigits(remaining.inHours);
      final minutes = _twoDigits(remaining.inMinutes.remainder(60));
      final seconds = _twoDigits(remaining.inSeconds.remainder(60));
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCardDigit(hours[0]),
          _buildCardDigit(hours[1]),
          _buildSeparator(),
          _buildCardDigit(minutes[0]),
          _buildCardDigit(minutes[1]),
          _buildSeparator(),
          _buildCardDigit(seconds[0]),
          _buildCardDigit(seconds[1]),
        ],
      );
    } else {
      // For current time mode, use _currentTimeEvent.
      if (_currentTimeEvent == null) return Container();
      if (widget.displayMode == DisplayMode.current24h) {
        final hh = _twoDigits(_currentTimeEvent!.hour);
        final mm = _twoDigits(_currentTimeEvent!.minute);
        final ss = _twoDigits(_currentTimeEvent!.second);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCardDigit(hh[0]),
            _buildCardDigit(hh[1]),
            _buildSeparator(),
            _buildCardDigit(mm[0]),
            _buildCardDigit(mm[1]),
            _buildSeparator(),
            _buildCardDigit(ss[0]),
            _buildCardDigit(ss[1]),
          ],
        );
      } else {
        // 12-hour format.
        int h = _currentTimeEvent!.hour;
        final hh = _twoDigits(h);
        final mm = _twoDigits(_currentTimeEvent!.minute);
        final ss = _twoDigits(_currentTimeEvent!.second);
        final isAm = _currentTimeEvent!.period == "AM";
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildCardDigit(hh[0]),
            _buildCardDigit(hh[1]),
            _buildSeparator(),
            _buildCardDigit(mm[0]),
            _buildCardDigit(mm[1]),
            _buildSeparator(),
            _buildCardDigit(ss[0]),
            _buildCardDigit(ss[1]),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              child: Text(
                isAm ? "AM" : "PM",
                style: widget.digitTextStyle.copyWith(
                  fontSize: (widget.digitTextStyle.fontSize ?? 40) * 0.6,
                ),
              ),
            ),
          ],
        );
      }
    }
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(":", style: widget.digitTextStyle),
    );
  }

  Widget _buildCardDigit(String digit) {
    return _FlipRotateCardDigit(
      digit: digit,
      textStyle: widget.digitTextStyle,
      width: widget.cardWidth,
      height: widget.cardHeight,
      duration: widget.digitAnimDuration,
      mode: widget.animationMode,
      decoration: widget.cardDecoration,
    );
  }
}

/// PRIVATE: _FlipRotateCardDigit is the internal widget that displays each digit
/// on a card with the specified animation style. It allows full decoration via [decoration].
class _FlipRotateCardDigit extends StatefulWidget {
  final String digit;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Color cardColor;
  final Duration duration;
  final AnimationMode mode;
  final BoxDecoration? decoration;

  const _FlipRotateCardDigit({
    Key? key,
    required this.digit,
    required this.textStyle,
    this.width = 40,
    this.height = 60,
    this.cardColor = const Color(0xFF333333),
    this.duration = const Duration(milliseconds: 600),
    this.mode = AnimationMode.flip,
    this.decoration,
  }) : super(key: key);

  @override
  State<_FlipRotateCardDigit> createState() => __FlipRotateCardDigitState();
}

class __FlipRotateCardDigitState extends State<_FlipRotateCardDigit>
    with SingleTickerProviderStateMixin {
  late String _oldDigit;
  late String _newDigit;
  late AnimationController _controller;
  late Animation<double> _animValue;

  @override
  void initState() {
    super.initState();
    _oldDigit = widget.digit;
    _newDigit = widget.digit;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animValue = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant _FlipRotateCardDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.digit != _newDigit) {
      _oldDigit = _newDigit;
      _newDigit = widget.digit;
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFlipAnimation() {
    return AnimatedBuilder(
      animation: _animValue,
      builder: (context, child) {
        double t = _animValue.value;
        if (t <= 0.5) {
          double angle = math.pi * t;
          return _buildCard(_oldDigit, angle);
        } else {
          double angle = math.pi * (t - 1.0);
          return _buildCard(_newDigit, angle);
        }
      },
    );
  }

  Widget _buildRotateAnimation() {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animValue,
          builder: (context, child) {
            double offsetY = _animValue.value;
            double opacity = 1.0 - _animValue.value;
            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(0, offsetY * widget.height),
                child: child,
              ),
            );
          },
          child: _buildCardContent(_oldDigit),
        ),
        AnimatedBuilder(
          animation: _animValue,
          builder: (context, child) {
            double offsetY = 1.0 - _animValue.value;
            double opacity = _animValue.value;
            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(0, -offsetY * widget.height),
                child: child,
              ),
            );
          },
          child: _buildCardContent(_newDigit),
        ),
      ],
    );
  }

  Widget _buildCard(String digit, double angle) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(angle),
      child: _buildCardContent(digit),
    );
  }

  Widget _buildCardContent(String digit) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      decoration: widget.decoration ??
          BoxDecoration(
            color: widget.cardColor,
            borderRadius: BorderRadius.circular(4),
          ),
      child: Text(digit, style: widget.textStyle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: widget.mode == AnimationMode.flip
          ? _buildFlipAnimation()
          : _buildRotateAnimation(),
    );
  }
}
