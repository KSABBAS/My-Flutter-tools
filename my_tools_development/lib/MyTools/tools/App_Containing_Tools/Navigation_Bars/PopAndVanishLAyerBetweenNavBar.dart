import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// class PopAndVanishLAyerBetweenNavBar extends StatefulWidget {
//   PopAndVanishLAyerBetweenNavBar(
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
//       this.BarCircularRadius,
//       this.BarGradient,
//       this.SelectedContainerBorder,
//       this.unSelectedContainerBorder,
//       this.SelectionContainerCircularRadius,
//       this.unSelectionContainerCircularRadius,
//       this.SelectionContainerGradient,
//       this.unSelectionContainerGradient,
//       this.onPageChange,
//       this.NavBarPositionBottom,
//       this.NavBarPositionLeft,
//       this.NavBarPositionRight,
//       this.NavBarPositionTop,
//       this.vanishDuration,
//       this.LayerBetween});
//   List<Widget> pages;
//   List<Widget> iconsList;
//   String? orientation;
//   Function(int index)? onPageChange;
//   double height;
//   double width;
//   Widget? LayerBetween;
//   double? NavBarPositionTop;
//   double? NavBarPositionBottom;
//   double? NavBarPositionLeft;
//   double? NavBarPositionRight;
//   double? SelectionContainerHeight;
//   double? unSelectionContainerHeight;
//   double? SelectionContainerWidth;
//   double? unSelectionContainerWidth;
//   double? SelectionContainerPadding;
//   double? unSelectionContainerPadding;
//   double? SelectionContainerCircularRadius;
//   double? unSelectionContainerCircularRadius;
//   double? BarCircularRadius;
//   BoxBorder? SelectedContainerBorder;
//   BoxBorder? unSelectedContainerBorder;
//   Gradient? SelectionContainerGradient;
//   Gradient? unSelectionContainerGradient;
//   BoxBorder? BarBorder;
//   Gradient? BarGradient;
//   Duration? vanishDuration;
//   Color? barColor;
//   Color? selectedContainerColor;
//   Color? unselectedContainerColor;
//   Color? pageBackgroundColor;
//   Widget? BackgroundImage;
//   List<BoxShadow>? BarShadow;
//   @override
//   State<PopAndVanishLAyerBetweenNavBar> createState() =>
//       _PopAndVanishLAyerBetweenNavBarState();
// }

