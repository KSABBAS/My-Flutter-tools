import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';

/// A highly customizable button widget with various hover effects, animations, and states.
///
/// This button provides extensive customization options while maintaining a simple API
/// for basic usage scenarios.
class MyButton extends StatefulWidget {
  /// Creates a customizable button with various styling and interaction options.
  ///
  /// The [text] parameter is required to display button text.
  MyButton({
    super.key,
    required this.text,
    this.textFont,
    this.textFontWeight,
    this.textColor,
    this.buttonColor,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonCircularRadius,
    this.addShadow,
    this.border,
    this.gradient,
    this.margin,
    this.padding,
    this.onTap,
    this.onDoubleTap,
    this.onHover,
    this.onLongPress,
    this.textFontFamily,
    // New parameters
    this.hoverEffect = HoverEffect.scale,
    this.hoverColor,
    this.hoverScale = 1.05,
    this.hoverElevation = 5.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.splashColor,
    this.highlightColor,
    this.rippleEffect = true,
    this.disabled = false,
    this.disabledColor,
    this.disabledTextColor,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.iconSpacing = 8.0,
    this.loading = false,
    this.loadingWidget,
    this.loadingSize = 20.0,
    this.loadingColor,
    this.tooltipMessage,
    // Removed tooltipPosition parameter
    this.shimmerDirection = ShimmerDirection.leftToRight,
    this.shimmerWidth = 0.5,
    this.shimmerOpacity = 0.3,
    this.shimmerDuration = const Duration(milliseconds: 1500),
    this.glowColor,
    this.glowRadius = 12.0,
    this.glowSpread = 2.0,
    this.glowOpacity = 0.6,
    this.pulseMinScale = 1.0,
    this.pulseMaxScale = 1.05,
    this.pulseDuration = const Duration(milliseconds: 1000),
  });

  /// The text to display on the button.
  /// This is the primary content of the button.
  final String text;

  /// Callback function triggered when the button is tapped.
  /// Use this for the primary action of the button.
  final void Function()? onTap;

  /// Callback function triggered when the button is double-tapped.
  /// Useful for secondary actions or confirmations.
  final void Function()? onDoubleTap;

  /// Callback function triggered when the mouse enters or exits the button area.
  /// The boolean parameter indicates whether the mouse is hovering (true) or not (false).
  /// Use this to trigger external UI changes based on hover state.
  final void Function(bool)? onHover;

  /// Callback function triggered when the button is pressed and held.
  /// Useful for actions that should be triggered after a deliberate interaction.
  final void Function()? onLongPress;

  /// The font size of the button text.
  /// Default is 20.
  final double? textFont;

  /// The height of the button.
  /// Default is 50.
  final double? buttonHeight;

  /// The width of the button.
  /// Default is 90.
  final double? buttonWidth;

  /// The corner radius of the button.
  /// Higher values create more rounded corners. Default is 10.
  final double? buttonCircularRadius;

  /// The font weight of the button text.
  /// Controls how bold or light the text appears. Default is FontWeight.w500.
  final FontWeight? textFontWeight;

  /// The color of the button text.
  /// Default is white.
  final Color? textColor;

  /// The background color of the button.
  /// Default is amber. Ignored if [gradient] is provided.
  final Color? buttonColor;

  /// Whether to add a shadow to the button.
  /// Creates a subtle elevation effect. Default is false.
  final bool? addShadow;

  /// The internal padding of the button.
  /// Controls the space between the button content and its edges.
  final EdgeInsetsGeometry? padding;

  /// The external margin around the button.
  /// Controls the space between the button and surrounding elements.
  final EdgeInsetsGeometry? margin;

  /// A gradient to apply to the button background.
  /// Takes precedence over [buttonColor] when provided.
  final Gradient? gradient;

  /// The border to draw around the button.
  /// Useful for outlined button styles.
  final BoxBorder? border;

  /// The font family for the button text.
  /// Use this to match your app's typography.
  final String? textFontFamily;

  /// The type of visual effect to apply when hovering.
  /// Options include scale, elevation, color, border, glow, or none.
  /// Default is scale.
  final HoverEffect hoverEffect;

