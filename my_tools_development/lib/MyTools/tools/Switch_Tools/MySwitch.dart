import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/AnimatedCMaker.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// class MySwitch extends StatefulWidget {
//   MySwitch({
//     super.key,
//     this.SwitchHeight,
//     this.SwitchWidth,
//     this.BackLayerColorOn,
//     required this.BackLayerColorOff,
//     required this.BallColorOff,
//     required this.BallColorOn,
//     this.OffIconBall,
//     this.ONIconBall,
//     this.SwitchHeight2,
//     this.SwitchWidth2,
//     this.colorcmaker2,
//     this.onChange,
//     this.child,
//   });

//   double? SwitchHeight;
//   double? SwitchWidth;
//   double? SwitchHeight2;
//   double? SwitchWidth2;
//   Color? BackLayerColorOff;
//   Color? colorcmaker2;
//   Color? BackLayerColorOn;
//   Color? BallColorOn;
//   Color? BallColorOff;
//   Icon? OffIconBall;
//   Icon? ONIconBall;
//   Widget? child;

//   Function(bool value)? onChange;

//   @override
//   State<MySwitch> createState() => _MySwitchState();
// }

// class _MySwitchState extends State<MySwitch> {
//   bool state = false;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: () {
//           if (state) {
//             state = false;
//             widget.OffIconBall;
//             widget.onChange!(state);
//             widget.BackLayerColorOff;
//             widget.BallColorOff;
//           } else {
//             state = true;
//             widget.ONIconBall;
//             widget.onChange!(state);
//             widget.BackLayerColorOn;
//             widget.BallColorOn;
//           }
//           setState(() {});
//         },
//         child: CMaker(
//           color: widget.colorcmaker2,
//           width: widget.SwitchWidth2,
//           height: widget.SwitchHeight2,
//           child: CMaker(
//               alignment: Alignment.center,
//               height: widget.SwitchHeight ?? 80,
//               width: widget.SwitchWidth ?? 70,
//               child: Stack(
//                 children: [
//                   CMaker(
//                     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                     height: (widget.SwitchHeight ?? 40) - 20,
//                     width: (widget.SwitchWidth ?? 50) - 2,
//                     circularRadius: 15,
//                     color: (state)
//                         ? widget.BackLayerColorOn
//                         : widget.BackLayerColorOff,
//                   ),
//                   ACMaker(
//                     height: widget.SwitchHeight ?? 50,
//                     width: widget.SwitchWidth ?? 100,
//                     alignment:
//                         (state) ? Alignment.centerRight : Alignment.centerLeft,
//                     child: CMaker(
//                         child: (state) ? widget.ONIconBall : widget.OffIconBall,
//                         margin: EdgeInsets.only(bottom: 5),
//                         circularRadius: 500,
//                         height: 35,
//                         width: 35,
//                         color:
//                             (state) ? widget.BallColorOn : widget.BallColorOff),
//                   ),
//                 ],
//               )),
//         ));
//   }
// }