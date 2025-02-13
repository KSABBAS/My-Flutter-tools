// import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyColumnWidgetSelector.dart';
// import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyRowWidgetSelector.dart';
// // import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
// // import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// class PageViewNavBar extends StatefulWidget {
//   PageViewNavBar(
//       {super.key,
//       required this.pages,
//       required this.iconsList,
//       this.orientation,
//       required this.height,
//       required this.width,
//       this.barColor,
//       this.selectedContainerColor,
//       this.pageBackgroundColor,
//       this.unselectedContainerColor,
//       this.SelectionContainerHeight,
//       this.unSelectionContainerHeight,
//       this.SelectionContainerWidth,
//       this.unSelectionContainerWidth,
//       this.SelectionContainerPadding,
//       this.unSelectionContainerPadding,
//       this.BackgroundImage,
//       this.BarShadow,
//       this.BarBorder,
//       this.BarGradient,
//       this.SelectedContainerBorder,
//       this.unSelectedContainerBorder,
//       this.SelectionContainerCircularRadius,
//       this.unSelectionContainerCircularRadius,
//       this.SelectionContainerGradient,
//       this.unSelectionContainerGradient,
//       required this.onPageChange,
//       this.ScrollDuration,
//       this.SelectionContainerAnimationDuration,
//       this.NavBarPositionBottom,
//       this.NavBarPositionLeft,
//       this.NavBarPositionRight,
//       this.NavBarPositionTop,
//       this.BetweenSpaces,
//       this.reverseDirection,
//       this.BarborderRadius
//       });
//   List<Widget> pages;
//   List<Widget> iconsList;
//   String? orientation;
//   Function(int? index) onPageChange;
//   double height;
//   double width;
//   double? NavBarPositionTop;
//   double? NavBarPositionBottom;
//   double? NavBarPositionLeft;
//   double? NavBarPositionRight;
//   double? SelectionContainerHeight;
//   double? unSelectionContainerHeight;
//   Duration? SelectionContainerAnimationDuration;
//   double? SelectionContainerWidth;
//   double? unSelectionContainerWidth;
//   double? SelectionContainerPadding;
//   double? unSelectionContainerPadding;
//   double? SelectionContainerCircularRadius;
//   double? unSelectionContainerCircularRadius;
//   BorderRadiusGeometry? BarborderRadius;
//   BoxBorder? SelectedContainerBorder;
//   BoxBorder? unSelectedContainerBorder;
//   Gradient? SelectionContainerGradient;
//   Gradient? unSelectionContainerGradient;
//   BoxBorder? BarBorder;
//   Gradient? BarGradient;
//   Duration? ScrollDuration;
//   Color? barColor;
//   Color? selectedContainerColor;
//   Color? unselectedContainerColor;
//   Color? pageBackgroundColor;
//   Widget? BackgroundImage;
//   List<BoxShadow>? BarShadow;
//   double? BetweenSpaces;
//   bool? reverseDirection;
//   @override
//   State<PageViewNavBar> createState() => _PageViewNavBarState();
// }

