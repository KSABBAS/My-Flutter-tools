import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

/// Enum to control where the navigation bar is placed relative to the page.
enum NavigationBarPosition { top, bottom, left, right }

/// Enum to control the type of page transition.
enum TransitionType { fade, slide }

/// Enum to control the orientation of the progress indicator.
enum StageProgressOrientation { horizontal, vertical }

class StageProgressNavigator extends StatefulWidget {
  /// The list of pages to display.
  final List<Widget> pages;

  /// Orientation of the entire widget.
  final StageProgressOrientation orientation;

  /// Selects the type of transition (fade or slide).
  final TransitionType transitionType;

  /// Controls where the navigation bar (progress indicator and controls) appears.
  /// In horizontal mode, only [NavigationBarPosition.top] or [NavigationBarPosition.bottom] are used.
  /// In vertical mode, only [NavigationBarPosition.left] or [NavigationBarPosition.right] are used.
  final NavigationBarPosition navigationBarPosition;

  /// Callback when the stage changes. Returns the new stage index.
  final ValueChanged<int>? onStageChanged;

  // --- Indicator Customization ---
  /// Diameter of each stage marker.
  final double markerSize;

  /// Thickness of the connecting line.
  final double lineThickness;

  /// Color for active (completed) stages.
  final Color activeColor;

  /// Color for inactive stages.
  final Color inactiveColor;

  /// Duration for the animated selection ball.
  final Duration indicatorAnimationDuration;

  // --- Page Transition Customization ---
  final Duration pageTransitionDuration;

  // --- Navigation Button Customization ---
  /// Default text for the previous button.
  final String previousButtonText;

  /// Default text for the next button.
  final String nextButtonText;

  /// Optional callback to build the previous button text given the current stage.
  final String Function(int currentStage)? previousTextBuilder;

  /// Optional callback to build the next button text given the current stage.
  final String Function(int currentStage)? nextTextBuilder;

  /// Text style for the navigation buttons.
  final TextStyle? buttonTextStyle;

  /// Whether to show the previous button.
  final bool showPreviousButton;

  /// Whether to show the next button.
  final bool showNextButton;

  // --- Navigation Bar Background, Size & Padding ---
  /// The background color of the navigation bar.
  final Color navigationBarBackgroundColor;

  /// For horizontal mode, the height of the navigation bar.
  final double navigationBarHeight;

  /// For vertical mode, the width of the navigation bar.
  final double navigationBarWidth;

  /// Padding inside the navigation bar to add spacing around its content.
  final EdgeInsets navigationBarPadding;

