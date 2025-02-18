import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// class WGrid extends StatefulWidget {
//   WGrid(
//       {super.key,
//       required this.list,
//       required this.crossAxisCount,
//       this.onSelected,
//       this.childHeight,
//       this.childWidth,
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
//       this.childPadding});
//   List<Widget> list;
//   int crossAxisCount;
//   double? mainAxisSpacing;
//   double? childWidth;
//   Color? childColor;
//   AlignmentGeometry? childAlignment;
//   EdgeInsetsGeometry? childPadding;
//   DecorationImage? childBackGroundimage;
//   List<BoxShadow>? childBoxShadow;
//   Gradient? childGradient;
//   BoxBorder? childBorder;
//   double? childCircularRadius;
//   double? rowSpaces;
//   double? columnSpaces;
//   double? crossAxisSpacing;
//   double? childHeight;
//   Function(int SelectedIndex)? onSelected;
//   @override
//   State<WGrid> createState() => _WGridState();
// }

// class _WGridState extends State<WGrid> {
//   var selected = "";
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: (widget.list.length / widget.crossAxisCount).round(),
//       itemBuilder: (context, RowIndex) {
//         return CMaker(
//           margin: EdgeInsets.only(
//               top: (RowIndex == 0)
//                   ? widget.rowSpaces ?? 0
//                   : (((widget.rowSpaces) ?? 0) / 2),
//               bottom: ((RowIndex + 1) ==
//                       (widget.list.length / widget.crossAxisCount).round())
//                   ? (widget.rowSpaces ?? 0)
//                   : (((widget.rowSpaces) ?? 0) / 2)),
//           height: widget.childHeight ?? 150,
//           width: widget.childWidth ?? 150.0 * widget.crossAxisCount,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.crossAxisCount,
//               itemBuilder: (context, ColumnIndex) {
//                 return ((widget.list.length % widget.crossAxisCount) != 0 &&
//                         widget.list.length ==
//                             ((widget.crossAxisCount * RowIndex + ColumnIndex)))
//                     ? Container(
//                         width: widget.childWidth ?? 150,
//                       )
//                     : CMaker(
//                         margin: EdgeInsets.only(
//                             left: (ColumnIndex == 0)
//                                 ? widget.columnSpaces ?? 0
//                                 : (((widget.columnSpaces) ?? 0) / 2),
//                             right: ((ColumnIndex + 1) == widget.crossAxisCount)
//                                 ? (widget.columnSpaces ?? 0)
//                                 : (((widget.columnSpaces) ?? 0) / 2)),
//                         child: InkWell(
//                           onTap: (widget.onSelected != null)
//                               ? () {
//                                   widget.onSelected!(
//                                       (widget.crossAxisCount * RowIndex +
//                                           ColumnIndex));
//                                 }
//                               : null,
//                           child: CMaker(
//                               padding: widget.childPadding,
//                               boxShadow: widget.childBoxShadow,
//                               BackGroundimage: widget.childBackGroundimage,
//                               alignment: widget.childAlignment,
//                               border: widget.childBorder,
//                               gradient: widget.childGradient,
//                               width: widget.childWidth ?? 150,
//                               circularRadius: widget.childCircularRadius ?? 20,
//                               color: widget.childColor ??
//                                   Color.fromARGB(96, 216, 216, 216),
//                               child: widget.list[
//                                   (widget.crossAxisCount * RowIndex +
//                                       ColumnIndex)]),
//                         ),
//                       );
//               }),
//         );
//       },
//     );
//   }
// }