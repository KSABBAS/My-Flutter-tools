import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';
// class MultiCBox extends StatefulWidget {
//   MultiCBox(
//       {super.key,
//       required this.list,
//       required this.crossAxisCount,
//       required this.onChanged,
//       this.mainAxisSpacing,
//       this.rowSpaces,
//       this.columnSpaces,
//       this.crossAxisSpacing,
//       this.maxNumber,
//       this.childAlignment,
//       this.childBackGroundimage,
//       this.childBorder,
//       this.childBoxShadow,
//       this.childCircularRadius,
//       this.childColor,
//       this.childGradient,
//       required this.childHeight,
//       this.childWidth,
//       this.childPadding,
//       this.textAlign,
//       this.textColor,
//       this.textFontFamily,
//       this.textFontSize,
//       this.textFontWeight,
//       this.Scroll});
//   List list;
//   int crossAxisCount;
//   double? mainAxisSpacing;
//   double? rowSpaces;
//   double? columnSpaces;
//   double? crossAxisSpacing;
//   int? maxNumber;
//   double? childWidth;
//   double childHeight;
//   Color? childColor;
//   AlignmentGeometry? childAlignment;
//   EdgeInsetsGeometry? childPadding;
//   DecorationImage? childBackGroundimage;
//   List<BoxShadow>? childBoxShadow;
//   Gradient? childGradient;
//   BoxBorder? childBorder;
//   double? childCircularRadius;
//   double? textFontSize;
//   FontWeight? textFontWeight;
//   Color? textColor;
//   TextAlign? textAlign;
//   String? textFontFamily;
//   bool? Scroll;
//   Function(List SelectedValues) onChanged;
//   @override
//   State<MultiCBox> createState() => _MultiCBoxState();
// }

// class _MultiCBoxState extends State<MultiCBox> {
//   List selectedItems = [];
//   var selected = "";
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: (widget.list.length.isEven)
//           ? ((widget.childHeight * widget.list.length) / 2) +
//               ((widget.rowSpaces ?? 0 * widget.list.length) +
//                   ((widget.rowSpaces ?? 0) * (widget.list.length / 2.0) + 0.0))
//           : (((widget.childHeight * widget.list.length) / 2) +
//                   widget.childHeight / 2) +
//               ((widget.rowSpaces ?? 0 * widget.list.length) +
//                   ((widget.rowSpaces ?? 0) *
//                           (widget.list.length / 2.0).round() +
//                       0.0)),
//       child: ListView.builder(
//         physics: (widget.Scroll == false)
//             ? const NeverScrollableScrollPhysics()
//             : null,
//         shrinkWrap: widget.Scroll ?? true,
//         itemCount: (widget.list.length / widget.crossAxisCount).round(),
//         itemBuilder: (context, RowIndex) {
//           return CMaker(
//             margin: EdgeInsets.only(
//                 top: (RowIndex == 0)
//                     ? widget.rowSpaces ?? 0
//                     : (((widget.rowSpaces) ?? 0) / 2),
//                 bottom: ((RowIndex + 1) ==
//                         (widget.list.length / widget.crossAxisCount).round())
//                     ? (widget.rowSpaces ?? 0)
//                     : (((widget.rowSpaces) ?? 0) / 2)),
//             height: widget.childHeight ?? 60,
//             width: widget.childWidth ?? 150.0 * widget.crossAxisCount,
//             child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: widget.crossAxisCount,
//                 itemBuilder: (context, ColumnIndex) {
//                   return ((widget.list.length % widget.crossAxisCount) != 0 &&
//                           widget.list.length ==
//                               ((widget.crossAxisCount * RowIndex +
//                                   ColumnIndex)))
//                       ? CMaker(
//                           width: widget.childWidth ?? 150,
//                         )
//                       : CMaker(
//                           margin: EdgeInsets.only(
//                               left: (ColumnIndex == 0)
//                                   ? widget.columnSpaces ?? 0
//                                   : (((widget.columnSpaces) ?? 0) / 2),
//                               right:
//                                   ((ColumnIndex + 1) == widget.crossAxisCount)
//                                       ? (widget.columnSpaces ?? 0)
//                                       : (((widget.columnSpaces) ?? 0) / 2)),
//                           child: CMaker(
//                             padding: widget.childPadding,
//                             boxShadow: widget.childBoxShadow,
//                             BackGroundimage: widget.childBackGroundimage,
//                             alignment: widget.childAlignment,
//                             border: widget.childBorder,
//                             gradient: widget.childGradient,
//                             width: widget.childWidth ?? 150,
//                             circularRadius: widget.childCircularRadius ?? 20,
//                             color: widget.childColor ??
//                                 const Color.fromARGB(96, 216, 216, 216),
//                             child: CheckboxListTile(
//                               activeColor:
//                                   const Color.fromARGB(255, 74, 193, 241),
//                               title: TMaker(
//                                 text: widget.list[
//                                     widget.crossAxisCount * RowIndex +
//                                         ColumnIndex],
//                                 color: widget.textColor ?? Colors.black,
//                                 fontSize: widget.textFontSize ?? 17,
//                                 fontWeight:
//                                     widget.textFontWeight ?? FontWeight.w500,
//                                 fontFamily: widget.textFontFamily,
//                                 textAlign: widget.textAlign,
//                               ),
//                               value: (selectedItems.contains(widget.list[
//                                       widget.crossAxisCount * RowIndex +
//                                           ColumnIndex]))
//                                   ? true
//                                   : false,
//                               onChanged: (value) {
//                                 if (value! &&
//                                     ((widget.maxNumber != null)
//                                         ? selectedItems.length <
//                                             widget.maxNumber!
//                                         : true)) {
//                                   selectedItems.add(widget.list[
//                                       widget.crossAxisCount * RowIndex +
//                                           ColumnIndex]);
//                                 } else {
//                                   selectedItems.remove(widget.list[
//                                       widget.crossAxisCount * RowIndex +
//                                           ColumnIndex]);
//                                 }
//                                 widget.onChanged(selectedItems);
//                                 setState(() {});
//                               },
//                             ),
//                           ),
//                         );
//                 }),
//           );
//         },
//       ),
//     );
//   }
// }