  /// The color to use for hover effects.
  /// Used differently depending on the [hoverEffect] selected.
  /// For color effect: becomes the button background color on hover.
  /// For glow effect: used as the glow color.
  /// For border effect: used as the border color.
  final Color? hoverColor;

  /// The scale factor to apply when using the scale hover effect.
  /// Values > 1.0 make the button larger on hover. Default is 1.05.
  final double hoverScale;

  /// The elevation to apply when using the elevation hover effect.
  /// Higher values create more pronounced shadows. Default is 5.0.
  final double hoverElevation;

  /// The duration of hover and state transition animations.
  /// Shorter durations create snappier animations. Default is 200ms.
  final Duration animationDuration;

  /// The curve to use for hover and state transition animations.
  /// Controls the acceleration/deceleration of animations. Default is easeInOut.
  final Curve animationCurve;

  /// The color of the splash effect when the button is tapped.
  /// Only visible when [rippleEffect] is true. Default is semi-transparent white.
  final Color? splashColor;

  /// The color that appears when the button is pressed.
  /// Only visible when [rippleEffect] is true. Default is semi-transparent white.
  final Color? highlightColor;

  /// Whether to show a ripple effect when the button is tapped.
  /// Creates a Material Design-style ink splash. Default is true.
  final bool rippleEffect;

  /// Whether the button is disabled.
  /// Disabled buttons don't respond to interactions and appear visually muted.
  /// Default is false.
  final bool disabled;

  /// The background color to use when the button is disabled.
  /// Default is light grey.
  final Color? disabledColor;

  /// The text color to use when the button is disabled.
  /// Default is grey.
  final Color? disabledTextColor;

  /// An optional icon to display alongside the button text.
  /// Use this to create icon buttons or to add visual indicators.
  final Widget? icon;

  /// The position of the icon relative to the text.
  /// Can be left, right, top, or bottom. Default is left.
  final IconPosition iconPosition;

  /// The spacing between the icon and text.
  /// Default is 8.0 logical pixels.
  final double iconSpacing;

  /// Whether the button is in a loading state.
  /// When true, shows a loading indicator instead of the button content.
  /// Default is false.
  final bool loading;

  /// A custom widget to show when in loading state.
  /// If not provided, a CircularProgressIndicator is used.
  final Widget? loadingWidget;

  /// The size of the default loading indicator.
  /// Only used when [loadingWidget] is not provided. Default is 20.0.
  final double loadingSize;

  /// The color of the default loading indicator.
  /// Only used when [loadingWidget] is not provided.
  /// Default matches the text color.
  final Color? loadingColor;

  /// An optional tooltip message to show on hover.
  /// Useful for providing additional context about the button's action.
  /// The tooltip will always appear above the button.
  final String? tooltipMessage;
  
  // Removed tooltipPosition property
  
  /// The direction of the shimmer animation.
  /// Can be leftToRight, rightToLeft, or bottomLeftToTopRight.
  final ShimmerDirection shimmerDirection;
  
  /// The width of the shimmer effect as a fraction of the button width.
  /// Values between 0.0 and 1.0, where 1.0 is full button width.
  final double shimmerWidth;
  
  /// The opacity of the shimmer highlight.
  /// Values between 0.0 (transparent) and 1.0 (opaque).
  final double shimmerOpacity;
  
  /// The duration of one complete shimmer animation cycle.
  final Duration shimmerDuration;
  
  /// The color of the glow effect.
  /// If null, uses hoverColor, buttonColor, or defaults to amber.
  final Color? glowColor;
  
  /// The blur radius of the glow effect.
  /// Higher values create a more diffuse glow.
  final double glowRadius;
  
  /// The spread radius of the glow effect.
  /// Higher values create a larger glow area.
  final double glowSpread;
  
  /// The opacity of the glow effect.
  /// Values between 0.0 (transparent) and 1.0 (opaque).
  final double glowOpacity;
  
  /// The minimum scale factor for the pulse effect.
  /// Default is 1.0 (original size).
  final double pulseMinScale;
  
