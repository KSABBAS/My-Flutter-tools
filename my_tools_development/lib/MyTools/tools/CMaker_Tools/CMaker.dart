import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// A highly customizable container widget with advanced styling, animations, and interactive features.  
/// This widget extends the functionality of a standard Container with additional features like hover effects,
/// animations, glassmorphism, neumorphism, and more.
class CMaker extends StatefulWidget {
  CMaker({
    super.key,
    this.child,
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
    // Animation features
    this.animationDuration,
    this.animationCurve,
    this.animateOnInit = false,
    this.initialScale,
    this.finalScale,
    this.initialOpacity,
    this.finalOpacity,
    this.initialOffset,
    this.finalOffset,
    this.animationType = AnimationType.none,
    // Enhanced animation control properties
    this.animationRepeatCount,
    this.animationReverse,
    // Rotation animation controls
    this.rotationAngle,
    this.rotationEndAngle,
    this.rotationCMakerAxis,
    // Scale animation controls
    this.scaleMin,
    this.scaleMax,
    // Slide animation controls
    this.slideDirection,
    this.slideDistance,
    // Flip animation controls
    this.startFlipped,
    this.flipAxis,
    // Shimmer animation controls
    this.showChildDuringShimmer,
    this.shimmerRepeatCount,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.shimmerSpeed,
    // Interactive features
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.enableHover = false,
    this.hoverColor,
    this.hoverElevation,
    this.hoverScale,
    this.hoverBorderColor,
    this.hoverGradient,
    // Advanced styling
    this.blurRadius,
    this.blurColor,
    this.isGlassmorphic = false,
    this.glassmorphicBorderWidth,
    this.glassmorphicBorderRadius,
    this.glassmorphicOpacity,
    this.isNeumorphic = false,
    this.neumorphicLightSource = NeumorphicLightSource.topLeft,
    this.neumorphicDepth,
    this.neumorphicIntensity,
    this.neumorphicCurve,
    // Custom shape
    this.customBorderRadius,
    this.customShape,
    this.customClipper,
    // Responsive features
    this.maxWidth,
    this.minWidth,
    this.maxHeight,
    this.minHeight,
    this.aspectRatio,
    // Overlay features
    this.overlayColor,
    this.overlayGradient,
    this.overlayOpacity,
    this.overlayBlendMode,
    // Shadow features
    this.shadowColor,
    this.elevation,
    this.shadowOffset,
    this.shadowBlurRadius,
    this.shadowSpreadRadius,
  });

  // Basic properties
  Color? color;
  double? height;
  double? width;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  DecorationImage? BackGroundimage;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
  Matrix4? transform;
  BoxBorder? border;
  double? circularRadius;
  Clip? clipBehavior;
  BoxShape? shape;
  Widget? child;

  // Animation properties
  Duration? animationDuration;
  Curve? animationCurve;
  bool animateOnInit;
  double? initialScale;
  double? finalScale;
  double? initialOpacity;
  double? finalOpacity;
  Offset? initialOffset;
  Offset? finalOffset;
  AnimationType animationType;
  
  // Enhanced animation control properties
  int? animationRepeatCount; // Number of times to repeat the animation
  bool? animationReverse; // Whether to reverse the animation
  
  // Rotation animation controls
  double? rotationAngle; // Initial angle for rotation in radians
  double? rotationEndAngle; // Final angle for rotation in radians
  CMakerAxis? rotationCMakerAxis; // CMakerAxis of rotation (X, Y, Z)
  
  // Scale animation controls
  double? scaleMin; // Minimum scale factor
  double? scaleMax; // Maximum scale factor
  
  // Slide animation controls
  SlideDirection? slideDirection; // Direction for slide animation
  double? slideDistance; // Distance to slide (as a factor of widget size)
  
  // Flip animation controls
  bool? startFlipped; // Whether to start flipped (for flip animation)
  CMakerAxis? flipAxis; // CMakerAxis to flip around (X or Y)
  
  // Shimmer animation controls
  bool? showChildDuringShimmer; // Whether to show child during shimmer animation
  int? shimmerRepeatCount; // Number of times to repeat shimmer animation
  Color? shimmerBaseColor; // Base color for shimmer effect
  Color? shimmerHighlightColor; // Highlight color for shimmer effect
  double? shimmerSpeed; // Speed multiplier for shimmer animation

  // Interactive properties
  VoidCallback? onTap;
  VoidCallback? onDoubleTap;
  VoidCallback? onLongPress;
  bool enableHover;
  Color? hoverColor;
  double? hoverElevation;
  double? hoverScale;
  Color? hoverBorderColor;
  Gradient? hoverGradient;

