// import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyColumnWidgetSelector.dart';
// import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyRowWidgetSelector.dart';

// class NavBar extends StatefulWidget {
//   NavBar({
//     super.key,
//     required this.pages,
//     required this.iconsList,
//     this.orientation,
//     required this.height,
//     required this.width,
//     this.barColor,
//     this.selectedContainerColor,
//     this.pageBackgroundColor,
//     this.unselectedContainerColor,
//     this.SelectionContainerHeight,
//     this.unSelectedContainerHeight,
//     this.SelectionContainerWidth,
//     this.unSelectedContainerWidth,
//     this.SelectionContainerPadding,
//     this.unSelectedContainerPadding,
//     this.BackgroundImage,
//     this.BarShadow,
//     this.BarBorder,
//     this.BarGradient,
//     this.SelectedContainerBorder,
//     this.unSelectedContainerBorder,
//     this.SelectionContainerCircularRadius,
//     this.unSelectedContainerCircularRadius,
//     this.SelectionContainerGradient,
//     this.unSelectedContainerGradient,
//     required this.onPageChange,
//     this.ScrollDuration,
//     this.SelectionContainerAnimationDuration,
//     this.NavBarPositionBottom,
//     this.NavBarPositionLeft,
//     this.NavBarPositionRight,
//     this.NavBarPositionTop,
//     this.BetweenSpaces,
//     this.BarborderRadius,
//     this.reverseDirection,
//   });
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
//   double? unSelectedContainerHeight;
//   Duration? SelectionContainerAnimationDuration;
//   double? SelectionContainerWidth;
//   double? unSelectedContainerWidth;
//   double? SelectionContainerPadding;
//   double? unSelectedContainerPadding;
//   double? SelectionContainerCircularRadius;
//   double? unSelectedContainerCircularRadius;
//   BorderRadiusGeometry? BarborderRadius;
//   BoxBorder? SelectedContainerBorder;
//   BoxBorder? unSelectedContainerBorder;
//   Gradient? SelectionContainerGradient;
//   Gradient? unSelectedContainerGradient;
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
//   State<NavBar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   int PageIndex = 0;
//   @override
//   void initState() {
//     super.initState();
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
//                   widget.pages[PageIndex],
//                 ],
//               )),
//           Positioned(
//               top: widget.NavBarPositionTop,
//               left: widget.NavBarPositionLeft,
//               bottom: widget.NavBarPositionBottom,
//               right: widget.NavBarPositionRight,
//               child: MyColumnWidgetSelector(
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
//                 SelectionContainerBorder: widget.SelectedContainerBorder,
//                 SelectionContainerAnimationDuration: widget.SelectionContainerAnimationDuration,
//                 SelectionContainerCircularRadius: widget.SelectionContainerCircularRadius,
//                 SelectionContainerGradient: widget.SelectionContainerGradient,
//                 SelectionContainerHeight: widget.SelectionContainerHeight,
//                 SelectionContainerPadding: widget.SelectionContainerPadding,
//                 SelectionContainerWidth: widget.SelectionContainerWidth,
//                 SelectionContainerColor: widget.selectedContainerColor,
//                 unSelectedContainerBorder: widget.unSelectedContainerBorder,
//                 unSelectedContainerCircularRadius: widget.unSelectedContainerCircularRadius,
//                 unSelectedContainerGradient: widget.unSelectedContainerGradient,
//                 unSelectedContainerHeight: widget.unSelectedContainerHeight,
//                 unSelectedContainerPadding: widget.unSelectedContainerPadding,
//                 unSelectedContainerWidth: widget.unSelectedContainerWidth,
//                 unSelectedContainerColor: widget.unSelectedContainerColor,
//               )),
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
//                   widget.pages[PageIndex],
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
//                 SelectionContainerBorder: widget.SelectedContainerBorder,
//                 SelectionContainerAnimationDuration: widget.SelectionContainerAnimationDuration,
//                 SelectionContainerCircularRadius: widget.SelectionContainerCircularRadius,
//                 SelectionContainerGradient: widget.SelectionContainerGradient,
//                 SelectionContainerHeight: widget.SelectionContainerHeight,
//                 SelectionContainerPadding: widget.SelectionContainerPadding,
//                 SelectionContainerWidth: widget.SelectionContainerWidth,
//                 SelectionContainerColor: widget.selectedContainerColor,
//                 unSelectedContainerBorder: widget.unSelectedContainerBorder,
//                 unSelectedContainerCircularRadius: widget.unSelectedContainerCircularRadius,
//                 unSelectedContainerGradient: widget.unSelectedContainerGradient,
//                 unSelectedContainerHeight: widget.unSelectedContainerHeight,
//                 unSelectedContainerPadding: widget.unSelectedContainerPadding,
//                 unSelectedContainerWidth: widget.unSelectedContainerWidth,
//                 unSelectedContainerColor: widget.unselectedContainerColor,
//                 )),
//         ],
//       );
//     }
//     return BarBody;
//   }
// }
