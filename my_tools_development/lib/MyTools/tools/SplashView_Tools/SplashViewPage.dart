import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
// import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';
// class SplashViewPage extends StatefulWidget {
//   SplashViewPage(
//       {super.key,
//       this.backgroundGradient,
//       this.backgroundColor,
//       this.poweredByColor,
//       required this.child,
//       this.fadingBegin,
//       this.fadingEnd,
//       this.animationDurationInMilliseconds,
//       this.afterAnimationDurationInMilliseconds,
//       this.reverseAnimation,
//       required this.afterAnimationIsDone,
//       this.textFontFamily});
//   Gradient? backgroundGradient;
//   Color? backgroundColor;
//   Color? poweredByColor;
//   Widget? child;
//   double? fadingBegin;
//   double? fadingEnd;
//   int? animationDurationInMilliseconds;
//   int? afterAnimationDurationInMilliseconds;
//   bool? reverseAnimation;
//   String? textFontFamily;
//   Function()? afterAnimationIsDone;
//   @override
//   State<SplashViewPage> createState() => _SplashViewPageState();
// }

// class _SplashViewPageState extends State<SplashViewPage>
//     with SingleTickerProviderStateMixin {
//   AnimationController? animationController;
//   Animation? fading;
//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//         vsync: this,
//         duration: Duration(
//             milliseconds: widget.animationDurationInMilliseconds ?? 3000));
//     fading = Tween<double>(
//             begin: widget.fadingBegin ?? 0, end: widget.fadingEnd ?? 1)
//         .animate(animationController!)
//       ..addListener(() {
//         setState(() {
//           if (animationController!.isCompleted) {
//             Timer(
//                 Duration(
//                     milliseconds: widget.afterAnimationDurationInMilliseconds ??
//                         300), () {
//               widget.afterAnimationIsDone!();
//             });
//           }
//         });
//       });
//     animationController!.forward().whenComplete(() {
//       if (widget.reverseAnimation ?? false) {
//         animationController!.reverse();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CMaker(
//         height: double.infinity,
//         width: double.infinity,
//         color: widget.backgroundColor,
//         gradient: widget.backgroundGradient,
//         alignment: Alignment.center,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Expanded(flex: 10, child: Container()),
//               CMaker(
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: Opacity(
//                       opacity: fading?.value,
//                       child: Container(
//                         child: widget.child,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     )),
//                   ],
//                 ),
//               ),
//               Expanded(flex: 5, child: Container()),
//               Expanded(
//                   flex: 2,
//                   child: CMaker(
//                       alignment: Alignment.bottomCenter,
//                       child: Opacity(
//                           opacity: fading?.value,
//                           child: TMaker(
//                               fontFamily: widget.textFontFamily,
//                               text: "Powered By",
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: widget.poweredByColor ??
//                                   const Color.fromARGB(210, 243, 243, 243))))),
//               Expanded(
//                   flex: 3,
//                   child: CMaker(
//                       alignment: Alignment.topCenter,
//                       child: Opacity(
//                           opacity: fading?.value,
//                           child: TMaker(
//                               fontFamily: widget.textFontFamily,
//                               text: "Codeveloper",
//                               fontSize: 25,
//                               fontWeight: FontWeight.w600,
//                               color: widget.poweredByColor ??
//                                   const Color.fromARGB(210, 243, 243, 243))))),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