  // Advanced styling properties
  double? blurRadius;
  Color? blurColor;
  bool isGlassmorphic;
  double? glassmorphicBorderWidth;
  double? glassmorphicBorderRadius;
  double? glassmorphicOpacity;
  bool isNeumorphic;
  NeumorphicLightSource neumorphicLightSource;
  double? neumorphicDepth;
  double? neumorphicIntensity;
  double? neumorphicCurve;

  // Custom shape properties
  BorderRadiusGeometry? customBorderRadius;
  ShapeBorder? customShape;
  CustomClipper<Path>? customClipper;

  // Responsive properties
  double? maxWidth;
  double? minWidth;
  double? maxHeight;
  double? minHeight;
  double? aspectRatio;

  // Overlay properties
  Color? overlayColor;
  Gradient? overlayGradient;
  double? overlayOpacity;
  BlendMode? overlayBlendMode;

  // Shadow properties
  Color? shadowColor;
  double? elevation;
  Offset? shadowOffset;
  double? shadowBlurRadius;
  double? shadowSpreadRadius;
  @override
  State<CMaker> createState() => _CMakerState();
}

/// Enum to define the type of animation to apply to the container
enum AnimationType {
  none,
  fade,
  scale,
  slide,
  rotate,
  // bounce removed as requested
  shimmer,
  flip,
}

/// Enum to define the direction for slide animation
enum SlideDirection {
  fromTop,
  fromBottom,
  fromLeft,
  fromRight,
  custom, // Uses the custom initialOffset and finalOffset values
}

/// Enum to define the CMakerAxis for rotation and flip animations
enum CMakerAxis {
  x,
  y,
  z,
}

/// Enum to define the light source direction for neumorphic effect
enum NeumorphicLightSource {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  top,
  bottom,
  left,
  right,
}

