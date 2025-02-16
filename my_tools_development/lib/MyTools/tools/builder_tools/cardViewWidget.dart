import 'dart:async';
import 'package:flutter/material.dart';

class MyDottedCardViewer extends StatefulWidget {
  /// Total number of cards.
  final int itemCount;

  /// Builder callback to build each card.
  final Widget Function(BuildContext context, int index) builder;

  // ----- Dot Indicator Customization -----
  final double selectedDotWidth;
  final double selectedDotHeight;
  final double unselectedDotWidth;
  final double unselectedDotHeight;
  final Color selectedDotColor;
  final Color unselectedDotColor;
  final double dotSpacing;
  final Curve dotAnimationCurve;
  final Duration dotAnimationDuration;

  // ----- Page Transition Customization -----
  final Duration pageTransitionDuration;
  final Curve pageTransitionCurve;
  final ScrollPhysics? scrollPhysics;

  // ----- Auto-Scroll Options -----
  final bool autoScroll;
  final Duration autoScrollInterval;
  final Duration autoScrollAnimationDuration;

  // ----- Big Indicator Container Customization -----
  final BoxDecoration? bigIndicatorContainerDecoration;
  final EdgeInsetsGeometry bigIndicatorContainerPadding;
  final Alignment bigIndicatorContainerAlignment;
  final double? bigIndicatorContainerWidth;
  final double? bigIndicatorContainerHeight;

  // ----- Mini Indicator Container Customization -----
  final BoxDecoration? miniIndicatorContainerDecoration;
  final EdgeInsetsGeometry miniIndicatorContainerPadding;
  final Alignment miniIndicatorContainerAlignment;
  final EdgeInsetsGeometry miniIndicatorContainerMargin;
  final double? miniIndicatorContainerWidth;
  final double? miniIndicatorContainerHeight;

  // ----- Overlay Dots Options -----
  final bool overlayDots;
  final Alignment overlayDotsAlignment;
  final EdgeInsets overlayDotsPadding;

  /// Called when the viewed card changes, providing the current displayed index.
  final ValueChanged<int>? onPageChanged;

  /// Called when a card is tapped, providing the tapped card index.
  final ValueChanged<int>? onCardPressed;

  const MyDottedCardViewer({
    Key? key,
    required this.itemCount,
    required this.builder,
    this.selectedDotWidth = 14.0,
    this.selectedDotHeight = 14.0,
    this.unselectedDotWidth = 12.0,
    this.unselectedDotHeight = 12.0,
    this.selectedDotColor = Colors.blue,
    this.unselectedDotColor = Colors.grey,
    this.dotSpacing = 8.0,
    this.dotAnimationCurve = Curves.easeInOut,
    this.dotAnimationDuration = const Duration(milliseconds: 300),
    this.pageTransitionDuration = const Duration(milliseconds: 300),
    this.pageTransitionCurve = Curves.easeInOut,
    this.scrollPhysics,
    this.autoScroll = false,
    this.autoScrollInterval = const Duration(seconds: 3),
    this.autoScrollAnimationDuration = const Duration(milliseconds: 300),
    this.bigIndicatorContainerDecoration,
    this.bigIndicatorContainerPadding = const EdgeInsets.all(8.0),
    this.bigIndicatorContainerAlignment = Alignment.center,
    this.bigIndicatorContainerWidth,
    this.bigIndicatorContainerHeight,
    this.miniIndicatorContainerDecoration,
    this.miniIndicatorContainerPadding = const EdgeInsets.all(10.0),
    this.miniIndicatorContainerAlignment = Alignment.center,
    this.miniIndicatorContainerMargin = EdgeInsets.zero,
    this.miniIndicatorContainerWidth,
    this.miniIndicatorContainerHeight,
    this.overlayDots = false,
    this.overlayDotsAlignment = Alignment.bottomCenter,
    this.overlayDotsPadding = const EdgeInsets.only(bottom: 16.0),
    this.onPageChanged,
    this.onCardPressed,
  }) : super(key: key);

