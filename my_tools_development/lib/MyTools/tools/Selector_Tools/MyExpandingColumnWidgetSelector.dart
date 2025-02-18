import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:tix/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
// import 'package:tix/MyTools/tools/CMaker_Tools/CMaker.dart';

class MyExpandingColumnWidgetSelector extends StatefulWidget {
  MyExpandingColumnWidgetSelector(
      {super.key,
      required this.iconsList,
      required this.width,
      this.barColor,
      this.SelectionContainerColor,
      this.unSelectedContainerColor,
      this.SelectionContainerHeight,
      this.unSelectedContainerHeight,
      this.SelectionContainerWidth,
      this.unSelectedContainerWidth,
      this.SelectionContainerPadding,
      this.unSelectedContainerPadding,
      this.SelectionContainerBorder,
      this.unSelectedContainerBorder,
      this.SelectionContainerCircularRadius,
      this.unSelectedContainerCircularRadius,
      this.SelectionContainerGradient,
      this.unSelectedContainerGradient,
      this.SelectionContainerAnimationDuration,
      this.SelectionContainerMargin,
      this.unSelectedContainerMargin,
      this.BarShadow,
      this.BarBorder,
      this.BarCircularRadius,
      this.BarGradient,
      required this.onChange,
      this.ScrollDuration,
      this.betweenSpaces,
      this.reverseDirection,
      });
  final List<Widget> iconsList;
  final Function(int? index) onChange;
  final double width; 
  final double? SelectionContainerHeight;
  final double? unSelectedContainerHeight;
  final Duration? SelectionContainerAnimationDuration;
  final double? SelectionContainerWidth;
  final double? unSelectedContainerWidth;
  final EdgeInsetsGeometry? SelectionContainerPadding;
  final EdgeInsetsGeometry? SelectionContainerMargin;
  final EdgeInsetsGeometry? unSelectedContainerPadding;
  final EdgeInsetsGeometry? unSelectedContainerMargin;
  final double? SelectionContainerCircularRadius;
  final double? unSelectedContainerCircularRadius;
  final BoxBorder? SelectionContainerBorder;
  final BoxBorder? unSelectedContainerBorder;
  final Gradient? SelectionContainerGradient;
  final Gradient? unSelectedContainerGradient;
  final Color? SelectionContainerColor;
  final Color? unSelectedContainerColor;
  final double? BarCircularRadius;
  final BoxBorder? BarBorder;
  final Gradient? BarGradient;
  final Duration? ScrollDuration;
  final Color? barColor;
  final List<BoxShadow>? BarShadow;
  final double? betweenSpaces; 
  final bool? reverseDirection;

  @override
  State<MyExpandingColumnWidgetSelector> createState() =>
      _MyExpandingColumnWidgetSelectorState();
}

class _MyExpandingColumnWidgetSelectorState
    extends State<MyExpandingColumnWidgetSelector> {
  int PageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      reverse: widget.reverseDirection ?? false, // Enable reverse scrolling
      child: CMaker(
        boxShadow: widget.BarShadow,
        circularRadius: widget.BarCircularRadius ?? 20,
        border: widget.BarBorder,
        alignment: Alignment.center,
        gradient: widget.BarGradient,
        color: widget.barColor ?? Colors.white,
        width: widget.width, // Set the width explicitly
        child: Column(
          mainAxisSize: MainAxisSize.min, // Let the height be dynamic
          children: [
            // Add spacing at the top (around the first widget) only if not in reverse mode
            SizedBox(height: widget.betweenSpaces ?? 0),
            // Use ListView.builder to build the widgets with spacing between them
            ListView.builder(
              shrinkWrap:
                  true, // Ensure the ListView takes only the space it needs
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
              reverse: widget.reverseDirection ??
                  false, // Reverse the list if in reverse mode
              itemCount: widget.iconsList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          PageIndex = index;
                        });
                        widget.onChange(PageIndex);
                      },
                      child: CMaker(
                        alignment: Alignment.center,
                        child: ACMaker(
                          duration: widget.SelectionContainerAnimationDuration,
                          padding: 
                              widget.SelectionContainerPadding ,
                          alignment: Alignment.center,
                          height: widget.SelectionContainerHeight ,
                          width: widget.SelectionContainerWidth ,
                          circularRadius:
                              widget.SelectionContainerCircularRadius ?? 15,
                          border: (PageIndex == index)
                              ? widget.SelectionContainerBorder
                              : widget.unSelectedContainerBorder,
                          gradient: widget.SelectionContainerGradient,
                          color: (PageIndex == index)
                              ? widget.SelectionContainerColor ??
                                  const Color.fromARGB(255, 0, 0, 0)
                              : widget.unSelectedContainerColor ??
                                  Colors.transparent,
                          child: widget.iconsList[index],
                        ),
                      ),
                    ),
                    // Add spacing between widgets
                    if (index != widget.iconsList.length)
                      SizedBox(height: widget.betweenSpaces ?? 0),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
