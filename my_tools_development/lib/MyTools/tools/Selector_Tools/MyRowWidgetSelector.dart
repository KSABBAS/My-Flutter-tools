import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
class MyRowWidgetSelector extends StatefulWidget {
  MyRowWidgetSelector({
    super.key,
    required this.iconsList,
    required this.height,
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
    this.reverseDirection
  });
  List<Widget> iconsList;
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
  @override
  State<MyRowWidgetSelector> createState() => _MyRowWidgetSelectorState();
}

class _MyRowWidgetSelectorState extends State<MyRowWidgetSelector> {
  int PageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      boxShadow: widget.BarShadow,
      borderRadius: widget.BarborderRadius,
      border: widget.BarBorder,
      gradient: widget.BarGradient,
      color: widget.barColor ?? Colors.white,
      ),
      alignment: Alignment.center,
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
                              (widget.SelectionContainerWidth ?? 60))) /
                      (widget.iconsList.length + 1),
            ),
            CMaker(
              width: widget.width -
                  (widget.width -
                          (widget.iconsList.length *
                              (widget.SelectionContainerWidth ?? 60))) /
                      (widget.iconsList.length + 1),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                reverse:widget.reverseDirection?? false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: false,
                itemCount: widget.iconsList.length,
                itemBuilder: (context, index) {
                  return Row(
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
    );
  }
}