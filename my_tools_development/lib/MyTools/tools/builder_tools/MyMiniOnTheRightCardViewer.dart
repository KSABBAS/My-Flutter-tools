import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MyMiniOnTheRightCardViewer extends StatefulWidget {
  /// Total number of cards.
  final int itemCount;

  /// Builder callback to build each card.
  final Widget Function(BuildContext context, int index) builder;

  /// The fraction of the viewport that each card occupies.
  final double viewportFraction;

  /// The scale factor for non‑center cards.
  /// For example, 0.8 means side cards are scaled to 80% of full size.
  final double scaleFactor;

  /// Whether to display the dots indicator.
  final bool showDotsIndicator;

  // ----- Dots Indicator Customization -----
  final double dotSize;
  final double dotSpacing;
  final Color dotColor;
  final Color activeDotColor;
  final Duration dotAnimationDuration;
  final Curve dotAnimationCurve;

  // ----- Auto-Scroll Options -----
  final bool autoScroll;
  final Duration autoScrollInterval;
  final Duration autoScrollAnimationDuration;
  final Curve autoScrollCurve;

  // ----- Optional Scroll Physics -----
  final ScrollPhysics? scrollPhysics;

  // ----- Toggle Dots Option -----
  /// If true, tapping on the carousel toggles the visibility of the dots indicator.
  final bool toggleDotsOnTap;

  const MyMiniOnTheRightCardViewer({
    Key? key,
    required this.itemCount,
    required this.builder,
    this.viewportFraction = 0.8,
    this.scaleFactor = 0.8,
    this.showDotsIndicator = true,
    this.dotSize = 8.0,
    this.dotSpacing = 4.0,
    this.dotColor = Colors.grey,
    this.activeDotColor = Colors.blue,
    this.dotAnimationDuration = const Duration(milliseconds: 300),
    this.dotAnimationCurve = Curves.easeInOut,
    this.autoScroll = false,
    this.autoScrollInterval = const Duration(seconds: 3),
    this.autoScrollAnimationDuration = const Duration(milliseconds: 300),
    this.autoScrollCurve = Curves.easeInOut,
    this.scrollPhysics,
    this.toggleDotsOnTap = false,
  }) : super(key: key);

  @override
  _MyMiniOnTheRightCardViewerState createState() => _MyMiniOnTheRightCardViewerState();
}

class _MyMiniOnTheRightCardViewerState extends State<MyMiniOnTheRightCardViewer>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;
  late bool _dotsVisible;

  @override
  void initState() {
    super.initState();
    _dotsVisible = widget.showDotsIndicator;
    _pageController = PageController(
      viewportFraction: widget.viewportFraction,
      initialPage: 0,
    );
    if (widget.autoScroll) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(widget.autoScrollInterval, (timer) {
      int nextPage = (_currentPage + 1) % widget.itemCount;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          nextPage,
          duration: widget.autoScrollAnimationDuration,
          curve: widget.autoScrollCurve,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.itemCount, (index) {
        bool isActive = index == _currentPage;
        return GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: widget.dotAnimationDuration,
              curve: widget.dotAnimationCurve,
            );
          },
          child: AnimatedContainer(
            duration: widget.dotAnimationDuration,
            curve: widget.dotAnimationCurve,
            margin: EdgeInsets.symmetric(horizontal: widget.dotSpacing),
            width: widget.dotSize,
            height: widget.dotSize,
            decoration: BoxDecoration(
              color: isActive ? widget.activeDotColor : widget.dotColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build the PageView with a scaling effect.
    Widget pageView = PageView.builder(
      controller: _pageController,
      itemCount: widget.itemCount,
      physics: widget.scrollPhysics ?? const BouncingScrollPhysics(),
      clipBehavior: Clip.none, // Allow adjacent cards to be visible.
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double scale = widget.scaleFactor;
            if (_pageController.hasClients &&
                _pageController.position.hasContentDimensions) {
              double? page = _pageController.page;
              if (page != null) {
                double pageOffset = page - index;
                scale = (1 - pageOffset.abs() * (1 - widget.scaleFactor))
                    .clamp(widget.scaleFactor, 1.0);
              }
            } else {
              scale = index == _pageController.initialPage ? 1.0 : widget.scaleFactor;
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    child: widget.builder(context, index),
                  ),
                );
              },
            );
          },
        );
      },
    );

    // If toggleDotsOnTap is enabled, wrap pageView in a GestureDetector.
    Widget content = pageView;
    if (widget.toggleDotsOnTap) {
      content = GestureDetector(
        onTap: () {
          setState(() {
            _dotsVisible = !_dotsVisible;
          });
        },
        child: content,
      );
    }

    // If overlayDots is desired and dots are visible, place dots as an overlay.
    if (_dotsVisible) {
      content = Stack(
        children: [
          pageView,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(bottom: 16.0),
              alignment: Alignment.bottomCenter,
              child: _buildDotsIndicator(),
            ),
          ),
        ],
      );
      // Wrap the Stack in an Expanded inside a Column.
      return Column(
        children: [
          Expanded(child: content),
        ],
      );
    } else {
      // If overlay is not used, show dots below.
      return Column(
        children: [
          Expanded(child: content),
          if (!_dotsVisible && widget.showDotsIndicator)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _buildDotsIndicator(),
            ),
        ],
      );
    }
  }
}
