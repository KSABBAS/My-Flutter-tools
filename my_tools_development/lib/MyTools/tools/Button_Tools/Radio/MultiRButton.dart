import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';
// class MultiRButton extends StatefulWidget {
//   MultiRButton(
//       {super.key,
//       required this.list,
//       required this.crossAxisCount,
//       required this.onChanged,
//       this.mainAxisSpacing,
//       this.rowSpaces,
//       this.columnSpaces,
//       this.crossAxisSpacing,
//       this.childAlignment,
//       this.childBackGroundimage,
//       this.childBorder,
//       this.childBoxShadow,
//       this.childCircularRadius,
//       this.childColor,
//       this.childGradient,
//       required this.childHeight,
//       this.childPadding,
//       this.childWidth,
//       this.textAlign,
//       this.textColor,
//       this.textFontFamily,
//       this.textFontSize,
//       this.textFontWeight,
//       this.activeColor,
//       this.hoverColor,
//       this.tileColor,
//       this.Scroll});
//   List list;
//   int crossAxisCount;
//   double? mainAxisSpacing;
//   double? rowSpaces;
//   double? columnSpaces;
//   double? crossAxisSpacing;
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
//   Color? hoverColor;
//   Color? tileColor;
//   Color? activeColor;
//   bool? Scroll;
//   Function(dynamic SelectedValue) onChanged;
//   @override
//   State<MultiRButton> createState() => _MultiRButtonState();
// }

// class _MultiRButtonState extends State<MultiRButton> {
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
//                           height: widget.childHeight ?? 60,
//                           width: widget.childWidth ??
//                               150.0 * widget.crossAxisCount,
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
//                           padding: widget.childPadding,
//                           boxShadow: widget.childBoxShadow,
//                           BackGroundimage: widget.childBackGroundimage,
//                           alignment: widget.childAlignment ?? Alignment.center,
//                           border: widget.childBorder,
//                           gradient: widget.childGradient,
//                           width: widget.childWidth ?? 150,
//                           circularRadius: widget.childCircularRadius ?? 20,
//                           color: widget.childColor ??
//                               const Color.fromARGB(96, 216, 216, 216),
//                           child: RadioListTile(
//                               tileColor: widget.tileColor,
//                               activeColor: widget.activeColor,
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
//                               value: widget.list[
//                                   widget.crossAxisCount * RowIndex +
//                                       ColumnIndex],
//                               groupValue: selected,
//                               onChanged: (val) {
//                                 setState(() {
//                                   selected = val;
//                                   widget.onChanged(val);
//                                 });
//                               }),
//                         );
//                 }),
//           );
//         },
//       ),
//     );
//   }
// }