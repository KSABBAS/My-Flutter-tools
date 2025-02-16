import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class MyMiniOnTheRightImageViewer extends StatefulWidget {
  final List<dynamic> images;
  
  /// The BoxFit for each image.
  final BoxFit imageFit;
  
  /// The fraction of the viewport that each page occupies.
  final double viewportFraction;
  
  /// The scale factor for non‑center images.
  final double scaleFactor;
  
  /// Whether to display the dots indicator below the carousel.
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
  
  // ----- Callbacks -----
  /// Called when the page changes; provides the new index.
  final ValueChanged<int>? onPageChanged;
  /// Called when the displayed image is tapped; provides the index.
  final ValueChanged<int>? onImagePressed;

  const MyMiniOnTheRightImageViewer({
    Key? key,
    required this.images,
    this.imageFit = BoxFit.cover,
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
    this.onPageChanged,
    this.onImagePressed,
  }) : super(key: key);

  @override
  _MyMiniOnTheRightImageViewerState createState() => _MyMiniOnTheRightImageViewerState();
}

class _MyMiniOnTheRightImageViewerState extends State<MyMiniOnTheRightImageViewer> {
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
      int nextPage = (_currentPage + 1) % widget.images.length;
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

  /// Builds the image widget using the specified imageFit and wraps it with a GestureDetector.
  Widget _buildImage(dynamic imageSource, int index) {
    Widget imageWidget;
    if (imageSource is String) {
      if (imageSource.startsWith('http') || imageSource.startsWith('https')) {
        imageWidget = Image.network(imageSource, fit: widget.imageFit);
      } else {
        imageWidget = Image.asset(imageSource, fit: widget.imageFit);
      }
    } else if (imageSource is Uint8List) {
      imageWidget = Image.memory(imageSource, fit: widget.imageFit);
    } else {
      imageWidget = Container();
    }
    return GestureDetector(
      onTap: () {
        if (widget.onImagePressed != null) {
          widget.onImagePressed!(index);
        }
      },
      child: imageWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Carousel area.
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              if (widget.onPageChanged != null) {
                widget.onPageChanged!(index);
              }
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: _buildImage(widget.images[index], index),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        // Optional dots indicator.
        if (widget.showDotsIndicator)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                bool isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: widget.dotAnimationDuration,
                  curve: widget.dotAnimationCurve,
                  margin: EdgeInsets.symmetric(horizontal: widget.dotSpacing),
                  width: widget.dotSize,
                  height: widget.dotSize,
                  decoration: BoxDecoration(
                    color: isActive ? widget.activeDotColor : widget.dotColor,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }
}