  /// The maximum scale factor for the pulse effect.
  /// Default is 1.05 (5% larger than original size).
  final double pulseMaxScale;
  
  /// The duration of one complete pulse animation cycle.
  final Duration pulseDuration;

  @override
  State<MyButton> createState() => _MyButtonState();
}

/// Defines the visual effect to apply when hovering over the button.
enum HoverEffect {
  /// Scales the button up slightly when hovered.
  scale,
  
  /// Changes the button's background color when hovered.
  color,
  
  /// Adds or changes the button's border when hovered.
  border,
  
  /// Adds a colored glow around the button when hovered.
  glow,
  
  /// Adds a smooth shimmer effect across the button.
  shimmer,
  
  /// Creates a smooth pulsing animation effect.
  pulse,
  
  /// Creates a subtle bounce effect.
  bounce,
  
  /// No visual change on hover.
  none,
}

/// Defines the direction of the shimmer effect.
enum ShimmerDirection {
  /// Shimmer moves from left to right.
  leftToRight,
  
  /// Shimmer moves from right to left.
  rightToLeft,
}

/// Defines the position of the icon relative to the button text.
enum IconPosition {
  /// Places the icon to the left of the text.
  /// Standard position for most left-to-right UIs.
  left,
  
  /// Places the icon to the right of the text.
  /// Useful for "forward" or "next" actions.
  right,
  
  /// Places the icon above the text.
  /// Creates a vertical layout.
  top,
  
  /// Places the icon below the text.
  /// Creates a vertical layout.
  bottom,
}

/// Defines the position of the tooltip relative to the button.
enum TooltipPosition {
  /// Shows the tooltip above the button.
  above,
  
  /// Shows the tooltip below the button.
  below,
  
  /// Shows the tooltip to the left of the button.
  left,
  
  /// Shows the tooltip to the right of the button.
  right,
}

