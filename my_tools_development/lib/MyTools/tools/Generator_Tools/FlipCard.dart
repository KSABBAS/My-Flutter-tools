import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Enum to define the type of flipping behavior.
enum FlipType {
  normal,   // Each tap toggles between front and back.
  bouncing, // On tap, flips (using normal logic) then automatically flips back after a delay.
  loop,     // Continuously cycles through a list of widgets.
}

class MyFlipperWidget extends StatefulWidget {
  final Widget front;
  final Widget back;
  final List<Widget>? widgetList; // Required for loop mode.
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final Duration flipDuration;
  final FlipType flipType;
  final Duration bounceDelay; // Only used in bouncing mode.
  final ValueChanged<int>? onFlip; // For non-loop modes: 0 means front, 1 means back; for loop mode, the current index.
  /// onTap returns the current face index when the card is tapped (only for normal and loop modes).
  final ValueChanged<int>? onTap;

  const MyFlipperWidget({
    Key? key,
    required this.front,
    required this.back,
    this.widgetList,
    this.width = 250,
    this.height = 350,
    this.borderRadius = 12.0,
    this.backgroundColor = Colors.white,
    this.boxShadow,
    this.flipDuration = const Duration(milliseconds: 800),
    this.flipType = FlipType.normal,
    this.bounceDelay = const Duration(milliseconds: 500),
    this.onFlip,
    this.onTap,
  })  : assert(
          flipType == FlipType.loop
              ? (widgetList != null && widgetList.length > 0)
              : true,
          'For loop mode, widgetList must be provided and non-empty.',
        ),
        super(key: key);

  @override
  _MyFlipperWidgetState createState() => _MyFlipperWidgetState();
}

