import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';
// class NowClock extends StatefulWidget {
//   NowClock({super.key, this.BackGroundColor, this.textFontFamily});
//   Color? BackGroundColor;
//   String? textFontFamily;
//   @override
//   State<NowClock> createState() => _NowClockState();
// }

// class _NowClockState extends State<NowClock> with TickerProviderStateMixin {
//   double SecondOp = 1;
//   double MinuteOp = 1;
//   double HourOp = 1;
//   bool Start = true;
//   AlignmentGeometry ali = Alignment.center;
//   bool FadeIn = true;
//   SecondRe() async {
//     while (true) {
//       setState(() {
//         FadeIn = true;
//         SecondOp = 0;
//         ali = Alignment.topCenter;
//       });
//       await Future.delayed(Duration(milliseconds: 199));
//       setState(() {
//         FadeIn = true;
//         SecondOp = 1;
//         ali = Alignment.center;
//       });
//       await Future.delayed(Duration(milliseconds: 600));
//       setState(() {
//         FadeIn = true;
//         SecondOp = 0;
//         ali = Alignment.bottomCenter;
//       });
//       await Future.delayed(Duration(milliseconds: 199));
//       Start = false;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     SecondRe();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget HourTW = TMaker(
//         fontFamily: widget.textFontFamily,
//         text: (DateTime.now().hour.toInt() > 11)
//             ? DateTime.now().add(Duration(hours: -11)).hour.toString()
//             : DateTime.now().add(Duration(hours: 1)).hour.toString(),
//         fontSize: 50,
//         fontWeight: FontWeight.w800,
//         color: Colors.white);
//     Widget MinutesTW = TMaker(
//         fontFamily: widget.textFontFamily,
//         text: DateTime.now().minute.toString(),
//         fontSize: 50,
//         fontWeight: FontWeight.w800,
//         color: Colors.white);
//     Widget SecondsTW = TMaker(
//         fontFamily: widget.textFontFamily,
//         text: DateTime.now().second.toString(),
//         fontSize: 50,
//         fontWeight: FontWeight.w800,
//         color: Colors.white);
//     return CMaker(
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(flex: 3, child: Container()),
//           Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: widget.BackGroundColor ??
//                       const Color.fromARGB(255, 255, 0, 0),
//                 ),
//                 alignment: Alignment.center,
//                 height: 100,
//                 width: 100,
//               ),
//               AnimatedOpacity(
//                 opacity: HourOp,
//                 duration: Duration(seconds: (Start) ? 1 : 3598),
//                 child: AnimatedContainer(
//                     duration: Duration(seconds: (Start) ? 1 : 3598),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: widget.BackGroundColor ??
//                           const Color.fromARGB(255, 255, 0, 0),
//                     ),
//                     height: 100,
//                     alignment: ali,
//                     width: 100,
//                     child: HourTW),
//               ),
//             ],
//           ),
//           Expanded(child: Container()),
//           TMaker(
//               fontFamily: widget.textFontFamily,
//               text: ":",
//               fontSize: 50,
//               fontWeight: FontWeight.w800,
//               color: Colors.white),
//           Expanded(child: Container()),
//           Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: widget.BackGroundColor ??
//                       const Color.fromARGB(255, 255, 0, 0),
//                 ),
//                 alignment: Alignment.center,
//                 height: 100,
//                 width: 100,
//               ),
//               AnimatedOpacity(
//                 opacity: MinuteOp,
//                 duration: Duration(seconds: (Start) ? 1 : 58),
//                 child: AnimatedContainer(
//                     duration: Duration(seconds: (Start) ? 1 : 58),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: widget.BackGroundColor ??
//                           const Color.fromARGB(255, 255, 0, 0),
//                     ),
//                     height: 100,
//                     alignment: ali,
//                     width: 100,
//                     child: MinutesTW),
//               ),
//             ],
//           ),
//           Expanded(child: Container()),
//           TMaker(
//               fontFamily: widget.textFontFamily,
//               text: ":",
//               fontSize: 50,
//               fontWeight: FontWeight.w800,
//               color: Colors.white),
//           Expanded(child: Container()),
//           Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: widget.BackGroundColor ??
//                       const Color.fromARGB(255, 255, 0, 0),
//                 ),
//                 alignment: Alignment.center,
//                 height: 100,
//                 width: 100,
//               ),
//               AnimatedOpacity(
//                 opacity: SecondOp,
//                 duration: Duration(milliseconds: 100),
//                 child: AnimatedContainer(
//                     duration: Duration(milliseconds: 100),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: widget.BackGroundColor ??
//                           const Color.fromARGB(255, 255, 0, 0),
//                     ),
//                     height: 100,
//                     alignment: ali,
//                     width: 100,
//                     child: SecondsTW),
//               ),
//             ],
//           ),
//           Expanded(flex: 3, child: Container()),
//         ],
//       ),
//     );
//   }
// }