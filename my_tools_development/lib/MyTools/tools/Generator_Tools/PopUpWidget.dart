import 'package:flutter/material.dart';
import 'dart:ui'; // For ImageFilter

/// Controls the side from which the popup appears.
enum PopupDirection {
  top,
  bottom,
  left,
  right,
}

/// Controls which animation is applied when the popup appears.
enum PopupAnimationType {
  none,
  fade,
  scale,
  slide,
}

/// The custom popup menu widget.
class MyPopupMenu extends StatefulWidget {
  final Widget child;
  final PopupDirection direction;
  final double width;
  final double height;
  final Color color;
  final double borderRadius;
  final double arrowHeight;
  final double arrowWidth;
  final BoxShadow? boxShadow;
  final WidgetBuilder builder;

  // Overlay customization: by default the overlay background is fully transparent.
  final Color overlayColor;
  final double overlayBlur;

  /// When true, the area where [child] is shown will be excluded
  /// from the overlay’s color and blur effect so that it remains clear.
  final bool excludeChildFromBlur;

  /// Select the animation type for the popup appearance.
  final PopupAnimationType animationType;

  /// Controls the duration of the animation.
  final Duration animationDuration;

  /// For slide animations: if true, the slide offset is reversed.
  final bool slideReverse;

  const MyPopupMenu({
    Key? key,
    required this.child,
    required this.builder,
    this.direction = PopupDirection.bottom,
    this.width = 200,
    this.height = 100,
    this.color = Colors.white,
    this.borderRadius = 8.0,
    this.arrowHeight = 10.0,
    this.arrowWidth = 20.0,
    this.boxShadow,
    this.overlayColor = Colors.transparent, // Fully invisible by default.
    this.overlayBlur = 0.0,
    this.excludeChildFromBlur = false,
    this.animationType = PopupAnimationType.fade,
    this.animationDuration = const Duration(milliseconds: 300),
    this.slideReverse = false,
  }) : super(key: key);

  @override
  State<MyPopupMenu> createState() => _MyPopupMenuState();
}

class _MyPopupMenuState extends State<MyPopupMenu> {
  OverlayEntry? _overlayEntry;