class _CMakerState extends State<CMaker> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotateAnimation;
  // Remove the bounce animation reference
  int _animationRepeatCount = 0;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller with proper duration
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(milliseconds: 300),
    );
    
    // Initialize animations with enhanced controls
    _scaleAnimation = Tween<double>(
      begin: widget.scaleMin ?? widget.initialScale ?? 0.8,
      end: widget.scaleMax ?? widget.finalScale ?? 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve ?? Curves.easeOut,
    ));
    
    _opacityAnimation = Tween<double>(
      begin: widget.initialOpacity ?? 0.0,
      end: widget.finalOpacity ?? 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve ?? Curves.easeOut,
    ));
    
    // Enhanced slide animation with directional control
    Offset initialSlideOffset;
    Offset finalSlideOffset = widget.finalOffset ?? Offset.zero;
    double slideDistance = widget.slideDistance ?? 1.0;
    
    if (widget.slideDirection != null && widget.slideDirection != SlideDirection.custom) {
      switch (widget.slideDirection) {
        case SlideDirection.fromTop:
          initialSlideOffset = Offset(0.0, -slideDistance);
          break;
        case SlideDirection.fromBottom:
          initialSlideOffset = Offset(0.0, slideDistance);
          break;
        case SlideDirection.fromLeft:
          initialSlideOffset = Offset(-slideDistance, 0.0);
          break;
        case SlideDirection.fromRight:
          initialSlideOffset = Offset(slideDistance, 0.0);
          break;
        default:
          initialSlideOffset = widget.initialOffset ?? Offset(0.0, slideDistance * 0.2);
      }
    } else {
      initialSlideOffset = widget.initialOffset ?? Offset(0.0, slideDistance * 0.2);
    }
    
    _slideAnimation = Tween<Offset>(
      begin: initialSlideOffset,
      end: finalSlideOffset,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve ?? Curves.easeOut,
    ));
    
    // Enhanced rotation animation with proper angle control
    _rotateAnimation = Tween<double>(
      begin: widget.rotationAngle ?? 0.0,
      end: widget.rotationEndAngle ?? (2 * 3.14159), // Default to 360 degrees in radians
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve ?? Curves.easeOut,
    ));
    
    // Configure animation controller for repetition and reversal
    if (widget.animationRepeatCount != null && widget.animationRepeatCount! > 0) {
      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (widget.animationReverse == true) {
            _animationController.reverse();
          } else if (_animationRepeatCount < (widget.animationRepeatCount! - 1)) {
            _animationRepeatCount++;
            _animationController.reset();
            _animationController.forward();
          }
        } else if (status == AnimationStatus.dismissed && widget.animationReverse == true) {
          if (_animationRepeatCount < (widget.animationRepeatCount! - 1)) {
            _animationRepeatCount++;
            _animationController.forward();
          }
        }
      });
    }
    
    // Start animation if animateOnInit is true with proper flip handling
    if (widget.animateOnInit) {
      if (widget.animationType == AnimationType.flip && widget.startFlipped == true) {
        _animationController.value = 1.0; // Start at the end (flipped)
        _animationController.reverse(); // Animate back to normal
      } else {
        _animationController.forward();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Helper method to create glassmorphic effect
  BoxDecoration _createGlassmorphicDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(widget.glassmorphicOpacity ?? 0.1),
      borderRadius: BorderRadius.circular(widget.glassmorphicBorderRadius ?? 15),
      border: Border.all(
        color: Colors.white.withOpacity(0.2),
        width: widget.glassmorphicBorderWidth ?? 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    );
  }

  // Helper method to create neumorphic effect
  List<BoxShadow> _createNeumorphicShadows() {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color baseColor = widget.color ?? Theme.of(context).colorScheme.surface;
    
    // Calculate light and dark shadow colors based on the base color
    final Color lightShadowColor = isDarkMode
        ? Color.lerp(baseColor, Colors.white, widget.neumorphicIntensity ?? 0.1)!
        : Color.lerp(baseColor, Colors.white, widget.neumorphicIntensity ?? 0.7)!;
    
    final Color darkShadowColor = isDarkMode
        ? Color.lerp(baseColor, Colors.black, widget.neumorphicIntensity ?? 0.7)!
        : Color.lerp(baseColor, Colors.black, widget.neumorphicIntensity ?? 0.15)!;
    
    // Calculate shadow offsets based on light source
    final double depth = widget.neumorphicDepth ?? 5.0;
    Offset lightOffset;
    Offset darkOffset;
    
    switch (widget.neumorphicLightSource) {
      case NeumorphicLightSource.topLeft:
        lightOffset = Offset(-depth, -depth);
        darkOffset = Offset(depth, depth);
        break;
      case NeumorphicLightSource.topRight:
        lightOffset = Offset(depth, -depth);
        darkOffset = Offset(-depth, depth);
        break;
      case NeumorphicLightSource.bottomLeft:
        lightOffset = Offset(-depth, depth);
        darkOffset = Offset(depth, -depth);
        break;
      case NeumorphicLightSource.bottomRight:
        lightOffset = Offset(depth, depth);
        darkOffset = Offset(-depth, -depth);
        break;
      case NeumorphicLightSource.top:
        lightOffset = Offset(0, -depth);
        darkOffset = Offset(0, depth);
        break;
      case NeumorphicLightSource.bottom:
        lightOffset = Offset(0, depth);
        darkOffset = Offset(0, -depth);
        break;
      case NeumorphicLightSource.left:
        lightOffset = Offset(-depth, 0);
        darkOffset = Offset(depth, 0);
        break;
      case NeumorphicLightSource.right:
        lightOffset = Offset(depth, 0);
        darkOffset = Offset(-depth, 0);
        break;
    }
    
    return [
      BoxShadow(
        color: lightShadowColor,
        offset: lightOffset,
        blurRadius: widget.neumorphicCurve ?? 10.0,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: darkShadowColor,
        offset: darkOffset,
        blurRadius: widget.neumorphicCurve ?? 10.0,
        spreadRadius: 0,
      ),
    ];
  }

  // Helper method to create blur effect
  Widget _applyBlurEffect(Widget child) {
    return ClipRRect(
      borderRadius: widget.customBorderRadius ??
          BorderRadius.circular(widget.circularRadius ?? 0),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: widget.blurRadius ?? 10.0,
          sigmaY: widget.blurRadius ?? 10.0,
        ),
        child: child,
      ),
    );
  }

  // Helper method to apply animation with enhanced controls
  Widget _applyAnimation(Widget child) {
    switch (widget.animationType) {
      case AnimationType.fade:
        return FadeTransition(
          opacity: _opacityAnimation,
          child: child,
        );
        
      case AnimationType.scale:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: child,
        );
        
      case AnimationType.slide:
        return SlideTransition(
          position: _slideAnimation,
          child: child,
        );
        
      case AnimationType.rotate:
        return AnimatedBuilder(
          animation: _rotateAnimation,
          builder: (context, child) {
            // Apply rotation based on the specified CMakerAxis
            final Matrix4 rotationMatrix = Matrix4.identity();
            switch (widget.rotationCMakerAxis) {
              case CMakerAxis.x:
                rotationMatrix.rotateX(_rotateAnimation.value);
                break;
              case CMakerAxis.z:
                rotationMatrix.rotateZ(_rotateAnimation.value);
                break;
              case CMakerAxis.y:
              default:
                rotationMatrix.rotateY(_rotateAnimation.value);
                break;
            }
            
            return Transform(
              alignment: Alignment.center,
              transform: rotationMatrix,
              child: child,
            );
          },
          child: child,
        );
        
      // Remove the bounce case and replace with a comment
      // case AnimationType.bounce: - removed as requested
        
      case AnimationType.shimmer:
        return ShimmerEffect(
          child: child,
          baseColor: widget.shimmerBaseColor ?? widget.color ?? Colors.grey[300]!,
          highlightColor: widget.shimmerHighlightColor ?? widget.hoverColor ?? Colors.grey[100]!,
          duration: Duration(milliseconds: 
            (widget.animationDuration?.inMilliseconds ?? 1500) ~/ (widget.shimmerSpeed ?? 1.0)),
          repeatCount: widget.shimmerRepeatCount,
          showChild: widget.showChildDuringShimmer ?? false,
        );
        
      case AnimationType.flip:
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            // Fixed flip animation with proper start flipped behavior
            final bool showFront = (_animationController.value <= 0.5) != (widget.startFlipped == true);
            final double rotationValue = widget.startFlipped == true ? 
                (1.0 - _animationController.value) * 3.14159 : 
                _animationController.value * 3.14159;
            
            final Matrix4 flipMatrix = Matrix4.identity()..setEntry(3, 2, 0.001);
            
            // Apply rotation based on the specified flip CMakerAxis
            switch (widget.flipAxis) {
              case CMakerAxis.x:
                flipMatrix.rotateX(rotationValue);
                break;
              case CMakerAxis.y:
              default:
                flipMatrix.rotateY(rotationValue);
                break;
            }
            
            // Fixed transform for back side
            return Transform(
              alignment: Alignment.center,
              transform: flipMatrix,
              child: showFront ? child : Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(3.14159),
                child: child,
              ),
            );
          },
          child: child,
        );
        
      case AnimationType.none:
      default:
        return child;
    }
  }

  // Helper method to create overlay
  Widget _applyOverlay(Widget child) {
    if (widget.overlayColor == null && widget.overlayGradient == null) {
      return child;
    }
    
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: ClipRRect(
            borderRadius: widget.customBorderRadius ??
                BorderRadius.circular(widget.circularRadius ?? 0),
            child: Opacity(
              opacity: widget.overlayOpacity ?? 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.overlayColor,
                  gradient: widget.overlayGradient,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Create base decoration
    BoxDecoration decoration;
    
    if (widget.isGlassmorphic) {
      decoration = _createGlassmorphicDecoration();
    } else if (widget.isNeumorphic) {
      decoration = BoxDecoration(
        color: widget.color ?? Theme.of(context).colorScheme.surface,
        borderRadius: widget.customBorderRadius ??
            BorderRadius.circular(widget.circularRadius ?? 15),
        boxShadow: _createNeumorphicShadows(),
      );
    } else {
      // Standard decoration with hover effects
      decoration = BoxDecoration(
        shape: widget.shape ?? BoxShape.rectangle,
        gradient: _isHovered && widget.hoverGradient != null
            ? widget.hoverGradient
            : widget.gradient,
        image: widget.BackGroundimage,
        border: _isHovered && widget.hoverBorderColor != null
            ? Border.all(color: widget.hoverBorderColor!)
            : widget.border,
        color: _isHovered && widget.hoverColor != null
            ? widget.hoverColor
            : widget.color,
        boxShadow: _isHovered && widget.hoverElevation != null
            ? [
                BoxShadow(
                  color: widget.shadowColor ?? Colors.black.withOpacity(0.2),
                  blurRadius: widget.shadowBlurRadius ?? widget.hoverElevation! * 2,
                  spreadRadius: widget.shadowSpreadRadius ?? widget.hoverElevation! / 2,
                  offset: widget.shadowOffset ?? Offset(0, widget.hoverElevation! / 2),
                )
              ]
            : widget.elevation != null
                ? [
                    BoxShadow(
                      color: widget.shadowColor ?? Colors.black.withOpacity(0.2),
                      blurRadius: widget.shadowBlurRadius ?? widget.elevation! * 2,
                      spreadRadius: widget.shadowSpreadRadius ?? widget.elevation! / 2,
                      offset: widget.shadowOffset ?? Offset(0, widget.elevation! / 2),
                    )
                  ]
                : widget.boxShadow,
        borderRadius: widget.customBorderRadius ??
            BorderRadius.circular(widget.circularRadius ?? 0),
      );
    }

    // Create base container
    Widget container = Container(
      clipBehavior: widget.clipBehavior ?? Clip.none,
      transform: widget.transform,
      alignment: widget.alignment,
      padding: widget.padding,
      margin: widget.margin,
      decoration: decoration,
      height: widget.height,
      width: widget.width,
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth ?? double.infinity,
        minWidth: widget.minWidth ?? 0,
        maxHeight: widget.maxHeight ?? double.infinity,
        minHeight: widget.minHeight ?? 0,
      ),
      child: widget.aspectRatio != null
          ? AspectRatio(
              aspectRatio: widget.aspectRatio!,
              child: widget.child,
            )
          : widget.child,
    );

    // Apply custom clipper if provided
    if (widget.customClipper != null) {
      container = ClipPath(
        clipper: widget.customClipper,
        child: container,
      );
    }

    // Apply custom shape if provided
    if (widget.customShape != null) {
      container = ClipPath(
        clipper: ShapeBorderClipper(shape: widget.customShape!),
        child: container,
      );
    }

    // Apply blur effect if needed
    if (widget.blurRadius != null) {
      container = _applyBlurEffect(container);
    }

    // Apply overlay if needed
    container = _applyOverlay(container);

    // Apply animation if needed
    if (widget.animationType != AnimationType.none) {
      container = _applyAnimation(container);
    }

    // Apply hover effect if enabled
    if (widget.enableHover) {
      container = MouseRegion(
        onEnter: (_) => setState(() {
          _isHovered = true;
          // Remove reference to bounce animation
          if (widget.animationType != AnimationType.none) {
            _animationController.reset();
            _animationController.forward();
          }
        }),
        onExit: (_) => setState(() {
          _isHovered = false;
        }),
        child: _isHovered && widget.hoverScale != null
            ? Transform.scale(
                scale: widget.hoverScale!,
                child: container,
              )
            : container,
      );
    }

    // Apply gesture detection if needed
    if (widget.onTap != null || widget.onDoubleTap != null || widget.onLongPress != null) {
      container = GestureDetector(
        onTap: widget.onTap,
        onDoubleTap: widget.onDoubleTap,
        onLongPress: widget.onLongPress,
        child: container,
      );
    }

    return container;
  }
}