// class _PageViewNavBarState extends State<PageViewNavBar> {
//   int PageIndex = 0;
//   PageController? _pageController;
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(
//       initialPage: 0,
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _pageController!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     late Widget BarBody;
//     if (widget.orientation == "H") {
//       BarBody = Stack(
//         children: [
//           CMaker(
//               height: double.infinity,
//               color: widget.pageBackgroundColor ?? Colors.transparent,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   (widget.BackgroundImage != null)
//                       ? SizedBox(
//                           height: double.infinity,
//                           width: double.infinity,
//                           child: widget.BackgroundImage!)
//                       : Container(),
//                   PageView(
//                     onPageChanged: (value) {
//                       setState(() {
//                         PageIndex = value;
//                         widget.onPageChange(value);
//                       });
//                     },
//                     controller: _pageController,
//                     children: widget.pages,
//                   ),
//                 ],
//               )),
//           Positioned(
//             top: widget.NavBarPositionTop,
//             left: widget.NavBarPositionLeft,
//             bottom: widget.NavBarPositionBottom,
//             right: widget.NavBarPositionRight,
//             child: MyColumnWidgetSelector(
//                 barColor: widget.barColor,
//                 reverseDirection: widget.reverseDirection,
//                 iconsList: widget.iconsList,
//                 height: widget.height,
//                 width: widget.width,
//                 onChange: widget.onPageChange,
//                 BarBorder: widget.BarBorder,
//                 BarGradient: widget.BarGradient,
//                 BarShadow: widget.BarShadow,
//                 BarborderRadius: widget.BarborderRadius,
//                 BetweenSpaces: widget.BetweenSpaces,
//                 ScrollDuration: widget.ScrollDuration,
//                 SelectedContainerBorder: widget.SelectedContainerBorder,
//                 SelectionContainerAnimationDuration: widget.SelectionContainerAnimationDuration,
//                 SelectionContainerCircularRadius: widget.SelectionContainerCircularRadius,
//                 SelectionContainerGradient: widget.SelectionContainerGradient,
//                 SelectionContainerHeight: widget.SelectionContainerHeight,
//                 SelectionContainerPadding: widget.SelectionContainerPadding,
//                 SelectionContainerWidth: widget.SelectionContainerWidth,
//                 selectedContainerColor: widget.selectedContainerColor,
//                 unSelectedContainerBorder: widget.unSelectedContainerBorder,
//                 unSelectionContainerCircularRadius: widget.unSelectionContainerCircularRadius,
//                 unSelectionContainerGradient: widget.unSelectionContainerGradient,
//                 unSelectionContainerHeight: widget.unSelectionContainerHeight,
//                 unSelectionContainerPadding: widget.unSelectionContainerPadding,
//                 unSelectionContainerWidth: widget.unSelectionContainerWidth,
//                 unselectedContainerColor: widget.unselectedContainerColor,
//               )
//           ),
//         ],
//       );
//     } else {
//       BarBody = Stack(
//         children: [
//           CMaker(
//               height: double.infinity,
//               color: widget.pageBackgroundColor ?? Colors.transparent,
//               width: double.infinity,
//               child: Stack(
//                 children: [
//                   (widget.BackgroundImage != null)
//                       ? SizedBox(
//                           height: double.infinity,
//                           width: double.infinity,
//                           child: widget.BackgroundImage!)
//                       : Container(),
//                   PageView(
//                     onPageChanged: (value) {
//                       setState(() {
//                         PageIndex = value;
//                       });
//                       widget.onPageChange(value);
//                     },
//                     controller: _pageController,
//                     children: widget.pages,
//                   ),
//                 ],
//               )),
//           Positioned(
//               top: widget.NavBarPositionTop,
//               left: widget.NavBarPositionLeft,
//               bottom: widget.NavBarPositionBottom,
//               right: widget.NavBarPositionRight,
//               child: MyRowWidgetSelector(
//                 barColor: widget.barColor,
//                 reverseDirection: widget.reverseDirection,
//                 iconsList: widget.iconsList,
//                 height: widget.height,
//                 width: widget.width,
//                 onChange: widget.onPageChange,
//                 BarBorder: widget.BarBorder,
//                 BarGradient: widget.BarGradient,
//                 BarShadow: widget.BarShadow,
//                 BarborderRadius: widget.BarborderRadius,
//                 BetweenSpaces: widget.BetweenSpaces,
//                 ScrollDuration: widget.ScrollDuration,
//                 SelectedContainerBorder: widget.SelectedContainerBorder,
//                 SelectionContainerAnimationDuration: widget.SelectionContainerAnimationDuration,
//                 SelectionContainerCircularRadius: widget.SelectionContainerCircularRadius,
//                 SelectionContainerGradient: widget.SelectionContainerGradient,
//                 SelectionContainerHeight: widget.SelectionContainerHeight,
//                 SelectionContainerPadding: widget.SelectionContainerPadding,
//                 SelectionContainerWidth: widget.SelectionContainerWidth,
//                 selectedContainerColor: widget.selectedContainerColor,
//                 unSelectedContainerBorder: widget.unSelectedContainerBorder,
//                 unSelectionContainerCircularRadius: widget.unSelectionContainerCircularRadius,
//                 unSelectionContainerGradient: widget.unSelectionContainerGradient,
//                 unSelectionContainerHeight: widget.unSelectionContainerHeight,
//                 unSelectionContainerPadding: widget.unSelectionContainerPadding,
//                 unSelectionContainerWidth: widget.unSelectionContainerWidth,
//                 unselectedContainerColor: widget.unselectedContainerColor,
//                 )),
//         ],
//       );
//     }
//     return BarBody;
//   }
// }