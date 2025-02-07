import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
class WGridBuilder extends StatefulWidget {
  WGridBuilder(
      {super.key,
      required this.builder,
      required this.itemCount,
      required this.crossAxisCount,
      this.onSelected,
      required this.childHeight,
      this.childWidth,
      this.rowSpaces,
      this.columnSpaces,
      this.childAlignment,
      this.childBackGroundimage,
      this.childBorder,
      this.childBoxShadow,
      this.childCircularRadius,
      this.childColor,
      this.childGradient,
      this.childPadding,
      this.Scroll});
  int crossAxisCount;
  Widget Function(int index) builder;
  int itemCount;
  double? childWidth;
  Color? childColor;
  AlignmentGeometry? childAlignment;
  EdgeInsetsGeometry? childPadding;
  DecorationImage? childBackGroundimage;
  List<BoxShadow>? childBoxShadow;
  Gradient? childGradient;
  BoxBorder? childBorder;
  double? childCircularRadius;
  double? rowSpaces;
  double? columnSpaces;
  double childHeight;
  bool? Scroll;
  Function(int SelectedIndex)? onSelected;
  @override
  State<WGridBuilder> createState() => _WGridBuilderState();
}

class _WGridBuilderState extends State<WGridBuilder> {
  @override
  Widget build(BuildContext context) {
    int adjustedItemCount = (widget.itemCount + widget.crossAxisCount - 1) ~/
        widget.crossAxisCount *
        widget.crossAxisCount;
    return SizedBox(
      height: (widget.itemCount.isEven)
          ? ((widget.childHeight * widget.itemCount) / 2) +
              ((widget.rowSpaces ?? 0 * widget.itemCount) +
                  ((widget.rowSpaces ?? 0) * (widget.itemCount / 2.0) + 0.0))
          : (((widget.childHeight * widget.itemCount) / 2) +
                  widget.childHeight / 2) +
              ((widget.rowSpaces ?? 0 * widget.itemCount) +
                  ((widget.rowSpaces ?? 0) * (widget.itemCount / 2.0).round() +
                      0.0)),
      child: ListView.builder(
        physics: (widget.Scroll == false)
            ? const NeverScrollableScrollPhysics()
            : null,
        shrinkWrap: widget.Scroll ?? true,
        itemCount: (adjustedItemCount / widget.crossAxisCount).round(),
        itemBuilder: (context, RowIndex) {
          return CMaker(
            margin: EdgeInsets.only(
                top: (RowIndex == 0)
                    ? widget.rowSpaces ?? 0
                    : (((widget.rowSpaces) ?? 0) / 2),
                bottom: ((RowIndex + 1) ==
                        (adjustedItemCount / widget.crossAxisCount).round())
                    ? (widget.rowSpaces ?? 0)
                    : (((widget.rowSpaces) ?? 0) / 2)),
            height: widget.childHeight ?? 150,
            width: widget.childWidth ?? 150.0 * widget.crossAxisCount,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.crossAxisCount,
                itemBuilder: (context, ColumnIndex) {
                  int currentIndex =
                      (widget.crossAxisCount * RowIndex) + ColumnIndex;
                  return (currentIndex >= widget.itemCount)
                      ? const SizedBox.shrink() // Placeholder for empty slot
                      : CMaker(
                          margin: EdgeInsets.only(
                              left: (ColumnIndex == 0)
                                  ? widget.columnSpaces ?? 0
                                  : (((widget.columnSpaces) ?? 0) / 2),
                              right:
                                  ((ColumnIndex + 1) == widget.crossAxisCount)
                                      ? (widget.columnSpaces ?? 0)
                                      : (((widget.columnSpaces) ?? 0) / 2)),
                          child: InkWell(
                            onTap: (widget.onSelected != null)
                                ? () {
                                    widget.onSelected!(currentIndex);
                                  }
                                : null,
                            child: CMaker(
                                padding: widget.childPadding,
                                boxShadow: widget.childBoxShadow,
                                BackGroundimage: widget.childBackGroundimage,
                                alignment: widget.childAlignment,
                                border: widget.childBorder,
                                gradient: widget.childGradient,
                                width: widget.childWidth ?? 150,
                                circularRadius:
                                    widget.childCircularRadius ?? 20,
                                color: widget.childColor ??
                                    const Color.fromARGB(96, 216, 216, 216),
                                child: widget.builder(currentIndex)),
                          ),
                        );
                }),
          );
        },
      ),
    );
  }
}