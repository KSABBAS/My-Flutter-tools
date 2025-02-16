import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class MyDottedImageViewer extends StatefulWidget {
  /// A list of images which can be:
  /// - an asset path (String),
  /// - a network URL (String starting with http/https),
  /// - or raw bytes (Uint8List).
  final List<dynamic> images;
  
  /// The BoxFit for the image.
  final BoxFit imageFit;
  
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

  const MyDottedImageViewer({
    Key? key,
    required this.images,
    this.imageFit = BoxFit.cover,
    // Dot customization defaults:
    this.selectedDotWidth = 14.0,
    this.selectedDotHeight = 14.0,
    this.unselectedDotWidth = 12.0,
    this.unselectedDotHeight = 12.0,
    this.selectedDotColor = Colors.blue,
    this.unselectedDotColor = Colors.grey,
    this.dotSpacing = 8.0,
    this.dotAnimationCurve = Curves.easeInOut,
    this.dotAnimationDuration = const Duration(milliseconds: 300),
    // Page transition customization:
    this.pageTransitionDuration = const Duration(milliseconds: 300),
    this.pageTransitionCurve = Curves.easeInOut,
    this.scrollPhysics,
    // Auto-scroll options:
    this.autoScroll = false,
    this.autoScrollInterval = const Duration(seconds: 3),
    this.autoScrollAnimationDuration = const Duration(milliseconds: 300),
    // Big indicator container defaults:
    this.bigIndicatorContainerDecoration,
    this.bigIndicatorContainerPadding = const EdgeInsets.all(8.0),
    this.bigIndicatorContainerAlignment = Alignment.center,
    this.bigIndicatorContainerWidth,
    this.bigIndicatorContainerHeight,
    // Mini indicator container defaults:
    this.miniIndicatorContainerDecoration,
    this.miniIndicatorContainerPadding = const EdgeInsets.all(10.0),
    this.miniIndicatorContainerAlignment = Alignment.center,
    this.miniIndicatorContainerMargin = EdgeInsets.zero,
    this.miniIndicatorContainerWidth,
    this.miniIndicatorContainerHeight,
  }) : super(key: key);

  @override
  _MyDottedImageViewerState createState() => _MyDottedImageViewerState();
}

class _MyDottedImageViewerState extends State<MyDottedImageViewer>
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
          int nextPage = (_currentPage + 1) % widget.images.length;
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

  /// Builds the image widget using the provided imageFit.
  Widget _buildImage(dynamic imageSource) {
    if (imageSource is String) {
      if (imageSource.startsWith('http') || imageSource.startsWith('https')) {
        return Image.network(imageSource, fit: widget.imageFit);
      } else {
        return Image.asset(imageSource, fit: widget.imageFit);
      }
    } else if (imageSource is Uint8List) {
      return Image.memory(imageSource, fit: widget.imageFit);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the default height for the mini indicator container:
    final EdgeInsets resolvedPadding =
        widget.miniIndicatorContainerPadding.resolve(Directionality.of(context));
    final double defaultMiniHeight =
        max(widget.selectedDotHeight, widget.unselectedDotHeight) + resolvedPadding.vertical;

    return Column(
      children: [
        // Display images in a PageView.
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: widget.scrollPhysics ?? const PageScrollPhysics(),
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              _resetAutoScroll();
            },
            itemBuilder: (context, index) {
              return _buildImage(widget.images[index]);
            },
          ),
        ),
        // Full‑width big indicator container containing a scrollable mini indicator with dots.
        Container(
          width: widget.bigIndicatorContainerWidth ?? double.infinity,
          height: widget.bigIndicatorContainerHeight,
          decoration: widget.bigIndicatorContainerDecoration,
          padding: widget.bigIndicatorContainerPadding,
          alignment: widget.bigIndicatorContainerAlignment,
          child: Container(
            width: widget.miniIndicatorContainerWidth,
            height: widget.miniIndicatorContainerHeight ?? defaultMiniHeight,
            decoration: widget.miniIndicatorContainerDecoration,
            padding: widget.miniIndicatorContainerPadding,
            margin: widget.miniIndicatorContainerMargin,
            alignment: widget.miniIndicatorContainerAlignment,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(widget.images.length, (index) {
                  bool isSelected = _currentPage == index;
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
            ),
          ),
        ),
      ],
    );
  }

  void _resetAutoScroll() {
    if (widget.autoScroll && _autoScrollController != null) {
      _autoScrollController!.reset();
      _autoScrollController!.forward();
    }
  }
}
