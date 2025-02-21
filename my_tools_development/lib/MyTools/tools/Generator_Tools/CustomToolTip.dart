import 'dart:async';
import 'package:flutter/material.dart';

/// Extended enum to control the tooltip’s placement relative to the child.
enum TooltipPositionExtended {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
  leftTop,
  leftCenter,
  leftBottom,
  rightTop,
  rightCenter,
  rightBottom,
}

class MyTooltip extends StatefulWidget {
  /// The widget that triggers the tooltip.
  final Widget child;

  /// The content to display inside the tooltip.
  final Widget tooltipContent;

  /// Determines the base placement of the tooltip relative to the child.
  final TooltipPositionExtended tooltipPosition;

  /// Base gap between the child and the tooltip.
  final double tooltipDistance;

  /// Additional offset for fine-tuning the tooltip’s position.
  final Offset additionalOffset;

  /// The width of the tooltip window.
  final double tooltipWidth;

  /// The height of the tooltip window.
  final double tooltipHeight;

  /// Decoration for the tooltip window.
  final BoxDecoration tooltipDecoration;

  /// Padding inside the tooltip window.
  final EdgeInsets tooltipPadding;

  /// Duration after which the tooltip appears when long pressed.
  final Duration longPressDelay;

  /// Duration of the fade in/out animation.
  final Duration animationDuration;

  /// Duration after which the tooltip will automatically hide.
  /// If set to Duration.zero, the tooltip stays visible until the user stops hovering or long pressing.
  final Duration autoHideDelay;

  /// Whether to show the tooltip on mouse hover.
  final bool showOnHover;

  /// Whether to show the tooltip on long press.
  final bool showOnLongPress;

  const MyTooltip({
    Key? key,
    required this.child,
    required this.tooltipContent,
    this.tooltipPosition = TooltipPositionExtended.bottomCenter,
    this.tooltipDistance = 8.0,
    this.additionalOffset = Offset.zero,
    this.tooltipWidth = 200.0,
    this.tooltipHeight = 100.0,
    this.tooltipDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
      ],
    ),
    this.tooltipPadding = const EdgeInsets.all(8.0),
    this.longPressDelay = const Duration(seconds: 1),
    this.animationDuration = const Duration(milliseconds: 300),
    // Set autoHideDelay to 3 seconds by default; set to Duration.zero to disable auto-hide.
    this.autoHideDelay = const Duration(seconds: 3),
    this.showOnHover = true,
    this.showOnLongPress = true,
  }) : super(key: key);

  @override
  _MyTooltipState createState() => _MyTooltipState();
}

class _MyTooltipState extends State<MyTooltip>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _hoverTimer;
  Timer? _longPressTimer;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _showTooltip() {
    _removeTooltip();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry!);
    _controller.forward();

    // Schedule auto-hide if autoHideDelay is not Duration.zero.
    if (widget.autoHideDelay.inMilliseconds > 0) {
      _hideTimer?.cancel();
      _hideTimer = Timer(widget.autoHideDelay, _hideTooltip);
    }
  }

  void _hideTooltip() {
    _hoverTimer?.cancel();
    _longPressTimer?.cancel();
    _hideTimer?.cancel();
    _controller.reverse().then((_) => _removeTooltip());
  }

  OverlayEntry _createOverlayEntry() {
    // Get child's global position and size.
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size childSize = renderBox.size;
    Offset childOffset = renderBox.localToGlobal(Offset.zero);

    Offset tooltipPos = _calculateTooltipPosition(childOffset, childSize);
    return OverlayEntry(
      builder: (context) => Positioned(
        left: tooltipPos.dx,
        top: tooltipPos.dy,
        width: widget.tooltipWidth,
        height: widget.tooltipHeight,
        child: Material(
          color: Colors.transparent,
          child: FadeTransition(
            opacity: _animation,
            child: Container(
              padding: widget.tooltipPadding,
              decoration: widget.tooltipDecoration,
              child: widget.tooltipContent,
            ),
          ),
        ),
      ),
    );
  }

  Offset _calculateTooltipPosition(Offset childOffset, Size childSize) {
    double left = 0, top = 0;
    switch (widget.tooltipPosition) {
      case TooltipPositionExtended.topLeft:
        left = childOffset.dx;
        top = childOffset.dy - widget.tooltipDistance - widget.tooltipHeight;
        break;
      case TooltipPositionExtended.topCenter:
        left = childOffset.dx + (childSize.width - widget.tooltipWidth) / 2;
        top = childOffset.dy - widget.tooltipDistance - widget.tooltipHeight;
        break;
      case TooltipPositionExtended.topRight:
        left = childOffset.dx + childSize.width - widget.tooltipWidth;
        top = childOffset.dy - widget.tooltipDistance - widget.tooltipHeight;
        break;
      case TooltipPositionExtended.bottomLeft:
        left = childOffset.dx;
        top = childOffset.dy + childSize.height + widget.tooltipDistance;
        break;
      case TooltipPositionExtended.bottomCenter:
        left = childOffset.dx + (childSize.width - widget.tooltipWidth) / 2;
        top = childOffset.dy + childSize.height + widget.tooltipDistance;
        break;
      case TooltipPositionExtended.bottomRight:
        left = childOffset.dx + childSize.width - widget.tooltipWidth;
        top = childOffset.dy + childSize.height + widget.tooltipDistance;
        break;
      case TooltipPositionExtended.leftTop:
        left = childOffset.dx - widget.tooltipDistance - widget.tooltipWidth;
        top = childOffset.dy;
        break;
      case TooltipPositionExtended.leftCenter:
        left = childOffset.dx - widget.tooltipDistance - widget.tooltipWidth;
        top = childOffset.dy + (childSize.height - widget.tooltipHeight) / 2;
        break;
      case TooltipPositionExtended.leftBottom:
        left = childOffset.dx - widget.tooltipDistance - widget.tooltipWidth;
        top = childOffset.dy + childSize.height - widget.tooltipHeight;
        break;
      case TooltipPositionExtended.rightTop:
        left = childOffset.dx + childSize.width + widget.tooltipDistance;
        top = childOffset.dy;
        break;
      case TooltipPositionExtended.rightCenter:
        left = childOffset.dx + childSize.width + widget.tooltipDistance;
        top = childOffset.dy + (childSize.height - widget.tooltipHeight) / 2;
        break;
      case TooltipPositionExtended.rightBottom:
        left = childOffset.dx + childSize.width + widget.tooltipDistance;
        top = childOffset.dy + childSize.height - widget.tooltipHeight;
        break;
    }
    return Offset(left + widget.additionalOffset.dx, top + widget.additionalOffset.dy);
  }

  void _removeTooltip() {
    _hoverTimer?.cancel();
    _longPressTimer?.cancel();
    _hideTimer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
    _controller.reset();
  }

  @override
  void dispose() {
    _hoverTimer?.cancel();
    _longPressTimer?.cancel();
    _hideTimer?.cancel();
    _removeTooltip();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = widget.child;
    if (widget.showOnHover) {
      result = MouseRegion(
        onEnter: (_) {
          _hoverTimer?.cancel();
          _hoverTimer = Timer(widget.longPressDelay, _showTooltip);
        },
        onExit: (_) => _hideTooltip(),
        child: result,
      );
    }
    if (widget.showOnLongPress) {
      result = GestureDetector(
        onLongPressStart: (_) {
          _longPressTimer?.cancel();
          _longPressTimer = Timer(widget.longPressDelay, _showTooltip);
        },
        onLongPressEnd: (_) => _hideTooltip(),
        child: result,
      );
    }
    return result;
  }
}
