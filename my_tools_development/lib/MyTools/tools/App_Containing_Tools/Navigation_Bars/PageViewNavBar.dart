import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
class PageViewNavBar extends StatefulWidget {
  PageViewNavBar(
      {super.key,
      required this.pages,
      required this.iconsList,
      this.orientation,
      required this.height,
      required this.width,
      this.barColor,
      this.selectedContainerColor,
      this.pageBackgroundColor,
      this.unselectedContainerColor,
      this.SelectionContainerHeight,
      this.unSelectionContainerHeight,
      this.SelectionContainerWidth,
      this.unSelectionContainerWidth,
      this.SelectionContainerPadding,
      this.unSelectionContainerPadding,
      this.BackgroundImage,
      this.BarShadow,
      this.BarBorder,
      this.BarCircularRadius,
      this.BarGradient,
      this.SelectedContainerBorder,
      this.unSelectedContainerBorder,
      this.SelectionContainerCircularRadius,
      this.unSelectionContainerCircularRadius,
      this.SelectionContainerGradient,
      this.unSelectionContainerGradient,
      required this.onPageChange,
      this.ScrollDuration,
      this.SelectionContainerAnimationDuration,
      this.NavBarPositionBottom,
      this.NavBarPositionLeft,
      this.NavBarPositionRight,
      this.NavBarPositionTop,
      this.BetweenSpaces});
  List<Widget> pages;
  List<Widget> iconsList;
  String? orientation;
  Function(int? index) onPageChange;
  double height;
  double width;
  double? NavBarPositionTop;
  double? NavBarPositionBottom;
  double? NavBarPositionLeft;
  double? NavBarPositionRight;
  double? SelectionContainerHeight;
  double? unSelectionContainerHeight;
  Duration? SelectionContainerAnimationDuration;
  double? SelectionContainerWidth;
  double? unSelectionContainerWidth;
  double? SelectionContainerPadding;
  double? unSelectionContainerPadding;
  double? SelectionContainerCircularRadius;
  double? unSelectionContainerCircularRadius;
  double? BarCircularRadius;
  BoxBorder? SelectedContainerBorder;
  BoxBorder? unSelectedContainerBorder;
  Gradient? SelectionContainerGradient;
  Gradient? unSelectionContainerGradient;
  BoxBorder? BarBorder;
  Gradient? BarGradient;
  Duration? ScrollDuration;
  Color? barColor;
  Color? selectedContainerColor;
  Color? unselectedContainerColor;
  Color? pageBackgroundColor;
  Widget? BackgroundImage;
  List<BoxShadow>? BarShadow;
  double? BetweenSpaces;
  @override
  State<PageViewNavBar> createState() => _PageViewNavBarState();
}

