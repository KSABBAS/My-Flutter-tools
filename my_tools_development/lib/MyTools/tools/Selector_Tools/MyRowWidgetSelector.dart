import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:tix/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
// import 'package:tix/MyTools/tools/CMaker_Tools/CMaker.dart';
class MyRowWidgetSelector extends StatefulWidget {
  MyRowWidgetSelector({
    super.key,
    required this.iconsList,
    required this.height,
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
    this.BarborderRadius,
    this.BarGradient,
    required this.onChange,
    this.ScrollDuration,
    this.BetweenSpaces,
    this.reverseDirection
  });
  List<Widget> iconsList;
  Function(int? index) onChange;
  double height;
  double width;
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
  BorderRadiusGeometry? BarborderRadius;
  BoxBorder? BarBorder;
  Gradient? BarGradient;
  Duration? ScrollDuration;
  Color? barColor;
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
                                padding: 
                                    widget.SelectionContainerPadding ,
                                alignment: Alignment.center,
                                height: widget.SelectionContainerHeight ?? 60,
                                width: widget.SelectionContainerWidth ?? 60,
                                circularRadius:
                                    widget.SelectionContainerCircularRadius ??
                                        15,
                                border: (PageIndex == index)
                                    ? widget.SelectionContainerBorder
                                    : widget.unSelectedContainerBorder,
                                gradient: widget.SelectionContainerGradient,
                                color: (PageIndex == index)
                                    ? widget.SelectionContainerColor ??
                                        const Color.fromARGB(255, 0, 0, 0)
                                    : widget.unSelectedContainerColor ??
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