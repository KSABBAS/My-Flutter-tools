import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:my_tools_development/MyTools/tools/builder_tools/Specific_height_width_grid.dart';
// class SearchAppBar extends StatefulWidget {
//   SearchAppBar(
//       {super.key,
//       required this.crossAxisCount,
//       required this.childHeight,
//       this.appBarHeight,
//       this.appBarColor,
//       this.body,
//       this.Scroll,
//       this.childAlignment,
//       this.childBackGroundimage,
//       this.childBorder,
//       this.childBoxShadow,
//       this.childCircularRadius,
//       this.childColor,
//       this.childGradient,
//       this.childPadding,
//       this.childWidth,
//       this.columnSpaces,
//       required this.onSelected,
//       this.rowSpaces,
//       required this.builder,
//       required this.itemCount,
//       this.FilterWidget,
//       this.SortWidget,
//       this.SubAppBarVisible,
//       this.onTheSearch,
//       this.OnTheRightWidget,
//       this.SearchIcon,
//       this.SearchIconVisible,
//       this.barLeftPadding,
//       this.barRightPadding,
//       this.paddingBetweenSearchBarAndRightWidget,
//       this.onValueChange,
//       this.onSearchTapped,
//       this.OnTheLeftWidget,
//       this.paddingBetweenSearchBarAndLeftWidget});
//   double? appBarHeight;
//   Color? appBarColor;
//   Widget? body;
//   int crossAxisCount;
//   double childHeight;
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
//   bool? Scroll;
//   Widget Function(int Index) builder;
//   Function(bool isOnTheSearch, String SearchText)? onTheSearch;
//   Function(String value)? onValueChange;
//   int itemCount;
//   Widget? FilterWidget;
//   Widget? SortWidget;
//   bool? SubAppBarVisible;
//   bool? SearchIconVisible;
//   Icon? SearchIcon;
//   Widget? OnTheRightWidget;
//   Widget? OnTheLeftWidget;
//   Function(int SelectedIndex) onSelected;
//   Function()? onSearchTapped;
//   double? barLeftPadding;
//   double? barRightPadding;
//   double? paddingBetweenSearchBarAndRightWidget;
//   double? paddingBetweenSearchBarAndLeftWidget;
//   @override
//   State<SearchAppBar> createState() => _SearchAppBarState();
// }