class _PageViewNavBarState extends State<PageViewNavBar> {
  int PageIndex = 0;
  PageController? _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late Widget BarBody;
    if (widget.orientation == "H") {
      BarBody = Stack(
        children: [
          CMaker(
              height: double.infinity,
              color: widget.pageBackgroundColor ?? Colors.transparent,
              width: double.infinity,
              child: Stack(
                children: [
                  (widget.BackgroundImage != null)
                      ? SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: widget.BackgroundImage!)
                      : Container(),
                  PageView(
                    onPageChanged: (value) {
                      setState(() {
                        PageIndex = value;
                        widget.onPageChange(value);
                      });
                    },
                    controller: _pageController,
                    children: widget.pages,
                  ),
                ],
              )),
          Positioned(
            top: widget.NavBarPositionTop,
            left: widget.NavBarPositionLeft,
            bottom: widget.NavBarPositionBottom,
            right: widget.NavBarPositionRight,
            child: CMaker(
              boxShadow: widget.BarShadow,
              circularRadius: widget.BarCircularRadius ?? 20,
              border: widget.BarBorder,
              alignment: Alignment.center,
              gradient: widget.BarGradient,
              color: widget.barColor ?? Colors.white,
              height: widget.height,
              width: widget.width,
              child: SizedBox(
                width: widget.SelectionContainerWidth,
                child: Column(
                  children: [
                    Container(
                      height: widget.BetweenSpaces ??
                          (widget.height -
                                  (widget.iconsList.length *
                                      (widget.SelectionContainerHeight ??
                                          60))) /
                              (widget.iconsList.length + 1),
                    ),
                    CMaker(
                      boxShadow: widget.BarShadow,
                      height: widget.height -
                          (widget.height -
                                  (widget.iconsList.length *
                                      (widget.SelectionContainerHeight ??
                                          60))) /
                              (widget.iconsList.length + 1),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: false,
                        itemCount: widget.iconsList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _pageController!.animateToPage(index,
                                      curve: Curves.linear,
                                      duration: widget.ScrollDuration ??
                                          const Duration(milliseconds: 200));
                                },
                                child: CMaker(
                                    alignment: Alignment.center,
                                    child: ACMaker(
                                        duration: widget
                                            .SelectionContainerAnimationDuration,
                                        padding: EdgeInsets.all(
                                            widget.SelectionContainerPadding ??
                                                0),
                                        alignment: Alignment.center,
                                        height: widget.SelectionContainerHeight ??
                                            60,
                                        width: widget.SelectionContainerWidth ??
                                            60,
                                        circularRadius:
                                            widget.SelectionContainerCircularRadius ??
                                                15,
                                        border: (PageIndex == index)
                                            ? widget.SelectedContainerBorder
                                            : widget.unSelectedContainerBorder,
                                        gradient:
                                            widget.SelectionContainerGradient,
                                        color: (PageIndex == index)
                                            ? widget.selectedContainerColor ??
                                                const Color.fromARGB(
                                                    255, 0, 0, 0)
                                            : widget.unselectedContainerColor ??
                                                Colors.transparent,
                                        child: widget.iconsList[index])),
                              ),
                              Container(
                                height: widget.BetweenSpaces ??
                                    (widget.height -
                                            (widget.iconsList.length *
                                                (widget.SelectionContainerHeight ??
                                                    60))) /
                                        (widget.iconsList.length + 1),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      BarBody = Stack(
        children: [
          CMaker(
              height: double.infinity,
              color: widget.pageBackgroundColor ?? Colors.transparent,
              width: double.infinity,
              child: Stack(
                children: [
                  (widget.BackgroundImage != null)
                      ? SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: widget.BackgroundImage!)
                      : Container(),
                  PageView(
                    onPageChanged: (value) {
                      setState(() {
                        PageIndex = value;
                      });
                      widget.onPageChange(value);
                    },
                    controller: _pageController,
                    children: widget.pages,
                  ),
                ],
              )),
          Positioned(
              top: widget.NavBarPositionTop,
              left: widget.NavBarPositionLeft,
              bottom: widget.NavBarPositionBottom,
              right: widget.NavBarPositionRight,
              child: CMaker(
                boxShadow: widget.BarShadow,
                circularRadius: widget.BarCircularRadius ?? 20,
                border: widget.BarBorder,
                alignment: Alignment.center,
                gradient: widget.BarGradient,
                color: widget.barColor ?? Colors.white,
                height: widget.height,
                width: widget.width,
                child: SizedBox(
                  height: widget.SelectionContainerHeight,
                  child: Row(
                    children: [
                      Container(
                        width: widget.BetweenSpaces ??
                            (widget.width -
                                    (widget.iconsList.length *
                                        (widget.SelectionContainerWidth ??
                                            60))) /
                                (widget.iconsList.length + 1),
                      ),
                      CMaker(
                        width: widget.width -
                            (widget.width -
                                    (widget.iconsList.length *
                                        (widget.SelectionContainerWidth ??
                                            60))) /
                                (widget.iconsList.length + 1),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: false,
                          itemCount: widget.iconsList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    PageIndex = index;
                                    _pageController!.animateToPage(index,
                                        curve: Curves.linear,
                                        duration:
                                            const Duration(milliseconds: 200));
                                  },
                                  child: CMaker(
                                      alignment: Alignment.center,
                                      child: ACMaker(
                                          duration: widget
                                              .SelectionContainerAnimationDuration,
                                          padding: EdgeInsets.all(
                                              widget.SelectionContainerPadding ??
                                                  0),
                                          alignment: Alignment.center,
                                          height:
                                              widget.SelectionContainerHeight ??
                                                  60,
                                          width:
                                              widget.SelectionContainerWidth ??
                                                  60,
                                          circularRadius: widget
                                                  .SelectionContainerCircularRadius ??
                                              15,
                                          border: (PageIndex == index)
                                              ? widget.SelectedContainerBorder
                                              : widget
                                                  .unSelectedContainerBorder,
                                          gradient:
                                              widget.SelectionContainerGradient,
                                          color: (PageIndex == index)
                                              ? widget.selectedContainerColor ??
                                                  const Color.fromARGB(255, 0, 0, 0)
                                              : widget.unselectedContainerColor ?? Colors.transparent,
                                          child: widget.iconsList[index])),
                                ),
                                Container(
                                  width: widget.BetweenSpaces ??
                                      (widget.width -
                                              (widget.iconsList.length *
                                                  (widget.SelectionContainerWidth ??
                                                      60))) /
                                          (widget.iconsList.length + 1),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      );
    }
    return BarBody;
  }
}