  @override
  _MyDottedCardViewerState createState() => _MyDottedCardViewerState();
}

class _MyDottedCardViewerState extends State<MyDottedCardViewer>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  AnimationController? _autoScrollController;

  @override
  void initState() {
    _pageController = PageController();
    if (widget.autoScroll) {
      _initAutoScroll();
    }
    super.initState();
  }

  void _initAutoScroll() {
    _autoScrollController = AnimationController(
      vsync: this,
      duration: widget.autoScrollInterval,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          int nextPage = (_currentPage + 1) % widget.itemCount;
          _pageController.animateToPage(
            nextPage,
            duration: widget.autoScrollAnimationDuration,
            curve: widget.pageTransitionCurve,
          );
          _autoScrollController?.reset();
          _autoScrollController?.forward();
        }
      });
    _autoScrollController?.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollController?.dispose();
    super.dispose();
  }

  Widget _buildDotsIndicator() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.itemCount, (index) {
          bool isSelected = index == _currentPage;
          return GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: widget.pageTransitionDuration,
                curve: widget.pageTransitionCurve,
              );
              _resetAutoScroll();
            },
            child: AnimatedContainer(
              duration: widget.dotAnimationDuration,
              curve: widget.dotAnimationCurve,
              margin: EdgeInsets.symmetric(horizontal: widget.dotSpacing / 2),
              width: isSelected
                  ? widget.selectedDotWidth
                  : widget.unselectedDotWidth,
              height: isSelected
                  ? widget.selectedDotHeight
                  : widget.unselectedDotHeight,
              decoration: BoxDecoration(
                color: isSelected
                    ? widget.selectedDotColor
                    : widget.unselectedDotColor,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }

  void _resetAutoScroll() {
    if (widget.autoScroll && _autoScrollController != null) {
      _autoScrollController!.reset();
      _autoScrollController!.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build the PageView (card viewer) with callbacks.
    Widget pageView = PageView.builder(
      controller: _pageController,
      physics: widget.scrollPhysics ?? const PageScrollPhysics(),
      itemCount: widget.itemCount,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
        _resetAutoScroll();
        if (widget.onPageChanged != null) {
          widget.onPageChanged!(index);
        }
      },
      itemBuilder: (context, index) {
        Widget cardWidget = widget.builder(context, index);
        if (widget.onCardPressed != null) {
          cardWidget = GestureDetector(
            onTap: () => widget.onCardPressed!(index),
            child: cardWidget,
          );
        }
        return cardWidget;
      },
    );

    // Build the mini indicator container that holds the dots.
    Widget miniIndicator = Container(
      decoration: widget.miniIndicatorContainerDecoration,
      padding: widget.miniIndicatorContainerPadding,
      alignment: widget.miniIndicatorContainerAlignment,
      margin: widget.miniIndicatorContainerMargin,
      width: widget.miniIndicatorContainerWidth,
      height: widget.miniIndicatorContainerHeight,
      child: _buildDotsIndicator(),
    );

    if (widget.overlayDots) {
      // When overlayDots is true, only the mini indicator is overlaid on top.
      return Stack(
        children: [
          pageView,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: widget.overlayDotsAlignment,
              padding: widget.overlayDotsPadding,
              child: miniIndicator,
            ),
          ),
        ],
      );
    } else {
      // Otherwise, the layout uses a big indicator container that holds the mini indicator.
      Widget bigIndicator = Container(
        decoration: widget.bigIndicatorContainerDecoration,
        padding: widget.bigIndicatorContainerPadding,
        alignment: widget.bigIndicatorContainerAlignment,
        width: widget.bigIndicatorContainerWidth,
        height: widget.bigIndicatorContainerHeight,
        child: miniIndicator,
      );
      return Column(
        children: [
          Expanded(child: pageView),
          bigIndicator,
        ],
      );
    }
  }
}