// class _SearchAppBarState extends State<SearchAppBar> {
//   bool inSearch = false;
//   String SearchText = "";
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       height: double.infinity,
//       width: double.infinity,
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(
//                 left: widget.barLeftPadding ?? 30,
//                 right: widget.barRightPadding ?? 30),
//             color: widget.appBarColor ?? Colors.blue,
//             height: widget.appBarHeight ?? 100,
//             width: double.infinity,
//             child: Column(
//               children: [
//                 Spacer(),
//                 Row(
//                   children: [
//                     (widget.OnTheLeftWidget != null)
//                         ? widget.OnTheLeftWidget!
//                         : Container(),
//                     (widget.OnTheLeftWidget != null)
//                         ? Padding(
//                             padding: EdgeInsets.only(
//                                 left: widget
//                                         .paddingBetweenSearchBarAndLeftWidget ??
//                                     20))
//                         : Container(),
//                     (inSearch)
//                         ? IconButton(
//                             onPressed: () {
//                               if (widget.onTheSearch != null) {
//                                 inSearch = false;
//                                 widget.onTheSearch!(inSearch, SearchText);
//                               }
//                             },
//                             icon: Icon(Icons.arrow_back))
//                         : Container(),
//                     (inSearch)
//                         ? Padding(padding: EdgeInsets.only(left: 10))
//                         : Container(),
//                     Expanded(
//                       child: CMaker(
//                         circularRadius: 5,
//                         color: Colors.white,
//                         child: TextFormField(
//                           textAlign: TextAlign.right,
//                           onChanged: (value) {
//                             SearchText = value;
//                             if (widget.onValueChange != null) {
//                               widget.onValueChange!(value);
//                             }
//                           },
//                           onFieldSubmitted: (value) {
//                             inSearch = true;
//                             if (widget.onTheSearch != null) {
//                               widget.onTheSearch!(inSearch, SearchText);
//                             }
//                           },
//                           onTap: () {
//                             if (widget.onSearchTapped != null) {
//                               widget.onSearchTapped!();
//                             }
//                           },
//                           decoration: InputDecoration(
//                               prefixIcon: (widget.SearchIconVisible ?? true)
//                                   ? InkWell(
//                                       onTap: () {
//                                         inSearch = true;
//                                         if (widget.onTheSearch != null) {
//                                           widget.onTheSearch!(
//                                               inSearch, SearchText);
//                                         }
//                                       },
//                                       child: widget.SearchIcon ??
//                                           Icon(Icons.search))
//                                   : null,
//                               hintText: "بحث",
//                               enabledBorder: OutlineInputBorder(),
//                               border: OutlineInputBorder(),
//                               disabledBorder: OutlineInputBorder(),
//                               focusedBorder: OutlineInputBorder()),
//                         ),
//                       ),
//                     ),
//                     (widget.OnTheRightWidget != null)
//                         ? Padding(
//                             padding: EdgeInsets.only(
//                                 left: widget
//                                         .paddingBetweenSearchBarAndRightWidget ??
//                                     20))
//                         : Container(),
//                     (widget.OnTheRightWidget != null)
//                         ? widget.OnTheRightWidget!
//                         : Container(),
//                   ],
//                 ),
//                 Spacer(),
//               ],
//             ),
//           ),
//           Expanded(
//               child: Container(
//             width: double.infinity,
//             child: (inSearch)
//                 ? _SearchPage(
//                     builder: widget.builder,
//                     itemCount: widget.itemCount,
//                     crossAxisCount: widget.crossAxisCount,
//                     childHeight: widget.childHeight,
//                     Scroll: widget.Scroll,
//                     childAlignment: widget.childAlignment,
//                     childBackGroundimage: widget.childBackGroundimage,
//                     childBorder: widget.childBorder,
//                     childBoxShadow: widget.childBoxShadow,
//                     childCircularRadius: widget.childCircularRadius,
//                     childColor: widget.childColor,
//                     childGradient: widget.childGradient,
//                     childPadding: widget.childPadding,
//                     childWidth: widget.childWidth,
//                     columnSpaces: widget.columnSpaces,
//                     rowSpaces: widget.rowSpaces,
//                     onSelected: (index) {
//                       widget.onSelected(index);
//                     },
//                     FilterWidget: widget.FilterWidget,
//                     SortWidget: widget.SortWidget,
//                     SubAppBarVisible: widget.SubAppBarVisible,
//                   )
//                 : widget.body ?? Container(),
//           ))
//         ],
//       ),
//     );
//   }
// }

// class _SearchPage extends StatefulWidget {
//   _SearchPage({
//     super.key,
//     required this.crossAxisCount,
//     required this.childHeight,
//     this.Scroll,
//     this.childAlignment,
//     this.childBackGroundimage,
//     this.childBorder,
//     this.childBoxShadow,
//     this.childCircularRadius,
//     this.childColor,
//     this.childGradient,
//     this.childPadding,
//     this.childWidth,
//     this.columnSpaces,
//     this.onSelected,
//     this.rowSpaces,
//     required this.builder,
//     required this.itemCount,
//     this.FilterWidget,
//     this.SortWidget,
//     this.SubAppBarVisible,
//   });
//   Widget Function(int Index) builder;
//   int crossAxisCount;
//   double childHeight;
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
//   int itemCount;
//   bool? Scroll;
//   Widget? FilterWidget;
//   Widget? SortWidget;
//   bool? SubAppBarVisible;
//   Function(int SelectedIndex)? onSelected;
//   @override
//   State<_SearchPage> createState() => __SearchPageState();
// }

// class __SearchPageState extends State<_SearchPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           (widget.SubAppBarVisible ?? false)
//               ? Padding(
//                   padding: EdgeInsets.only(top: widget.columnSpaces ?? 20))
//               : Container(),
//           (widget.SubAppBarVisible ?? false)
//               ? Container(
//                   width: double.infinity,
//                   child: Row(
//                     children: [
//                       Padding(
//                           padding:
//                               EdgeInsets.only(left: widget.rowSpaces ?? 20)),
//                       (widget.FilterWidget != null)
//                           ? Container(
//                               child: widget.FilterWidget,
//                             )
//                           : Container(),
//                       Padding(padding: EdgeInsets.only(left: 20)),
//                       (widget.SortWidget != null)
//                           ? Container(
//                               child: widget.SortWidget,
//                             )
//                           : Container(),
//                       Spacer(),
//                       Text(
//                         "نتائج البحث",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       Padding(padding: EdgeInsets.only(left: 50)),
//                     ],
//                   ),
//                 )
//               : Container(),
//           Expanded(
//             child: Container(
//               child: WGridBuilder(
//                 builder: widget.builder,
//                 itemCount: widget.itemCount,
//                 crossAxisCount: widget.crossAxisCount,
//                 childHeight: widget.childHeight,
//                 Scroll: widget.Scroll,
//                 childAlignment: widget.childAlignment,
//                 childBackGroundimage: widget.childBackGroundimage,
//                 childBorder: widget.childBorder,
//                 childBoxShadow: widget.childBoxShadow,
//                 childCircularRadius: widget.childCircularRadius,
//                 childColor: widget.childColor,
//                 childGradient: widget.childGradient,
//                 childPadding: widget.childPadding,
//                 childWidth: widget.childWidth,
//                 columnSpaces: widget.columnSpaces,
//                 rowSpaces: widget.rowSpaces,
//                 onSelected: (index) {
//                   if (widget.onSelected != null) {
//                     widget.onSelected!(index);
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }