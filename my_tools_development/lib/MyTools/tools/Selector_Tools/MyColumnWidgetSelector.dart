import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';

class MyColumnWidgetSelector extends StatefulWidget {
  MyColumnWidgetSelector({
    super.key,
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
    this.BetweenSpaces,
    this.reverseDirection
  });
  List<Widget> iconsList;
  String? orientation;
  Function(int? index) onChange;
  double height;
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
  List<BoxShadow>? BarShadow;
  double? BetweenSpaces;
  bool? reverseDirection;
  @override
  State<MyColumnWidgetSelector> createState() => _MyColumnWidgetSelectorState();
}

class _MyColumnWidgetSelectorState extends State<MyColumnWidgetSelector> {
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
                              (widget.SelectionContainerHeight ?? 60))) /
                      (widget.iconsList.length + 1),
            ),
            CMaker(
              boxShadow: widget.BarShadow,
              height: widget.height -
                  (widget.height -
                          (widget.iconsList.length *
                              (widget.SelectionContainerHeight ?? 60))) /
                      (widget.iconsList.length + 1),
              child: ListView.builder(
                reverse:widget.reverseDirection?? false,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: false,
                itemCount: widget.iconsList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          PageIndex = index;
                          widget.onChange(index);
                        },
                        child: CMaker(
                            alignment: Alignment.center,
                            child: ACMaker(
                                duration:
                                    widget.SelectionContainerAnimationDuration,
                                padding: EdgeInsets.all(
                                    widget.SelectionContainerPadding ?? 0),
                                alignment: Alignment.center,
                                height: widget.SelectionContainerHeight ?? 60,
                                width: widget.SelectionContainerWidth ?? 60,
                                circularRadius:
                                    widget.SelectionContainerCircularRadius ??
                                        15,
                                border: (PageIndex == index)
                                    ? widget.SelectedContainerBorder
                                    : widget.unSelectedContainerBorder,
                                gradient: widget.SelectionContainerGradient,
                                color: (PageIndex == index)
                                    ? widget.selectedContainerColor ??
                                        const Color.fromARGB(255, 0, 0, 0)
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
    );
  }
}