class _MyFlipperWidgetState extends State<MyFlipperWidget>
    with SingleTickerProviderStateMixin {
  // NORMAL MODE:
  late AnimationController _normalController;
  late Animation<double> _normalAnimation;
  bool _normalIsFrontVisible = true;

  // BOUNCING MODE:
  late AnimationController _bouncingController;
  late Animation<double> _bouncingAnimation;
  bool _bouncingIsFrontVisible = true;

  // LOOP MODE:
  late AnimationController _loopController;
  late Animation<double> _loopAnimation;
  int _loopIndex = 0;

  @override
  void initState() {
    super.initState();
    switch (widget.flipType) {
      case FlipType.normal:
        _normalController = AnimationController(
          duration: widget.flipDuration,
          vsync: this,
        );
        _normalAnimation = Tween<double>(begin: 0, end: math.pi).animate(
          CurvedAnimation(parent: _normalController, curve: Curves.easeInOut),
        );
        _normalController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _normalIsFrontVisible = !_normalIsFrontVisible;
            });
            _normalController.reset();
            widget.onFlip?.call(_normalIsFrontVisible ? 0 : 1);
          }
        });
        break;
      case FlipType.bouncing:
        _bouncingController = AnimationController(
          duration: widget.flipDuration,
          vsync: this,
        );
        _bouncingAnimation = Tween<double>(begin: 0, end: math.pi).animate(
          CurvedAnimation(parent: _bouncingController, curve: Curves.easeInOut),
        );
        _bouncingController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            // When the animation completes, toggle the face.
            setState(() {
              _bouncingIsFrontVisible = !_bouncingIsFrontVisible;
            });
            _bouncingController.reset();
            widget.onFlip?.call(_bouncingIsFrontVisible ? 0 : 1);
            // If the card is now showing back, schedule a second flip after bounceDelay.
            if (!_bouncingIsFrontVisible) {
              Future.delayed(widget.bounceDelay, () {
                if (mounted &&
                    !_bouncingController.isAnimating &&
                    !_bouncingIsFrontVisible) {
                  _triggerBouncingFlip(); // This will flip it back.
                }
              });
            }
          }
        });
        break;
      case FlipType.loop:
        _loopController = AnimationController(
          duration: widget.flipDuration,
          vsync: this,
        );
        _loopAnimation = Tween<double>(begin: 0, end: math.pi).animate(
          CurvedAnimation(parent: _loopController, curve: Curves.easeInOut),
        );
        _loopController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _loopIndex = (_loopIndex + 1) % widget.widgetList!.length;
            });
            _loopController.reset();
            widget.onFlip?.call(_loopIndex);
          }
        });
        break;
    }
  }

  /// For bouncing mode, this triggers a normal flip (back to front).
  void _triggerBouncingFlip() {
    if (!_bouncingController.isAnimating) {
      _bouncingController.forward();
    }
  }

  void _flipCard() {
    switch (widget.flipType) {
      case FlipType.normal:
        if (!_normalController.isAnimating) {
          _normalController.forward();
        }
        break;
      case FlipType.bouncing:
        // Only trigger if card is currently front.
        if (!_bouncingIsFrontVisible) return;
        if (!_bouncingController.isAnimating) {
          _bouncingController.forward();
        }
        break;
      case FlipType.loop:
        if (!_loopController.isAnimating) {
          _loopController.forward();
        }
        break;
    }
  }

  @override
  void dispose() {
    if (widget.flipType == FlipType.normal) {
      _normalController.dispose();
    } else if (widget.flipType == FlipType.bouncing) {
      _bouncingController.dispose();
    } else if (widget.flipType == FlipType.loop) {
      _loopController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flipType == FlipType.loop) {
      return GestureDetector(
        onTap: () {
          _flipCard();
          // Return the current index when tapped.
          widget.onTap?.call(_loopIndex);
        },
        child: AnimatedBuilder(
          animation: _loopAnimation,
          builder: (context, child) {
            double angle = _loopAnimation.value;
            double extraRotation = (angle > math.pi / 2) ? math.pi : 0;
            // For loop mode, display the current face for first half,
            // and the next face for the second half.
            Widget content;
            if (angle <= math.pi / 2) {
              content = widget.widgetList![_loopIndex];
            } else {
              content =
                  widget.widgetList![(_loopIndex + 1) % widget.widgetList!.length];
            }
            return _buildCard(content, angle, extraRotation);
          },
        ),
      );
    } else {
      // Normal and bouncing modes use two faces (front/back).
      return GestureDetector(
        onTap: () {
          _flipCard();
          // In normal mode, return the current index (0 for front, 1 for back).
          if (widget.flipType == FlipType.normal) {
            widget.onTap?.call(_normalIsFrontVisible ? 0 : 1);
          }
          // For bouncing, we won't call onTap.
        },
        child: AnimatedBuilder(
          animation: widget.flipType == FlipType.normal
              ? _normalAnimation
              : _bouncingAnimation,
          builder: (context, child) {
            double angle = widget.flipType == FlipType.normal
                ? _normalAnimation.value
                : _bouncingAnimation.value;
            double extraRotation = (angle > math.pi / 2) ? math.pi : 0;
            // Use faces[0] as front and faces[1] as back.
            Widget content;
            if (widget.flipType == FlipType.normal) {
              content = _normalIsFrontVisible
                  ? (angle <= math.pi / 2 ? widget.front : widget.back)
                  : (angle <= math.pi / 2 ? widget.back : widget.front);
            } else {
              // Bouncing mode.
              content = _bouncingIsFrontVisible
                  ? (angle <= math.pi / 2 ? widget.front : widget.back)
                  : (angle <= math.pi / 2 ? widget.back : widget.front);
            }
            return _buildCard(content, angle, extraRotation);
          },
        ),
      );
    }
  }

  Widget _buildCard(Widget content, double angle, double extraRotation) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(angle),
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: widget.boxShadow ??
              const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                )
              ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(extraRotation),
            child: content,
          ),
        ),
      ),
    );
  }
}
