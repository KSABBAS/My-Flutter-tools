import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CardBuilderViewer extends StatefulWidget {
  /// Total number of pages (cards) to build.
  final int itemCount;

  /// Builder callback to build each card.
  final Widget Function(BuildContext context, int index) builder;

  /// The fraction of the viewport that each card occupies.
  /// Lower values show more of the adjacent cards.
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

  // ----- Page Transition Customization -----
  final Duration pageTransitionDuration;
  final Curve pageTransitionCurve;
  final ScrollPhysics? scrollPhysics;

  // ----- Overlay Dots Options -----
  /// When true, the dots indicator is rendered as an overlay on top of the cards.
  final bool overlayDots;
  /// Alignment for the overlay dots container (default is bottomCenter).
  final Alignment overlayDotsAlignment;
  /// Padding for the overlay dots container.
  final EdgeInsets overlayDotsPadding;

  const CardBuilderViewer({
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
    this.pageTransitionDuration = const Duration(milliseconds: 300),
    this.pageTransitionCurve = Curves.easeInOut,
    this.scrollPhysics,
    this.overlayDots = false,
    this.overlayDotsAlignment = Alignment.bottomCenter,
    this.overlayDotsPadding = const EdgeInsets.only(bottom: 16.0),
  }) : super(key: key);

  @override
  _CardBuilderViewerState createState() => _CardBuilderViewerState();
}

class _CardBuilderViewerState extends State<CardBuilderViewer> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
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
              duration: widget.pageTransitionDuration,
              curve: widget.pageTransitionCurve,
            );
          },
          child: AnimatedContainer(
            duration: widget.dotAnimationDuration,
            curve: widget.dotAnimationCurve,
            margin: EdgeInsets.symmetric(horizontal: widget.dotSpacing / 2),
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

    // Always return a Column.
    if (widget.overlayDots && widget.showDotsIndicator) {
      return Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                pageView,
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    alignment: widget.overlayDotsAlignment,
                    padding: widget.overlayDotsPadding,
                    child: _buildDotsIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(child: pageView),
          if (!widget.overlayDots && widget.showDotsIndicator)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _buildDotsIndicator(),
            ),
        ],
      );
    }
  }
}