// class _PopAndVanishLAyerBetweenNavBarState
//     extends State<PopAndVanishLAyerBetweenNavBar> {
//   int PageIndex = 0;
//   bool VanishIsOn = false;
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
//                       ? Container(
//                           height: double.infinity,
//                           width: double.infinity,
//                           child: widget.BackgroundImage!)
//                       : Container(),
//                   AnimatedOpacity(
//                     opacity: (VanishIsOn) ? 0 : 1,
//                     duration:
//                         widget.vanishDuration ?? Duration(milliseconds: 200),
//                     child: widget.pages[PageIndex],
//                   ),
//                 ],
//               )),
//           widget.LayerBetween ?? CMaker(),
//           Positioned(
//             top: widget.NavBarPositionTop,
//             left: widget.NavBarPositionLeft,
//             bottom: widget.NavBarPositionBottom,
//             right: widget.NavBarPositionRight,
//             child: CMaker(
//               boxShadow: widget.BarShadow,
//               circularRadius: widget.BarCircularRadius ?? 20,
//               border: widget.BarBorder,
//               alignment: Alignment.center,
//               gradient: widget.BarGradient,
//               color: widget.barColor ?? Colors.white,
//               height: widget.height,
//               width: widget.width,
//               child: Container(
//                 width: widget.SelectionContainerWidth,
//                 child: Column(
//                   children: [
//                     Container(
//                       height: (widget.height -
//                               (widget.iconsList.length *
//                                   (widget.SelectionContainerHeight ?? 60))) /
//                           (widget.iconsList.length + 1),
//                     ),
//                     CMaker(
//                       boxShadow: widget.BarShadow,
//                       height: widget.height -
//                           (widget.height -
//                                   (widget.iconsList.length *
//                                       (widget.SelectionContainerHeight ??
//                                           60))) /
//                               (widget.iconsList.length + 1),
//                       child: ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         physics: NeverScrollableScrollPhysics(),
//                         shrinkWrap: false,
//                         itemCount: widget.iconsList.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               InkWell(
//                                   onTap: () async {
//                                     if (index != PageIndex) {
//                                       setState(() => VanishIsOn = true);
//                                       await Future.delayed(widget
//                                               .vanishDuration ??
//                                           const Duration(milliseconds: 200));
//                                       setState(() {
//                                         PageIndex = index;
//                                         widget.onPageChange?.call(PageIndex);
//                                         VanishIsOn = false;
//                                       });
//                                     }
//                                   },
//                                   child: CMaker(
//                                       padding: EdgeInsets.all(
//                                           widget.SelectionContainerPadding ??
//                                               0),
//                                       alignment: Alignment.center,
//                                       height:
//                                           widget.SelectionContainerHeight ?? 60,
//                                       width:
//                                           widget.SelectionContainerWidth ?? 60,
//                                       circularRadius: widget
//                                               .SelectionContainerCircularRadius ??
//                                           15,
//                                       border: (PageIndex == index)
//                                           ? widget.SelectedContainerBorder ??
//                                               null
//                                           : widget.unSelectedContainerBorder ??
//                                               null,
//                                       gradient:
//                                           widget.SelectionContainerGradient,
//                                       color: (PageIndex == index)
//                                           ? widget.selectedContainerColor ??
//                                               Color.fromARGB(255, 0, 0, 0)
//                                           : widget.unselectedContainerColor ??
//                                               Colors.transparent,
//                                       child: widget.iconsList[index])),
//                               Container(
//                                 height: (widget.height -
//                                         (widget.iconsList.length *
//                                             (widget.SelectionContainerHeight ??
//                                                 60))) /
//                                     (widget.iconsList.length + 1),
//                               )
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
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
//                       ? Container(
//                           height: double.infinity,
//                           width: double.infinity,
//                           child: widget.BackgroundImage!)
//                       : Container(),
//                   AnimatedOpacity(
//                     opacity: (VanishIsOn) ? 0 : 1,
//                     duration:
//                         widget.vanishDuration ?? Duration(milliseconds: 200),
//                     child: widget.pages[PageIndex],
//                   ),
//                 ],
//               )),
//           widget.LayerBetween ?? CMaker(),
//           Positioned(
//               top: widget.NavBarPositionTop,
//               left: widget.NavBarPositionLeft,
//               bottom: widget.NavBarPositionBottom,
//               right: widget.NavBarPositionRight,
//               child: CMaker(
//                 boxShadow: widget.BarShadow,
//                 circularRadius: widget.BarCircularRadius ?? 20,
//                 border: widget.BarBorder,
//                 alignment: Alignment.center,
//                 gradient: widget.BarGradient,
//                 color: widget.barColor ?? Colors.white,
//                 height: widget.height,
//                 width: widget.width,
//                 child: Container(
//                   height: widget.SelectionContainerHeight,
//                   child: Row(
//                     children: [
//                       Container(
//                         width: (widget.width -
//                                 (widget.iconsList.length *
//                                     (widget.SelectionContainerWidth ?? 60))) /
//                             (widget.iconsList.length + 1),
//                       ),
//                       CMaker(
//                         width: widget.width -
//                             (widget.width -
//                                     (widget.iconsList.length *
//                                         (widget.SelectionContainerWidth ??
//                                             60))) /
//                                 (widget.iconsList.length + 1),
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: false,
//                           itemCount: widget.iconsList.length,
//                           itemBuilder: (context, index) {
//                             return Row(
//                               children: [
//                                 InkWell(
//                                   onTap: () async {
//                                     if (index != PageIndex) {
//                                       setState(() => VanishIsOn = true);
//                                       await Future.delayed(widget
//                                               .vanishDuration ??
//                                           const Duration(milliseconds: 200));
//                                       setState(() {
//                                         PageIndex = index;
//                                         widget.onPageChange?.call(PageIndex);
//                                         VanishIsOn = false;
//                                       });
//                                     }
//                                   },
//                                   child: CMaker(
//                                       alignment: Alignment.center,
//                                       child: CMaker(
//                                           padding: EdgeInsets.all(
//                                               widget.SelectionContainerPadding ??
//                                                   0),
//                                           alignment: Alignment.center,
//                                           height:
//                                               widget.SelectionContainerHeight ??
//                                                   60,
//                                           width: widget.SelectionContainerWidth ??
//                                               60,
//                                           circularRadius:
//                                               widget.SelectionContainerCircularRadius ??
//                                                   15,
//                                           border: (PageIndex == index)
//                                               ? widget.SelectedContainerBorder ??
//                                                   null
//                                               : widget.unSelectedContainerBorder ??
//                                                   null,
//                                           gradient:
//                                               widget.SelectionContainerGradient,
//                                           color: (PageIndex == index)
//                                               ? widget.selectedContainerColor ??
//                                                   Color.fromARGB(255, 0, 0, 0)
//                                               : widget.unselectedContainerColor ??
//                                                   Colors.transparent,
//                                           child: widget.iconsList[index])),
//                                 ),
//                                 Container(
//                                   width: (widget.width -
//                                           (widget.iconsList.length *
//                                               (widget.SelectionContainerWidth ??
//                                                   60))) /
//                                       (widget.iconsList.length + 1),
//                                 )
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//         ],
//       );
//     }
//     return BarBody;
//   }
// }