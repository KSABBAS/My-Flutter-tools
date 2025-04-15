import 'package:flutter/material.dart';
import 'dart:ui';

class TMaker extends StatefulWidget {
  TMaker({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.textAlign,
    this.fontFamily,
    this.maxLines,
    this.overflow,
    this.textDirection,
    // Clickable functionality
    this.isClickable = false,
    this.onTap,
    // Hover effects
    this.hoverEffect = TextHoverEffect.none,
    this.hoverColor,
    this.hoverScale = 1.1,
    this.hoverDuration = const Duration(milliseconds: 200),
    // Gradient
    this.gradient,
    this.hoverGradient,
    // Blur effect
    this.blurEffect = false,
    this.blurRadius = 2.0,
    this.blurOnHover = false,
    // Other styling options
    this.letterSpacing,
    this.wordSpacing,
    this.shadows,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final String? fontFamily;
  
  // Clickable functionality
  final bool isClickable;
  final VoidCallback? onTap;
  
  // Hover effects
  final TextHoverEffect hoverEffect;
  final Color? hoverColor;
  final double hoverScale;
  final Duration hoverDuration;
  
  // Gradient
  final Gradient? gradient;
  final Gradient? hoverGradient;
  
  // Blur effect
  final bool blurEffect;
  final double blurRadius;
  final bool blurOnHover;
  
  // Other styling options
  final double? letterSpacing;
  final double? wordSpacing;
  final List<Shadow>? shadows;

  @override
  State<TMaker> createState() => _TMakerState();
}

class _TMakerState extends State<TMaker> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.hoverDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create base text style
    TextStyle textStyle = TextStyle(
      fontFamily: widget.fontFamily,
      fontSize: widget.fontSize,
      fontWeight: widget.fontWeight,
      color: _getTextColor(),
      letterSpacing: widget.letterSpacing,
      wordSpacing: widget.wordSpacing,
      shadows: widget.shadows,
    );

    // Create the text widget
    Widget textWidget;
    
    // Apply gradient if specified
    if (widget.gradient != null) {
      if (widget.hoverGradient != null) {
        // Animated gradient transition
        textWidget = AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return _getAnimatedGradient().createShader(bounds);
              },
              child: Text(
                widget.text,
                maxLines: widget.maxLines ?? 1,
                overflow: widget.overflow ?? TextOverflow.ellipsis,
                textDirection: widget.textDirection ?? TextDirection.ltr,
                textAlign: widget.textAlign ?? TextAlign.center,
                style: textStyle.copyWith(color: Colors.white),
              ),
            );
          },
        );
      } else {
        // Static gradient
        textWidget = ShaderMask(
          shaderCallback: (bounds) => widget.gradient!.createShader(bounds),
          child: Text(
            widget.text,
            maxLines: widget.maxLines ?? 1,
            overflow: widget.overflow ?? TextOverflow.ellipsis,
            textDirection: widget.textDirection ?? TextDirection.ltr,
            textAlign: widget.textAlign ?? TextAlign.center,
            style: textStyle.copyWith(color: Colors.white),
          ),
        );
      }
    } else {
      // No gradient
      textWidget = Text(
        widget.text,
        maxLines: widget.maxLines ?? 1,
        overflow: widget.overflow ?? TextOverflow.ellipsis,
        textDirection: widget.textDirection ?? TextDirection.ltr,
        textAlign: widget.textAlign ?? TextAlign.center,
        style: textStyle,
      );
    }

    // Apply blur effect if enabled
    if (widget.blurEffect || (widget.blurOnHover && _isHovered)) {
      textWidget = ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: widget.blurRadius,
          sigmaY: widget.blurRadius,
        ),
        child: textWidget,
      );
    }

    // Apply hover effects
    textWidget = _applyHoverEffects(textWidget);

    // Make clickable if specified
    if (widget.isClickable) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => _isHovered = true);
          _animationController.forward();
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          _animationController.reverse();
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: textWidget,
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: textWidget,
    );
  }

  // Helper method to create an animated gradient
  Gradient _getAnimatedGradient() {
    if (widget.gradient is LinearGradient && widget.hoverGradient is LinearGradient) {
      final LinearGradient normalGradient = widget.gradient as LinearGradient;
      final LinearGradient hoverGradient = widget.hoverGradient as LinearGradient;
      
      // Interpolate between the two gradients
      List<Color> animatedColors = [];
      for (int i = 0; i < normalGradient.colors.length; i++) {
        if (i < hoverGradient.colors.length) {
          animatedColors.add(Color.lerp(
            normalGradient.colors[i],
            hoverGradient.colors[i],
            _animation.value,
          )!);
        } else {
          animatedColors.add(normalGradient.colors[i]);
        }
      }
      
      // Cast AlignmentGeometry to Alignment if possible, or use default values
      final Alignment beginNormal = normalGradient.begin is Alignment ? normalGradient.begin as Alignment : Alignment.centerLeft;
      final Alignment endNormal = normalGradient.end is Alignment ? normalGradient.end as Alignment : Alignment.centerRight;
      final Alignment beginHover = hoverGradient.begin is Alignment ? hoverGradient.begin as Alignment : Alignment.centerLeft;
      final Alignment endHover = hoverGradient.end is Alignment ? hoverGradient.end as Alignment : Alignment.centerRight;
      
      return LinearGradient(
        begin: Alignment.lerp(beginNormal, beginHover, _animation.value)!,
        end: Alignment.lerp(endNormal, endHover, _animation.value)!,
        colors: animatedColors,
        stops: normalGradient.stops,
        tileMode: normalGradient.tileMode,
        transform: normalGradient.transform,
      );
    }
    
    // Fallback to normal gradient if types don't match
    return widget.gradient!;
  }

  // Helper method to apply hover effects
  Widget _applyHoverEffects(Widget textWidget) {
    switch (widget.hoverEffect) {
      case TextHoverEffect.color:
        // Color change is handled in _getTextColor()
        return textWidget;
        
      case TextHoverEffect.scale:
        return AnimatedScale(
          scale: _isHovered ? widget.hoverScale : 1.0,
          duration: widget.hoverDuration,
          child: textWidget,
        );
        
      case TextHoverEffect.none:
      default:
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: textWidget,
        );
    }
  }

  // Helper method to get text color based on hover state
  Color _getTextColor() {
    if (widget.gradient != null) return Colors.white;
    
    if (_isHovered && widget.hoverEffect == TextHoverEffect.color && widget.hoverColor != null) {
      return widget.hoverColor!;
    }
    
    return widget.color;
  }
}

// Hover effect types
enum TextHoverEffect {
  none,
  color,
  scale,
  gradient,
}