class _MyButtonState extends State<MyButton> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _bounceAnimation;
  
  // In the _MyButtonState class
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.hoverEffect == HoverEffect.pulse 
          ? widget.pulseDuration 
          : widget.shimmerDuration,
    );
    
    // Setup pulse animation with improved smoothness
    _pulseAnimation = Tween<double>(
      begin: widget.pulseMinScale,
      end: widget.pulseMaxScale
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Setup bounce animation
    _bounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.03), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.03, end: 0.97), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.97, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Only start pulse animation automatically
    if (widget.hoverEffect == HoverEffect.pulse) {
      _animationController.repeat(reverse: true);
    }
    
    // Add listener to handle shimmer completion
    _animationController.addStatusListener(_handleAnimationStatus);
  }
  
  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && 
        widget.hoverEffect == HoverEffect.shimmer && 
        _isHovered) {
      // Reset shimmer when it completes while still hovering
      _animationController.reset();
      _animationController.forward();
    }
  }
  
  @override
  void dispose() {
    _animationController.removeStatusListener(_handleAnimationStatus);
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final effectiveTextColor = widget.disabled
        ? widget.disabledTextColor ?? Colors.grey
        : widget.textColor ?? Colors.white;

    final effectiveButtonColor = widget.disabled
        ? widget.disabledColor ?? Colors.grey.shade300
        : _isHovered && widget.hoverEffect == HoverEffect.color
            ? widget.hoverColor ?? (widget.buttonColor?.withOpacity(0.8) ?? Colors.amber.shade300)
            : widget.buttonColor ?? Colors.amber;

    final effectiveShadow = _getShadow();
    
    Widget buttonContent = _buildButtonContent(effectiveTextColor);
    
    // Apply tooltip if provided - simplified to always show above
    if (widget.tooltipMessage != null) {
      buttonContent = Tooltip(
        message: widget.tooltipMessage!,
        preferBelow: false, // Always show above
        verticalOffset: 20,  // Consistent offset
        child: buttonContent,
      );
    }
    
    // Apply animations based on hover effect
    Widget animatedButton = _applyHoverEffects(
      _buildBaseButton(buttonContent, effectiveButtonColor, effectiveShadow)
    );

    return GestureDetector(
      onTap: widget.disabled || widget.loading ? null : widget.onTap,
      onDoubleTap: widget.disabled || widget.loading ? null : widget.onDoubleTap,
      onLongPress: widget.disabled || widget.loading ? null : widget.onLongPress,
      onTapDown: (_) {
        if (!widget.disabled && !widget.loading) {
          setState(() => _isPressed = true);
        }
      },
      onTapUp: (_) {
        if (!widget.disabled && !widget.loading) {
          setState(() => _isPressed = false);
        }
      },
      onTapCancel: () {
        if (!widget.disabled && !widget.loading) {
          setState(() => _isPressed = false);
        }
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          if (widget.onHover != null) widget.onHover!(true);
          
          // Start shimmer animation on hover - only run once
          if (widget.hoverEffect == HoverEffect.shimmer && !widget.disabled) {
            _animationController.reset();
            _animationController.forward();
          }
          
          if (widget.hoverEffect == HoverEffect.bounce && !widget.disabled) {
            _animationController.reset();
            _animationController.forward();
          }
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          if (widget.onHover != null) widget.onHover!(false);
          
          // Reset shimmer animation when not hovering
          if (widget.hoverEffect == HoverEffect.shimmer) {
            _animationController.reset();
          }
        },
        cursor: widget.disabled || widget.loading
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: animatedButton,
      ),
    );
  }
  
  Widget _applyHoverEffects(Widget button) {
      // Apply different transformations based on hover effect
      switch (widget.hoverEffect) {
        case HoverEffect.scale:
          // Instead of wrapping the button with an AnimatedContainer,
          // use AnimatedScale which will properly scale the entire button
          return AnimatedScale(
            scale: _isHovered && !widget.disabled ? widget.hoverScale : 1.0,
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            child: button,
          );
          
        case HoverEffect.bounce:
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _isHovered ? _bounceAnimation.value : 1.0,
                child: child,
              );
            },
            child: button,
          );
          
        case HoverEffect.pulse:
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _isHovered ? _pulseAnimation.value : 1.0,
                child: child,
              );
            },
            child: button,
          );
          
        case HoverEffect.shimmer:
          return Stack(
            children: [
              button,
              if (_isHovered && !widget.disabled)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.buttonCircularRadius ?? 10),
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        // Calculate alignment based on shimmer direction
                        AlignmentDirectional startAlignment;
                        AlignmentDirectional endAlignment;
                        
                        switch (widget.shimmerDirection) {
                          case ShimmerDirection.leftToRight:
                            startAlignment = AlignmentDirectional(-2.0, 0);
                            endAlignment = AlignmentDirectional(2.0, 0);
                            break;
                          case ShimmerDirection.rightToLeft:
                            startAlignment = AlignmentDirectional(2.0, 0);
                            endAlignment = AlignmentDirectional(-2.0, 0);
                            break;
                        }
                        
                        // Calculate current position
                        final position = _animationController.value;
                        final currentAlignment = AlignmentDirectional.lerp(
                          startAlignment,
                          endAlignment,
                          position,
                        );
                        
                        // Make shimmer disappear at the end of animation
                        double opacity = 1.0;
                        if (position > 0.9) {
                          // Fade out at the end of the animation
                          opacity = (1.0 - position) * 10; // Will go from 1.0 to 0.0
                        }
                        
                        return Opacity(
                          opacity: opacity,
                          child: FractionallySizedBox(
                            widthFactor: widget.shimmerWidth,
                            alignment: currentAlignment!,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.white.withOpacity(0.0),
                                    Colors.white.withOpacity(widget.shimmerOpacity),
                                    Colors.white.withOpacity(0.0),
                                  ],
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
            
        case HoverEffect.glow:
          // Enhanced glow effect with customizable parameters
          return AnimatedContainer(
            duration: widget.animationDuration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular((widget.buttonCircularRadius ?? 10) + 4),
              boxShadow: _isHovered && !widget.disabled
                  ? [
                      BoxShadow(
                        color: (widget.glowColor ?? widget.hoverColor ?? widget.buttonColor ?? Colors.amber)
                            .withOpacity(widget.glowOpacity),
                        blurRadius: widget.glowRadius,
                        spreadRadius: widget.glowSpread,
                      ),
                    ]
                  : [],
            ),
            child: button,
          );
          
        default:
          return button;
      }
    }

    Widget _buildBaseButton(Widget content, Color buttonColor, List<BoxShadow>? shadow) {
      if (widget.rippleEffect && !widget.disabled && !widget.loading) {
        return _buildRippleEffect(content, buttonColor, shadow);
      } else {
        return _buildStaticButton(content, buttonColor, shadow);
      }
    }

    Widget _buildRippleEffect(Widget content, Color buttonColor, List<BoxShadow>? shadow) {
      return Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: widget.gradient != null ? null : buttonColor,
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(widget.buttonCircularRadius ?? 10),
            boxShadow: shadow,
            border: _getBorder(),
          ),
          child: InkWell(
            splashColor: widget.splashColor ?? Colors.white.withOpacity(0.3),
            highlightColor: widget.highlightColor ?? Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(widget.buttonCircularRadius ?? 10),
            onTap: widget.onTap,
            onDoubleTap: widget.onDoubleTap,
            onLongPress: widget.onLongPress,
            onHover: widget.onHover,
            child: Container(
              height: widget.buttonHeight ?? 50,
              width: widget.buttonWidth ?? 90,
              padding: widget.padding,
              margin: widget.margin,
              alignment: Alignment.center,
              child: content,
            ),
          ),
        ));
      }

    Widget _buildStaticButton(Widget content, Color buttonColor, List<BoxShadow>? shadow) {
      return CMaker(
        gradient: widget.gradient,
        border: _getBorder(),
        padding: widget.padding,
        margin: widget.margin,
        height: widget.buttonHeight ?? 50,
        width: widget.buttonWidth ?? 90,
        circularRadius: widget.buttonCircularRadius ?? 10,
        color: buttonColor,
        alignment: Alignment.center,
        boxShadow: shadow,
        child: content,
      );
    }

    Widget _buildButtonContent(Color textColor) {
      if (widget.loading) {
        return widget.loadingWidget ?? 
          SizedBox(
            height: widget.loadingSize,
            width: widget.loadingSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.loadingColor ?? textColor
              ),
            ),
          );
      }

      if (widget.icon == null) {
        return TMaker(
          fontFamily: widget.textFontFamily,
          text: widget.text,
          fontSize: widget.textFont ?? 20,
          fontWeight: widget.textFontWeight ?? FontWeight.w500,
          color: textColor,
        );
      }

      List<Widget> children = [
        widget.icon!,
        SizedBox(
          width: widget.iconPosition == IconPosition.left || widget.iconPosition == IconPosition.right 
              ? widget.iconSpacing : 0,
          height: widget.iconPosition == IconPosition.top || widget.iconPosition == IconPosition.bottom 
              ? widget.iconSpacing : 0,
        ),
        TMaker(
          fontFamily: widget.textFontFamily,
          text: widget.text,
          fontSize: widget.textFont ?? 20,
          fontWeight: widget.textFontWeight ?? FontWeight.w500,
          color: textColor,
        ),
      ];

      if (widget.iconPosition == IconPosition.right || widget.iconPosition == IconPosition.bottom) {
        children = children.reversed.toList();
      }

      return widget.iconPosition == IconPosition.left || widget.iconPosition == IconPosition.right
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            );
    }

    List<BoxShadow>? _getShadow() {
      if (widget.disabled) {
        return null;
      }

      if (_isHovered && !widget.disabled) {
        return [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 3),
            blurRadius: widget.hoverElevation,
            spreadRadius: 1,
          )
        ];
      }

      return (widget.addShadow ?? false)
          ? const [
              BoxShadow(
                color: Color.fromARGB(61, 0, 0, 0),
                offset: Offset(2, 2),
                blurRadius: 10,
                spreadRadius: .06,
              )
            ]
          : null;
    }

    BoxBorder? _getBorder() {
      if (_isHovered && widget.hoverEffect == HoverEffect.border && !widget.disabled) {
        return Border.all(
          color: widget.hoverColor ?? Colors.white,
          width: 2,
        );
      }
      return widget.border;
    }
}