/// A widget that creates a shimmer effect over its child
class ShimmerEffect extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final int? repeatCount; // Number of times to repeat the shimmer effect
  final bool showChild; // Whether to show the child during shimmer effect

  const ShimmerEffect({
    Key? key,
    required this.child,
    required this.baseColor,
    required this.highlightColor,
    required this.duration,
    this.repeatCount,
    this.showChild = false,
  }) : super(key: key);

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

// Fix the ShimmerEffect class to properly contain the shimmer within the widget bounds
class _ShimmerEffectState extends State<ShimmerEffect> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  int _shimmerRepeatCount = 0;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this);
    
    // Configure shimmer animation with proper repeat control
    _shimmerController.repeat(min: -0.5, max: 1.5, period: widget.duration);
    
    if (widget.repeatCount != null && widget.repeatCount! > 0) {
      _shimmerController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _shimmerRepeatCount++;
          if (_shimmerRepeatCount >= widget.repeatCount!) {
            _shimmerController.stop();
            // If we want to show the child after shimmer completes
            if (!widget.showChild) {
              setState(() {});
            }
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough, // Ensure stack takes the size of its children
      children: <Widget>[
        // Only show child if showChild is true or shimmer has completed
        if (widget.showChild || 
            (widget.repeatCount != null && 
             _shimmerRepeatCount >= widget.repeatCount!)) 
          widget.child,
        
        // Only show shimmer if not completed
        if (!(widget.repeatCount != null && 
              _shimmerRepeatCount >= widget.repeatCount!))
          Positioned.fill(
            child: ClipRect(
              child: AnimatedBuilder(
                animation: _shimmerController,
                builder: (context, child) {
                  return ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) {
                      return ui.Gradient.linear(
                        Offset(bounds.width * _shimmerController.value, 0.0),
                        Offset(bounds.width * (_shimmerController.value + 0.5), 0.0),
                        [
                          widget.baseColor,
                          widget.highlightColor,
                          widget.baseColor,
                        ],
                        [0.0, 0.5, 1.0],
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
