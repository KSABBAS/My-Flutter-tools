import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';

class MyExpandingColumnWidgetSelector extends StatefulWidget {
  MyExpandingColumnWidgetSelector(
      {super.key,
      required this.iconsList,
      required this.width,
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
      this.BarborderRadius,
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
      this.BetweenSpaces,
      this.reverseDirection});
  List<Widget> iconsList;
  Function(int? index) onChange;
  double width;
  double? SelectionContainerHeight;
  double? unSelectionContainerHeight;
  Duration? SelectionContainerAnimationDuration;
  double? SelectionContainerWidth;
  double? unSelectionContainerWidth;
  double? SelectionContainerPadding;
  double? unSelectionContainerPadding;
  double? SelectionContainerCircularRadius;
  double? unSelectionContainerCircularRadius;
  BorderRadiusGeometry? BarborderRadius;
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
  List<BoxShadow>? BarShadow;
  double? BetweenSpaces;
  bool? reverseDirection;
  double? BarCircularRadius;
  double? betweenSpaces;

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
                          padding: EdgeInsets.all(
                              widget.SelectionContainerPadding ?? 0),
                          alignment: Alignment.center,
                          height: widget.SelectionContainerHeight ?? 60,
                          width: widget.SelectionContainerWidth ?? 60,
                          circularRadius:
                              widget.SelectionContainerCircularRadius ?? 15,
                          border: (PageIndex == index)
                              ? widget.SelectedContainerBorder
                              : widget.unSelectedContainerBorder,
                          gradient: widget.SelectionContainerGradient,
                          color: (PageIndex == index)
                              ? widget.selectedContainerColor ??
                                  const Color.fromARGB(255, 0, 0, 0)
                              : widget.unselectedContainerColor ??
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