  void _showOverlay() {
    _removeOverlay();

    // Get the trigger widget's global position and size.
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final childRect = offset & size;
    final position = _calculatePopupPosition(offset, size);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // Full-screen overlay background.
            Positioned.fill(
              child: GestureDetector(
                onTap: _removeOverlay,
                child: widget.excludeChildFromBlur
                    ? ClipPath(
                        clipper: _HoleClipper(holeRect: childRect),
                        child: widget.overlayBlur > 0
                            ? BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: widget.overlayBlur,
                                    sigmaY: widget.overlayBlur),
                                child: Container(color: widget.overlayColor),
                              )
                            : Container(color: widget.overlayColor),
                      )
                    : widget.overlayBlur > 0
                        ? BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: widget.overlayBlur,
                                sigmaY: widget.overlayBlur),
                            child: Container(color: widget.overlayColor),
                          )
                        : Container(color: widget.overlayColor),
              ),
            ),
            // Positioned popup bubble with animation.
            Positioned(
              left: position.dx,
              top: position.dy,
              child: GestureDetector(
                onTap: () {}, // Prevents tap inside popup from dismissing overlay.
                child: Material(
                  color: Colors.transparent,
                  child: AnimatedPopup(
                    animationType: widget.animationType,
                    direction: widget.direction,
                    duration: widget.animationDuration,
                    slideReverse: widget.slideReverse,
                    child: _PopupBubble(
                      width: widget.width,
                      height: widget.height,
                      color: widget.color,
                      borderRadius: widget.borderRadius,
                      arrowHeight: widget.arrowHeight,
                      arrowWidth: widget.arrowWidth,
                      direction: widget.direction,
                      boxShadow: widget.boxShadow,
                      child: Builder(builder: widget.builder),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  Offset _calculatePopupPosition(Offset offset, Size targetSize) {
    double dx = offset.dx;
    double dy = offset.dy;
    switch (widget.direction) {
      case PopupDirection.top:
        dx += (targetSize.width - widget.width) / 2;
        dy -= widget.height;
        break;
      case PopupDirection.bottom:
        dx += (targetSize.width - widget.width) / 2;
        dy += targetSize.height;
        break;
      case PopupDirection.left:
        dx -= widget.width;
        dy += (targetSize.height - widget.height) / 2;
        break;
      case PopupDirection.right:
        dx += targetSize.width;
        dy += (targetSize.height - widget.height) / 2;
        break;
    }
    return Offset(dx, dy);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The trigger widget is wrapped with a GestureDetector to show the popup on long press.
    return GestureDetector(
      onLongPress: _showOverlay,
      child: widget.child,
    );
  }
}

/// This widget applies the desired animation to its child.
class AnimatedPopup extends StatefulWidget {
  final Widget child;
  final PopupAnimationType animationType;
  final PopupDirection direction;
  final Duration duration;
  final bool slideReverse;

  const AnimatedPopup({
    Key? key,
    required this.child,
    this.animationType = PopupAnimationType.fade,
    required this.direction,
    this.duration = const Duration(milliseconds: 300),
    this.slideReverse = false,
  }) : super(key: key);

  @override
  _AnimatedPopupState createState() => _AnimatedPopupState();
}

class _AnimatedPopupState extends State<AnimatedPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // Determine the slide animation's starting offset based on the popup's direction.
    Offset beginOffset;
    switch (widget.direction) {
      case PopupDirection.top:
        beginOffset = const Offset(0, -0.3);
        break;
      case PopupDirection.bottom:
        beginOffset = const Offset(0, 0.3);
        break;
      case PopupDirection.left:
        beginOffset = const Offset(-0.3, 0);
        break;
      case PopupDirection.right:
        beginOffset = const Offset(0.3, 0);
        break;
    }
    // If slideReverse is true, invert the offset.
    if (widget.slideReverse) {
      beginOffset = -beginOffset;
    }
    _slideAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.animationType) {
      case PopupAnimationType.none:
        return widget.child;
      case PopupAnimationType.fade:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: widget.child,
        );
      case PopupAnimationType.scale:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: widget.child,
        );
      case PopupAnimationType.slide:
        return SlideTransition(
          position: _slideAnimation,
          child: widget.child,
        );
    }
  }
}

