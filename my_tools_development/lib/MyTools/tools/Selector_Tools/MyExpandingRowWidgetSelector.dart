import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';

class MyExpandingRowWidgetSelector extends StatefulWidget {
  MyExpandingRowWidgetSelector({
    super.key,
    required this.iconsList,
    required this.height, // Only specify height, width will be dynamic
    this.barColor,
    this.selectedContainerColor,
    this.unselectedContainerColor,
    this.SelectionContainerHeight,
    this.unSelectionContainerHeight,
    this.SelectionContainerWidth,
    this.unSelectionContainerWidth,
    this.SelectionContainerPadding,
    this.unSelectionContainerPadding,
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
    required this.onChange,
    this.ScrollDuration,
    this.SelectionContainerAnimationDuration,
    this.betweenSpaces, // New parameter for spacing between widgets
    this.reverseDirection,
  });

  final List<Widget> iconsList;
  final Function(int? index) onChange;
  final double height; // Only height is specified, width is dynamic
  final double? SelectionContainerHeight;
  final double? unSelectionContainerHeight;
  final Duration? SelectionContainerAnimationDuration;
  final double? SelectionContainerWidth;
  final double? unSelectionContainerWidth;
  final double? SelectionContainerPadding;
  final double? unSelectionContainerPadding;
  final double? SelectionContainerCircularRadius;
  final double? unSelectionContainerCircularRadius;
  final double? BarCircularRadius;
  final BoxBorder? SelectedContainerBorder;
  final BoxBorder? unSelectedContainerBorder;
  final Gradient? SelectionContainerGradient;
  final Gradient? unSelectionContainerGradient;
  final BoxBorder? BarBorder;
  final Gradient? BarGradient;
  final Duration? ScrollDuration;
  final Color? barColor;
  final Color? selectedContainerColor;
  final Color? unselectedContainerColor;
  final List<BoxShadow>? BarShadow;
  final double? betweenSpaces; // Spacing between widgets
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
                  duration: widget.SelectionContainerAnimationDuration,
                  padding: EdgeInsets.all(widget.SelectionContainerPadding ?? 0),
                  alignment: Alignment.center,
                  height: widget.SelectionContainerHeight ?? 60,
                  width: widget.SelectionContainerWidth ?? 60,
                  circularRadius: widget.SelectionContainerCircularRadius ?? 15,
                  border: (PageIndex == index)
                      ? widget.SelectedContainerBorder
                      : widget.unSelectedContainerBorder,
                  gradient: widget.SelectionContainerGradient,
                  color: (PageIndex == index)
                      ? widget.selectedContainerColor ?? const Color.fromARGB(255, 0, 0, 0)
                      : widget.unselectedContainerColor ?? Colors.transparent,
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