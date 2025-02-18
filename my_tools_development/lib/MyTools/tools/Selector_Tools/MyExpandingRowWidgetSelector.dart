import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:tix/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
// import 'package:tix/MyTools/tools/CMaker_Tools/CMaker.dart';

class MyExpandingRowWidgetSelector extends StatefulWidget {
  MyExpandingRowWidgetSelector({
    super.key,
    required this.iconsList,
    required this.height, // Only specify height, width will be dynamic
    this.barColor,
    this.SelectionContainerColor,
    this.unSelectedContainerColor,
    this.SelectionContainerHeight,
    this.unSelectedContainerHeight,
    this.SelectionContainerWidth,
    this.unSelectedContainerWidth,
    this.SelectionContainerPadding,
    this.unSelectedContainerPadding,
    this.BarShadow,
    this.BarBorder,
    this.BarCircularRadius,
    this.BarGradient,
    this.SelectionContainerBorder,
    this.unSelectedContainerBorder,
    this.SelectionContainerCircularRadius,
    this.unSelectedContainerCircularRadius,
    this.SelectionContainerGradient,
    this.unSelectedContainerGradient,
    required this.onChange,
    this.ScrollDuration,
    this.SelectionContainerAnimationDuration,
    this.betweenSpaces, 
    this.reverseDirection,
    this.SelectionContainerMargin,
    this.unSelectedContainerMargin
  });

  final List<Widget> iconsList;
  final Function(int? index) onChange;
  final double height; 
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
  final double? BarCircularRadius;
  final BoxBorder? SelectionContainerBorder;
  final BoxBorder? unSelectedContainerBorder;
  final Gradient? SelectionContainerGradient;
  final Gradient? unSelectedContainerGradient;
  final BoxBorder? BarBorder;
  final Gradient? BarGradient;
  final Duration? ScrollDuration;
  final Color? barColor;
  final Color? SelectionContainerColor;
  final Color? unSelectedContainerColor;
  final List<BoxShadow>? BarShadow;
  final double? betweenSpaces; 
  final bool? reverseDirection;

  @override
  State<MyExpandingRowWidgetSelector> createState() => _MyExpandingRowWidgetSelectorState();
}

class _MyExpandingRowWidgetSelectorState extends State<MyExpandingRowWidgetSelector> {
  int PageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CMaker(
      boxShadow: widget.BarShadow,
      circularRadius: widget.BarCircularRadius ?? 20,
      border: widget.BarBorder,
      alignment: Alignment.center,
      gradient: widget.BarGradient,
      color: widget.barColor ?? Colors.white,
      height: widget.height, // Set the height explicitly
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: widget.reverseDirection ?? false, // Enable reverse scrolling
        itemCount: widget.iconsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left:  widget.betweenSpaces ??0,
              right: index == widget.iconsList.length - 1 && widget.reverseDirection == true
                  ? widget.betweenSpaces ?? 0
                  : widget.betweenSpaces ?? 0,
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  PageIndex = index;
                });
                widget.onChange(PageIndex);
              },
              child: CMaker(
                alignment: Alignment.center,
                child: ACMaker(
                  margin: widget.SelectionContainerMargin,
                  duration: widget.SelectionContainerAnimationDuration,
                  padding: widget.SelectionContainerPadding ,
                  alignment: Alignment.center,
                  height: widget.SelectionContainerHeight ,
                  width: widget.SelectionContainerWidth ,
                  circularRadius: widget.SelectionContainerCircularRadius ?? 15,
                  border: (PageIndex == index)
                      ? widget.SelectionContainerBorder
                      : widget.unSelectedContainerBorder,
                  gradient: widget.SelectionContainerGradient,
                  color: (PageIndex == index)
                      ? widget.SelectionContainerColor ?? const Color.fromARGB(255, 0, 0, 0)
                      : widget.unSelectedContainerColor ?? Colors.transparent,
                  child: widget.iconsList[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}