  const StageProgressNavigator({
    Key? key,
    required this.pages,
    this.orientation = StageProgressOrientation.horizontal,
    this.transitionType = TransitionType.fade,
    this.navigationBarPosition = NavigationBarPosition.bottom,
    this.onStageChanged,
    this.markerSize = 24.0,
    this.lineThickness = 4.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.indicatorAnimationDuration = const Duration(milliseconds: 300),
    this.pageTransitionDuration = const Duration(milliseconds: 300),
    this.previousButtonText = "Previous",
    this.nextButtonText = "Next",
    this.previousTextBuilder,
    this.nextTextBuilder,
    this.buttonTextStyle,
    this.showPreviousButton = true,
    this.showNextButton = true,
    this.navigationBarBackgroundColor = Colors.transparent,
    this.navigationBarHeight = 132.0,
    this.navigationBarWidth = 150.0,
    this.navigationBarPadding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  _StageProgressNavigatorState createState() => _StageProgressNavigatorState();
}

class _StageProgressNavigatorState extends State<StageProgressNavigator> {
  int _currentStage = 0;

  void _goToStage(int stage) {
    if (stage < 0 || stage >= widget.pages.length) return;
    setState(() {
      _currentStage = stage;
    });
    widget.onStageChanged?.call(stage);
  }

  /// Returns the fraction (0.0 to 1.0) representing the current stage position.
  double get _currentFraction {
    if (widget.pages.length <= 1) return 0.0;
    return _currentStage / (widget.pages.length - 1);
  }

  /// Builds a unified indicator layer that draws the line, animated ball, and clickable markers.
  Widget _buildIndicatorStack(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isHorizontal =
            widget.orientation == StageProgressOrientation.horizontal;
        final double totalLength = isHorizontal
            ? constraints.maxWidth - widget.markerSize
            : constraints.maxHeight - widget.markerSize;
        final double ballPos =
            widget.markerSize / 2 + _currentFraction * totalLength;

        // Base line.
        Widget line = isHorizontal
            ? Positioned(
                left: widget.markerSize / 2,
                right: widget.markerSize / 2,
                top: (constraints.maxHeight - widget.lineThickness) / 2,
                child: Container(
                  height: widget.lineThickness,
                  color: widget.inactiveColor,
                ),
              )
            : Positioned(
                top: widget.markerSize / 2,
                bottom: widget.markerSize / 2,
                left: (constraints.maxWidth - widget.lineThickness) / 2,
                child: Container(
                  width: widget.lineThickness,
                  color: widget.inactiveColor,
                ),
              );

        // Animated selection ball.
        Widget animatedBall = AnimatedPositioned(
          duration: widget.indicatorAnimationDuration,
          curve: Curves.easeInOut,
          left: isHorizontal
              ? ballPos - widget.markerSize / 2
              : (constraints.maxWidth - widget.markerSize) / 2,
          top: isHorizontal
              ? (constraints.maxHeight - widget.markerSize) / 2
              : ballPos - widget.markerSize / 2,
          width: widget.markerSize,
          height: widget.markerSize,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.activeColor,
            ),
          ),
        );

        // Clickable markers.
        List<Widget> markerWidgets = [];
        for (int i = 0; i < widget.pages.length; i++) {
          final double pos = widget.markerSize / 2 +
              (i / (widget.pages.length - 1)) * totalLength;
          markerWidgets.add(Positioned(
            left: isHorizontal
                ? pos - widget.markerSize / 2
                : (constraints.maxWidth - widget.markerSize) / 2,
            top: isHorizontal
                ? (constraints.maxHeight - widget.markerSize) / 2
                : pos - widget.markerSize / 2,
            width: widget.markerSize,
            height: widget.markerSize,
            child: GestureDetector(
              onTap: () => _goToStage(i),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: i <= _currentStage
                        ? widget.activeColor
                        : widget.inactiveColor,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ));
        }

        return Stack(
          children: [
            line,
            animatedBall,
            ...markerWidgets,
          ],
        );
      },
    );
  }

  /// Builds the page content using AnimatedSwitcher for transitions.
  Widget _buildPageContent() {
    return AnimatedSwitcher(
      duration: widget.pageTransitionDuration,
      transitionBuilder: (child, animation) {
        if (widget.transitionType == TransitionType.fade) {
          return FadeTransition(opacity: animation, child: child);
        } else {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          );
        }
      },
      child: Container(
        key: ValueKey<int>(_currentStage),
        width: double.infinity,
        height: double.infinity,
        child: widget.pages[_currentStage],
      ),
    );
  }

  /// Builds the navigation controls (Previous/Next buttons) for horizontal mode.
  Widget _buildNavigationControls() {
    final String prevText = widget.previousTextBuilder != null
        ? widget.previousTextBuilder!(_currentStage)
        : widget.previousButtonText;
    final String nextText = widget.nextTextBuilder != null
        ? widget.nextTextBuilder!(_currentStage)
        : widget.nextButtonText;

    Widget prevButton = widget.showPreviousButton
        ? TextButton(
            onPressed:
                _currentStage > 0 ? () => _goToStage(_currentStage - 1) : null,
            child: Text(prevText, style: widget.buttonTextStyle),
          )
        : const SizedBox.shrink();
    Widget nextButton = widget.showNextButton
        ? TextButton(
            onPressed: _currentStage < widget.pages.length - 1
                ? () => _goToStage(_currentStage + 1)
                : null,
            child: Text(nextText, style: widget.buttonTextStyle),
          )
        : const SizedBox.shrink();

    if (widget.orientation == StageProgressOrientation.horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[ prevButton, nextButton],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [prevButton, nextButton],
      );
    }
  }

  /// Builds the navigation bar which includes the indicator and (if horizontal) navigation controls.
  Widget _buildNavigationBar(BuildContext context) {
    bool isHorizontal =
        widget.orientation == StageProgressOrientation.horizontal;
    Widget content;
    if (isHorizontal) {
      if (widget.navigationBarPosition == NavigationBarPosition.top) {
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNavigationControls(),
            SizedBox(height: 60, child: _buildIndicatorStack(context)),
          ],
        );
      } else {
        content = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 60, child: _buildIndicatorStack(context)),
            _buildNavigationControls(),
          ],
        );
      }
    } else {
      // In vertical mode, only the indicator is shown.
      if (widget.navigationBarPosition == NavigationBarPosition.left) {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNavigationControls(),
            SizedBox(width: 60, child: _buildIndicatorStack(context)),
          ],
        );
      } else {
        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 60, child: _buildIndicatorStack(context)),
            _buildNavigationControls(),
          ],
        );
      }
    }

    return isHorizontal
        ? Container(
            padding: widget.navigationBarPadding,
            color: widget.navigationBarBackgroundColor,
            height: widget.navigationBarHeight,
            width: double.infinity,
            child: content,
          )
        : Container(
            padding: widget.navigationBarPadding,
            color: widget.navigationBarBackgroundColor,
            width: widget.navigationBarWidth,
            height: double.infinity,
            child: content,
          );
  }

  @override
  Widget build(BuildContext context) {
    // Layout based on orientation and navigationBarPosition.
    if (widget.orientation == StageProgressOrientation.horizontal) {
      if (widget.navigationBarPosition == NavigationBarPosition.top) {
        return Column(
          children: [
            _buildNavigationBar(context),
            Expanded(child: _buildPageContent()),
          ],
        );
      } else {
        return Column(
          children: [
            Expanded(child: _buildPageContent()),
            _buildNavigationBar(context),
          ],
        );
      }
    } else {
      if (widget.navigationBarPosition == NavigationBarPosition.left) {
        return Row(
          children: [
            _buildNavigationBar(context),
            Expanded(child: _buildPageContent()),
          ],
        );
      } else {
        return Row(
          children: [
            Expanded(child: _buildPageContent()),
            _buildNavigationBar(context),
          ],
        );
      }
    }
  }
}
