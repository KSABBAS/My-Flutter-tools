import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// class MySwitchTitleBuilder extends StatefulWidget {
//   MySwitchTitleBuilder({
//     super.key,
//     this.SwitchHeight,
//     this.SwitchWidth,
//     required this.BackLayerColorOn,
//     required this.dataList,
//     required this.BackLayerColorOff,
//     required this.BallColorOff,
//     required this.BallColorOn,
//     this.OffIconBall,
//     this.ONIconBall,
//     this.SwitchHeight2,
//     this.SwitchWidth2,
//     this.colorcmaker2,
//     this.onChange,
//     this.Cardcolorincmaker2,
//     this.style,
//     this.marginInRowCard,
//     this.paddingInRowCard,
//     this.paddingInRowCard2,
//   });

//   double? SwitchHeight;
//   List dataList;
//   double? SwitchWidth;
//   double? SwitchHeight2;
//   double? SwitchWidth2;
//   Color? BackLayerColorOff;
//   Color? colorcmaker2;
//   Color? BackLayerColorOn;
//   Color? BallColorOn;
//   Color? BallColorOff;
//   Color? Cardcolorincmaker2;
//   Icon? OffIconBall;
//   Icon? ONIconBall;
//   EdgeInsetsGeometry? paddingInRowCard;
//   EdgeInsetsGeometry? paddingInRowCard2;
//   TextStyle? style;
//   EdgeInsetsGeometry? marginInRowCard;

//   Function(List NewList)? onChange;

//   @override
//   State<MySwitchTitleBuilder> createState() => _MySwitchBuilderState();
// }

// class _MySwitchBuilderState extends State<MySwitchTitleBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     return CMaker(
//       height: 300,
//       width: double.infinity,
//       child: ListView.builder(
//         itemCount: widget.dataList.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//               onTap: () {
//                 if (widget.dataList[index][1]) {
//                   widget.dataList[index][1] = false;
//                   widget.OffIconBall;
//                   widget.onChange!(widget.dataList);
//                   widget.BackLayerColorOff;
//                   widget.BallColorOff;
//                 } else {
//                   print(widget.dataList[index][2]);
//                   widget.dataList[index][1] = true;
//                   widget.ONIconBall;
//                   widget.onChange!(widget.dataList);
//                   widget.BackLayerColorOn;
//                   widget.BallColorOn;
//                 }
//                 setState(() {});
//               },
//               child: Card(
//                 color: widget.Cardcolorincmaker2,
//                 child: CMaker(
//                   color: widget.colorcmaker2,
//                   width: widget.SwitchWidth2,
//                   height: widget.SwitchHeight2,
//                   child: Row(
//                     children: [
//                       CMaker(
//                         padding: widget.paddingInRowCard2,
//                         child: widget.dataList[index][3],
//                       ),
//                       Padding(
//                         padding: widget.paddingInRowCard ?? EdgeInsets.only(),
//                         child: CMaker(
//                           width: widget.SwitchWidth2,
//                           child: Text(
//                             widget.dataList[index][0] ?? "",
//                             style: widget.style,
//                           ),
//                         ),
//                       ),
//                       CMaker(
//                           alignment: Alignment.center,
//                           height: widget.SwitchHeight ?? 80,
//                           width: widget.SwitchWidth ?? 70,
//                           child: Stack(
//                             children: [
//                               CMaker(
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 10),
//                                 height: (widget.SwitchHeight ?? 40) - 20,
//                                 width: (widget.SwitchWidth ?? 50) - 2,
//                                 color: (widget.dataList[index][1])
//                                     ? widget.BackLayerColorOn
//                                     : widget.BackLayerColorOff,
//                                 circularRadius: 50,
//                               ),
//                               ACMaker(
//                                 duration: Duration(milliseconds: 280),
//                                 height: widget.SwitchHeight ?? 50,
//                                 width: widget.SwitchWidth ?? 100,
//                                 alignment: (widget.dataList[index][1])
//                                     ? Alignment.centerRight
//                                     : Alignment.centerLeft,
//                                 child: CMaker(
//                                   child: (widget.dataList[index][1])
//                                       ? widget.ONIconBall
//                                       : widget.OffIconBall,
//                                   margin: EdgeInsets.only(bottom: 8),
//                                   color: (widget.dataList[index][1])
//                                       ? widget.BallColorOn
//                                       : widget.BallColorOff,
//                                   circularRadius: 500,
//                                   height: 35,
//                                   width: 35,
//                                 ),
//                               ),
//                             ],
//                           )),
//                     ],
//                   ),
//                 ),
//               ));
//         },
//       ),
//     );
//   }
// }