/// The popup bubble with a customizable arrow.
class _PopupBubble extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius;
  final double arrowHeight;
  final double arrowWidth;
  final PopupDirection direction;
  final BoxShadow? boxShadow;
  final Widget child;

  const _PopupBubble({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    required this.borderRadius,
    required this.arrowHeight,
    required this.arrowWidth,
    required this.direction,
    required this.child,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter(
        color: color,
        borderRadius: borderRadius,
        arrowHeight: arrowHeight,
        arrowWidth: arrowWidth,
        direction: direction,
        boxShadow: boxShadow,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

/// Painter that draws the popup bubble and its arrow.
class _BubblePainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double arrowHeight;
  final double arrowWidth;
  final PopupDirection direction;
  final BoxShadow? boxShadow;

  _BubblePainter({
    required this.color,
    required this.borderRadius,
    required this.arrowHeight,
    required this.arrowWidth,
    required this.direction,
    this.boxShadow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    double radius = borderRadius;
    double arrowH = arrowHeight;
    double arrowW = arrowWidth;

    switch (direction) {
      case PopupDirection.bottom:
        // Popup appears below the widget → draw arrow on top (centered)
        path.moveTo(radius, arrowH);
        double arrowCenter = size.width / 2;
        path.lineTo(arrowCenter - arrowW / 2, arrowH);
        path.lineTo(arrowCenter, 0);
        path.lineTo(arrowCenter + arrowW / 2, arrowH);
        path.lineTo(size.width - radius, arrowH);
        path.quadraticBezierTo(size.width, arrowH, size.width, arrowH + radius);
        path.lineTo(size.width, size.height - radius);
        path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
        path.lineTo(radius, size.height);
        path.quadraticBezierTo(0, size.height, 0, size.height - radius);
        path.lineTo(0, arrowH + radius);
        path.quadraticBezierTo(0, arrowH, radius, arrowH);
        path.close();
        break;
      case PopupDirection.top:
        // Popup appears above the widget → draw arrow on bottom (centered)
        path.moveTo(radius, 0);
        path.lineTo(size.width - radius, 0);
        path.quadraticBezierTo(size.width, 0, size.width, radius);
        path.lineTo(size.width, size.height - arrowH - radius);
        path.quadraticBezierTo(size.width, size.height - arrowH, size.width - radius, size.height - arrowH);
        double arrowCenter = size.width / 2;
        path.lineTo(arrowCenter + arrowW / 2, size.height - arrowH);
        path.lineTo(arrowCenter, size.height);
        path.lineTo(arrowCenter - arrowW / 2, size.height - arrowH);
        path.lineTo(radius, size.height - arrowH);
        path.quadraticBezierTo(0, size.height - arrowH, 0, size.height - arrowH - radius);
        path.lineTo(0, radius);
        path.quadraticBezierTo(0, 0, radius, 0);
        path.close();
        break;
      case PopupDirection.left:
        // Popup appears to the left → draw arrow on right (centered vertically)
        path.moveTo(radius, 0);
        path.lineTo(size.width - arrowH - radius, 0);
        path.quadraticBezierTo(size.width - arrowH, 0, size.width - arrowH, radius);
        double arrowCenter = size.height / 2;
        path.lineTo(size.width - arrowH, arrowCenter - arrowW / 2);
        path.lineTo(size.width, arrowCenter);
        path.lineTo(size.width - arrowH, arrowCenter + arrowW / 2);
        path.lineTo(size.width - arrowH, size.height - radius);
        path.quadraticBezierTo(size.width - arrowH, size.height, size.width - arrowH - radius, size.height);
        path.lineTo(radius, size.height);
        path.quadraticBezierTo(0, size.height, 0, size.height - radius);
        path.lineTo(0, radius);
        path.quadraticBezierTo(0, 0, radius, 0);
        path.close();
        break;
      case PopupDirection.right:
        // Popup appears to the right → draw arrow on left (centered vertically)
        path.moveTo(arrowH + radius, 0);
        path.lineTo(size.width - radius, 0);
        path.quadraticBezierTo(size.width, 0, size.width, radius);
        path.lineTo(size.width, size.height - radius);
        path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
        path.lineTo(arrowH + radius, size.height);
        path.quadraticBezierTo(arrowH, size.height, arrowH, size.height - radius);
        double arrowCenter = size.height / 2;
        path.lineTo(arrowH, arrowCenter + arrowW / 2);
        path.lineTo(0, arrowCenter);
        path.lineTo(arrowH, arrowCenter - arrowW / 2);
        path.lineTo(arrowH, radius);
        path.quadraticBezierTo(arrowH, 0, arrowH + radius, 0);
        path.close();
        break;
    }

    if (boxShadow != null) {
      canvas.drawShadow(path, boxShadow!.color, boxShadow!.blurRadius, true);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// A custom clipper that returns a path for the full screen with a “hole” (cut-out)
/// corresponding to [holeRect]. Used when [excludeChildFromBlur] is true.
class _HoleClipper extends CustomClipper<Path> {
  final Rect holeRect;

  _HoleClipper({required this.holeRect});

  @override
  Path getClip(Size size) {
    final fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path()..addRect(fullRect);
    path.addRect(holeRect);
    return path..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(covariant _HoleClipper oldClipper) {
    return oldClipper.holeRect != holeRect;
  }
}
