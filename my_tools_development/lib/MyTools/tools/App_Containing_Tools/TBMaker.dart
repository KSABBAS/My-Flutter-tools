import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/Functions/Height_and_width_Functions.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// class TBMaker extends StatefulWidget {
//   TBMaker(
//       {super.key,
//       required this.tabsList,
//       required this.pagesList,
//       this.onChanged,
//       this.initIndex,
//       this.tabsAlignment,
//       this.tabsBackGroundimage,
//       this.tabsBorder,
//       this.tabsBoxShadow,
//       this.tabsCircularRadius,
//       this.tabsColor,
//       this.tabsGradient,
//       this.tabsHeight,
//       this.tabsMargin,
//       this.tabsPadding,
//       this.tabsWidth,
//       this.Scrollable,
//       this.tabsRowPadding,
//       required this.height,
//       this.width,
//       this.indicatorWeight,
//       this.selectedTabDecoration,
//       this.indicatorColor});
//   Function(int Index)? onChanged;
//   List<Widget> tabsList;
//   List<Widget> pagesList;
//   double? height;
//   double? width;
//   int? initIndex;
//   Color? tabsColor;
//   double? tabsHeight;
//   double? tabsWidth;
//   AlignmentGeometry? tabsAlignment;
//   EdgeInsetsGeometry? tabsPadding;
//   EdgeInsetsGeometry? tabsMargin;
//   DecorationImage? tabsBackGroundimage;
//   List<BoxShadow>? tabsBoxShadow;
//   Gradient? tabsGradient;
//   BoxBorder? tabsBorder;
//   double? tabsCircularRadius;
//   bool? Scrollable;
//   EdgeInsetsGeometry? tabsRowPadding;
//   BoxDecoration? selectedTabDecoration;
//   double? indicatorWeight;
//   Color? indicatorColor;
//   @override
//   State<TBMaker> createState() => _TBMakerState();
// }

// class _TBMakerState extends State<TBMaker> {
//   TabController? controller;
//   @override
//   Widget build(BuildContext context) {
//     return CMaker(
//       height: widget.height ?? 400,
//       width: widget.width ?? double.infinity,
//       child: DefaultTabController(
//           initialIndex: widget.initIndex ?? 0,
//           animationDuration: Duration(milliseconds: 600),
//           length: widget.tabsList.length,
//           child: Scaffold(
//             appBar: AppBar(
//               toolbarHeight: ((widget.tabsHeight) ?? 60) - 46,
//               bottom: TabBar(
//                   onTap: (value) {
//                     widget.onChanged!(value);
//                   },
//                   indicatorColor: widget.indicatorColor,
//                   indicator: widget.selectedTabDecoration,
//                   indicatorWeight: widget.indicatorWeight ?? 1,
//                   indicatorSize: TabBarIndicatorSize.label,
//                   isScrollable: widget.Scrollable ?? false,
//                   padding: widget.tabsRowPadding,
//                   tabs: () {
//                     List<Widget>? list = [];
//                     for (int i = 0; i < widget.tabsList.length; i++) {
//                       list.add(CMaker(
//                           BackGroundimage: widget.tabsBackGroundimage,
//                           alignment: widget.tabsAlignment ?? Alignment.center,
//                           boxShadow: widget.tabsBoxShadow,
//                           circularRadius: widget.tabsCircularRadius ?? 20,
//                           color: widget.tabsColor,
//                           gradient: widget.tabsGradient,
//                           height: widget.tabsHeight ?? 60,
//                           width: widget.tabsWidth ??
//                               PageWidth(context) / widget.tabsList.length,
//                           margin: widget.tabsMargin,
//                           padding: widget.tabsPadding,
//                           border: widget.tabsBorder ?? Border.all(),
//                           child: widget.tabsList[i]));
//                     }
//                     return list;
//                   }()),
//             ),
//             body: TabBarView(children: () {
//               List<Widget>? list = [];
//               for (int i = 0; i < widget.tabsList.length; i++) {
//                 list.add(widget.pagesList[i]);
//               }
//               return list;
//             }()),
//           )),
//     );
//   }
// }