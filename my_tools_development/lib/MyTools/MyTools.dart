// import 'package:chewie/chewie.dart';
// import 'package:chewie/chewie.dart';
// import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:codeveloper_portfolio/MyTools/MyFunctionTools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:video_player/video_player.dart';

class CMaker extends StatefulWidget {
  CMaker(
      {super.key,
      this.child,
      this.height,
      this.width,
      this.boxShadow,
      this.border,
      this.BackGroundimage,
      this.margin,
      this.padding,
      this.alignment,
      this.color,
      this.gradient,
      this.circularRadius,
      this.transform});
  Color? color;
  double? height;
  double? width;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  DecorationImage? BackGroundimage;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
  Matrix4? transform;
  BoxBorder? border;
  double? circularRadius;
  Widget? child;
  @override
  State<CMaker> createState() => _CMakerState();
}

class _CMakerState extends State<CMaker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      transform: widget.transform,
      alignment: widget.alignment,
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
          gradient: widget.gradient,
          image: widget.BackGroundimage,
          border: widget.border,
          color: widget.color,
          boxShadow: widget.boxShadow,
          borderRadius: BorderRadius.circular(
            widget.circularRadius ?? 0,
          )),
      height: widget.height,
      width: widget.width,
      child: widget.child,
    );
  }
}

class ACMaker extends StatefulWidget {
  ACMaker(
      {super.key,
      this.child,
      this.height,
      this.width,
      this.boxShadow,
      this.border,
      this.BackGroundimage,
      this.margin,
      this.padding,
      this.alignment,
      this.color,
      this.gradient,
      this.circularRadius,
      this.duration,
      this.transform});
  Color? color;
  Duration? duration;
  double? height;
  double? width;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Matrix4? transform;
  DecorationImage? BackGroundimage;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
  BoxBorder? border;
  double? circularRadius;
  Widget? child;
  @override
  State<ACMaker> createState() => _ACMakerState();
}

class _ACMakerState extends State<ACMaker> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: widget.transform,
      duration: widget.duration ?? const Duration(milliseconds: 300),
      alignment: widget.alignment,
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
          gradient: widget.gradient,
          image: widget.BackGroundimage,
          border: widget.border,
          color: widget.color,
          boxShadow: widget.boxShadow,
          borderRadius: BorderRadius.circular(
            widget.circularRadius ?? 0,
          )),
      height: widget.height,
      width: widget.width,
      child: widget.child,
    );
  }
}

//----------------------------------------------------------

//===========================================

// AnimatedCMaker(){

// }

//===========================================

//----------------------------------------------------------
class TMaker extends StatelessWidget {
  TMaker(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.textAlign,
      this.fontFamily,
      this.maxLines,
      this.overflow,
      this.textDirection
      });
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  int? maxLines;
  TextOverflow? overflow;
  TextAlign? textAlign;
  TextDirection? textDirection;
  String? fontFamily;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines:maxLines?? 1,
      overflow: overflow ?? TextOverflow.ellipsis,
      textDirection:textDirection?? TextDirection.rtl,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color),
    );
  }
}

class TFMaker extends StatefulWidget {
  TFMaker(
      {super.key,
      this.prefix,
      this.enabledBorderwidth,
      this.focusedBorderwidth,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.suffix,
      this.focusedCircularRadius,
      this.enabledCircularRadius,
      this.hintText,
      this.hintStyle,
      this.label,
      this.disabledBorderColor,
      this.disabledBorderwidth,
      this.disabledCircularRadius,
      this.onChanged,
      this.onSubmitted,
      this.lines});
  Widget? prefix;
  Widget? suffix;
  String? hintText;
  Widget? label;
  TextStyle? hintStyle;
  double? enabledCircularRadius;
  double? disabledCircularRadius;
  double? focusedCircularRadius;
  double? enabledBorderwidth;
  double? disabledBorderwidth;
  double? focusedBorderwidth;
  int? lines;
  Color? enabledBorderColor;
  Color? disabledBorderColor;
  Color? focusedBorderColor;
  Function(String value)? onChanged;
  Function(String value)? onSubmitted;
  @override
  State<TFMaker> createState() => _TFMakerState();
}

class _TFMakerState extends State<TFMaker> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: widget.lines ?? 1,
      maxLines: widget.lines ?? 1,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      onSubmitted: (value) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted!(value);
        }
      },
      decoration: InputDecoration(
          prefix: widget.prefix,
          suffix: widget.suffix,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          label: widget.label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.enabledBorderColor ?? Colors.black,
                width: widget.enabledBorderwidth ?? 0),
            borderRadius:
                BorderRadius.circular(widget.enabledCircularRadius ?? 20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.focusedBorderColor ?? Colors.black,
                width: widget.focusedBorderwidth ?? 1),
            borderRadius:
                BorderRadius.circular(widget.focusedCircularRadius ?? 10),
          )),
    );
  }
}

class TFFMaker extends StatefulWidget {
  TFFMaker(
      {super.key,
      this.FormKey,
      this.enabled,
      this.validator,
      this.prefix,
      this.enabledBorderwidth,
      this.errorBorderwidth,
      this.focusedBorderwidth,
      this.enabledBorderColor,
      this.errorBorderColor,
      this.focusedBorderColor,
      this.suffix,
      this.focusedCircularRadius,
      this.enabledCircularRadius,
      this.errorCircularRadius,
      this.hintText,
      this.hintStyle,
      this.label,
      this.disabledBorderColor,
      this.disabledBorderwidth,
      this.disabledCircularRadius,
      this.onChanged,
      this.onSaved,
      this.lines,
      this.initialValue});
  Widget? prefix;
  bool? enabled;
  Widget? suffix;
  String? hintText;
  Widget? label;
  TextStyle? hintStyle;
  String? initialValue;
  double? enabledCircularRadius;
  double? errorCircularRadius;
  double? disabledCircularRadius;
  double? focusedCircularRadius;
  double? enabledBorderwidth;
  double? errorBorderwidth;
  double? disabledBorderwidth;
  double? focusedBorderwidth;
  int? lines;
  Color? enabledBorderColor;
  Color? errorBorderColor;
  Color? disabledBorderColor;
  Color? focusedBorderColor;
  GlobalKey<FormState>? FormKey;
  Function(String value)? onChanged;
  Function(String? value)? onSaved;
  String? Function(String? value)? validator;
  @override
  State<TFFMaker> createState() => _TFFMakerState();
}

class _TFFMakerState extends State<TFFMaker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue ?? "",
      minLines: widget.lines ?? 1,
      maxLines: widget.lines ?? 1,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      onSaved: (newValue) {
        if (widget.onSaved != null) {
          widget.onSaved!(newValue);
        }
      },
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      decoration: InputDecoration(
        prefix: widget.prefix,
        suffix: widget.suffix,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        enabled: widget.enabled ?? true,
        label: widget.label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.enabledBorderColor ?? Colors.black,
              width: widget.enabledBorderwidth ?? 0),
          borderRadius:
              BorderRadius.circular(widget.enabledCircularRadius ?? 20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.focusedBorderColor ?? Colors.black,
              width: widget.focusedBorderwidth ?? 1),
          borderRadius:
              BorderRadius.circular(widget.focusedCircularRadius ?? 10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.errorBorderColor ?? Colors.red,
              width: widget.errorBorderwidth ?? 1),
          borderRadius: BorderRadius.circular(widget.errorCircularRadius ?? 20),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: widget.disabledBorderColor ?? Colors.red,
              width: widget.disabledBorderwidth ?? 1),
          borderRadius:
              BorderRadius.circular(widget.disabledCircularRadius ?? 20),
        ),
      ),
    );
  }
}

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

// class DDButton extends StatefulWidget {
//   DDButton(
//       {super.key, required this.values, this.onChanged, this.initValueIndex});
//   Function(dynamic value)? onChanged;
//   List values = [];
//   int? initValueIndex;
//   @override
//   State<DDButton> createState() => _DDButtonState();
// }

// class _DDButtonState extends State<DDButton> {
//   int? indexChosen;
//   var commonVar;
//   @override
//   Widget build(BuildContext context) {
//     commonVar = widget.values[indexChosen ?? widget.initValueIndex ?? 0];
//     List<DropdownMenuItem<Object?>>? t(List values) {
//       List<DropdownMenuItem<Object?>>? list = [];
//       for (int i = 0; i < values.length; i++) {
//         list.add(
//           DropdownMenuItem(
//             child: Text(values[i].toString()),
//             value: values[i],
//             onTap: () {
//               indexChosen = i;
//             },
//           ),
//         );
//       }
//       return list;
//     }

//     return DropdownButton(
//         onChanged: (val) {
//           setState(() {
//             commonVar = val;
//             widget.onChanged!(val);
//           });
//         },
//         underline: Container(),
//         value: commonVar,
//         items: t(widget.values));
//   }
// }

class MultiRButton extends StatefulWidget {
  MultiRButton(
      {super.key,
      required this.list,
      required this.crossAxisCount,
      required this.onChanged,
      this.mainAxisSpacing,
      this.rowSpaces,
      this.columnSpaces,
      this.crossAxisSpacing,
      this.childAlignment,
      this.childBackGroundimage,
      this.childBorder,
      this.childBoxShadow,
      this.childCircularRadius,
      this.childColor,
      this.childGradient,
      required this.childHeight,
      this.childPadding,
      this.childWidth,
      this.textAlign,
      this.textColor,
      this.textFontFamily,
      this.textFontSize,
      this.textFontWeight,
      this.activeColor,
      this.hoverColor,
      this.tileColor,
      this.Scroll});
  List list;
  int crossAxisCount;
  double? mainAxisSpacing;
  double? rowSpaces;
  double? columnSpaces;
  double? crossAxisSpacing;
  double? childWidth;
  double childHeight;
  Color? childColor;
  AlignmentGeometry? childAlignment;
  EdgeInsetsGeometry? childPadding;
  DecorationImage? childBackGroundimage;
  List<BoxShadow>? childBoxShadow;
  Gradient? childGradient;
  BoxBorder? childBorder;
  double? childCircularRadius;
  double? textFontSize;
  FontWeight? textFontWeight;
  Color? textColor;
  TextAlign? textAlign;
  String? textFontFamily;
  Color? hoverColor;
  Color? tileColor;
  Color? activeColor;
  bool? Scroll;
  Function(dynamic SelectedValue) onChanged;
  @override
  State<MultiRButton> createState() => _MultiRButtonState();
}

class _MultiRButtonState extends State<MultiRButton> {
  var selected = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.list.length.isEven)
          ? ((widget.childHeight * widget.list.length) / 2) +
              ((widget.rowSpaces ?? 0 * widget.list.length) +
                  ((widget.rowSpaces ?? 0) * (widget.list.length / 2.0) + 0.0))
          : (((widget.childHeight * widget.list.length) / 2) +
                  widget.childHeight / 2) +
              ((widget.rowSpaces ?? 0 * widget.list.length) +
                  ((widget.rowSpaces ?? 0) *
                          (widget.list.length / 2.0).round() +
                      0.0)),
      child: ListView.builder(
        physics: (widget.Scroll == false)
            ? const NeverScrollableScrollPhysics()
            : null,
        shrinkWrap: widget.Scroll ?? true,
        itemCount: (widget.list.length / widget.crossAxisCount).round(),
        itemBuilder: (context, RowIndex) {
          return CMaker(
            margin: EdgeInsets.only(
                top: (RowIndex == 0)
                    ? widget.rowSpaces ?? 0
                    : (((widget.rowSpaces) ?? 0) / 2),
                bottom: ((RowIndex + 1) ==
                        (widget.list.length / widget.crossAxisCount).round())
                    ? (widget.rowSpaces ?? 0)
                    : (((widget.rowSpaces) ?? 0) / 2)),
            height: widget.childHeight ?? 60,
            width: widget.childWidth ?? 150.0 * widget.crossAxisCount,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.crossAxisCount,
                itemBuilder: (context, ColumnIndex) {
                  return ((widget.list.length % widget.crossAxisCount) != 0 &&
                          widget.list.length ==
                              ((widget.crossAxisCount * RowIndex +
                                  ColumnIndex)))
                      ? CMaker(
                          height: widget.childHeight ?? 60,
                          width: widget.childWidth ??
                              150.0 * widget.crossAxisCount,
                        )
                      : CMaker(
                          margin: EdgeInsets.only(
                              left: (ColumnIndex == 0)
                                  ? widget.columnSpaces ?? 0
                                  : (((widget.columnSpaces) ?? 0) / 2),
                              right:
                                  ((ColumnIndex + 1) == widget.crossAxisCount)
                                      ? (widget.columnSpaces ?? 0)
                                      : (((widget.columnSpaces) ?? 0) / 2)),
                          padding: widget.childPadding,
                          boxShadow: widget.childBoxShadow,
                          BackGroundimage: widget.childBackGroundimage,
                          alignment: widget.childAlignment ?? Alignment.center,
                          border: widget.childBorder,
                          gradient: widget.childGradient,
                          width: widget.childWidth ?? 150,
                          circularRadius: widget.childCircularRadius ?? 20,
                          color: widget.childColor ??
                              const Color.fromARGB(96, 216, 216, 216),
                          child: RadioListTile(
                              tileColor: widget.tileColor,
                              activeColor: widget.activeColor,
                              title: TMaker(
                                text: widget.list[
                                    widget.crossAxisCount * RowIndex +
                                        ColumnIndex],
                                color: widget.textColor ?? Colors.black,
                                fontSize: widget.textFontSize ?? 17,
                                fontWeight:
                                    widget.textFontWeight ?? FontWeight.w500,
                                fontFamily: widget.textFontFamily,
                                textAlign: widget.textAlign,
                              ),
                              value: widget.list[
                                  widget.crossAxisCount * RowIndex +
                                      ColumnIndex],
                              groupValue: selected,
                              onChanged: (val) {
                                setState(() {
                                  selected = val;
                                  widget.onChanged(val);
                                });
                              }),
                        );
                }),
          );
        },
      ),
    );
  }
}

class MultiCBox extends StatefulWidget {
  MultiCBox(
      {super.key,
      required this.list,
      required this.crossAxisCount,
      required this.onChanged,
      this.mainAxisSpacing,
      this.rowSpaces,
      this.columnSpaces,
      this.crossAxisSpacing,
      this.maxNumber,
      this.childAlignment,
      this.childBackGroundimage,
      this.childBorder,
      this.childBoxShadow,
      this.childCircularRadius,
      this.childColor,
      this.childGradient,
      required this.childHeight,
      this.childWidth,
      this.childPadding,
      this.textAlign,
      this.textColor,
      this.textFontFamily,
      this.textFontSize,
      this.textFontWeight,
      this.Scroll});
  List list;
  int crossAxisCount;
  double? mainAxisSpacing;
  double? rowSpaces;
  double? columnSpaces;
  double? crossAxisSpacing;
  int? maxNumber;
  double? childWidth;
  double childHeight;
  Color? childColor;
  AlignmentGeometry? childAlignment;
  EdgeInsetsGeometry? childPadding;
  DecorationImage? childBackGroundimage;
  List<BoxShadow>? childBoxShadow;
  Gradient? childGradient;
  BoxBorder? childBorder;
  double? childCircularRadius;
  double? textFontSize;
  FontWeight? textFontWeight;
  Color? textColor;
  TextAlign? textAlign;
  String? textFontFamily;
  bool? Scroll;
  Function(List SelectedValues) onChanged;
  @override
  State<MultiCBox> createState() => _MultiCBoxState();
}

class _MultiCBoxState extends State<MultiCBox> {
  List selectedItems = [];
  var selected = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.list.length.isEven)
          ? ((widget.childHeight * widget.list.length) / 2) +
              ((widget.rowSpaces ?? 0 * widget.list.length) +
                  ((widget.rowSpaces ?? 0) * (widget.list.length / 2.0) + 0.0))
          : (((widget.childHeight * widget.list.length) / 2) +
                  widget.childHeight / 2) +
              ((widget.rowSpaces ?? 0 * widget.list.length) +
                  ((widget.rowSpaces ?? 0) *
                          (widget.list.length / 2.0).round() +
                      0.0)),
      child: ListView.builder(
        physics: (widget.Scroll == false)
            ? const NeverScrollableScrollPhysics()
            : null,
        shrinkWrap: widget.Scroll ?? true,
        itemCount: (widget.list.length / widget.crossAxisCount).round(),
        itemBuilder: (context, RowIndex) {
          return CMaker(
            margin: EdgeInsets.only(
                top: (RowIndex == 0)
                    ? widget.rowSpaces ?? 0
                    : (((widget.rowSpaces) ?? 0) / 2),
                bottom: ((RowIndex + 1) ==
                        (widget.list.length / widget.crossAxisCount).round())
                    ? (widget.rowSpaces ?? 0)
                    : (((widget.rowSpaces) ?? 0) / 2)),
            height: widget.childHeight ?? 60,
            width: widget.childWidth ?? 150.0 * widget.crossAxisCount,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.crossAxisCount,
                itemBuilder: (context, ColumnIndex) {
                  return ((widget.list.length % widget.crossAxisCount) != 0 &&
                          widget.list.length ==
                              ((widget.crossAxisCount * RowIndex +
                                  ColumnIndex)))
                      ? Container(
                          width: widget.childWidth ?? 150,
                        )
                      : CMaker(
                          margin: EdgeInsets.only(
                              left: (ColumnIndex == 0)
                                  ? widget.columnSpaces ?? 0
                                  : (((widget.columnSpaces) ?? 0) / 2),
                              right:
                                  ((ColumnIndex + 1) == widget.crossAxisCount)
                                      ? (widget.columnSpaces ?? 0)
                                      : (((widget.columnSpaces) ?? 0) / 2)),
                          child: CMaker(
                            padding: widget.childPadding,
                            boxShadow: widget.childBoxShadow,
                            BackGroundimage: widget.childBackGroundimage,
                            alignment: widget.childAlignment,
                            border: widget.childBorder,
                            gradient: widget.childGradient,
                            width: widget.childWidth ?? 150,
                            circularRadius: widget.childCircularRadius ?? 20,
                            color: widget.childColor ??
                                const Color.fromARGB(96, 216, 216, 216),
                            child: CheckboxListTile(
                              activeColor:
                                  const Color.fromARGB(255, 74, 193, 241),
                              title: TMaker(
                                text: widget.list[
                                    widget.crossAxisCount * RowIndex +
                                        ColumnIndex],
                                color: widget.textColor ?? Colors.black,
                                fontSize: widget.textFontSize ?? 17,
                                fontWeight:
                                    widget.textFontWeight ?? FontWeight.w500,
                                fontFamily: widget.textFontFamily,
                                textAlign: widget.textAlign,
                              ),
                              value: (selectedItems.contains(widget.list[
                                      widget.crossAxisCount * RowIndex +
                                          ColumnIndex]))
                                  ? true
                                  : false,
                              onChanged: (value) {
                                if (value! &&
                                    ((widget.maxNumber != null)
                                        ? selectedItems.length <
                                            widget.maxNumber!
                                        : true)) {
                                  selectedItems.add(widget.list[
                                      widget.crossAxisCount * RowIndex +
                                          ColumnIndex]);
                                } else {
                                  selectedItems.remove(widget.list[
                                      widget.crossAxisCount * RowIndex +
                                          ColumnIndex]);
                                }
                                widget.onChanged(selectedItems);
                                setState(() {});
                              },
                            ),
                          ),
                        );
                }),
          );
        },
      ),
    );
  }
}

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

class WGridBuilder extends StatefulWidget {
  WGridBuilder(
      {super.key,
      required this.builder,
      required this.itemCount,
      required this.crossAxisCount,
      this.onSelected,
      required this.childHeight,
      this.childWidth,
      this.rowSpaces,
      this.columnSpaces,
      this.childAlignment,
      this.childBackGroundimage,
      this.childBorder,
      this.childBoxShadow,
      this.childCircularRadius,
      this.childColor,
      this.childGradient,
      this.childPadding,
      this.Scroll});
  int crossAxisCount;
  Widget Function(int Index) builder;
  int itemCount;
  double? childWidth;
  Color? childColor;
  AlignmentGeometry? childAlignment;
  EdgeInsetsGeometry? childPadding;
  DecorationImage? childBackGroundimage;
  List<BoxShadow>? childBoxShadow;
  Gradient? childGradient;
  BoxBorder? childBorder;
  double? childCircularRadius;
  double? rowSpaces;
  double? columnSpaces;
  double childHeight;
  bool? Scroll;
  Function(int SelectedIndex)? onSelected;
  @override
  State<WGridBuilder> createState() => _WGridBuilderState();
}

class _WGridBuilderState extends State<WGridBuilder> {
  @override
  Widget build(BuildContext context) {
    int adjustedItemCount = (widget.itemCount + widget.crossAxisCount - 1) ~/
        widget.crossAxisCount *
        widget.crossAxisCount;
    return SizedBox(
      height: (widget.itemCount.isEven)
          ? ((widget.childHeight * widget.itemCount) / 2) +
              ((widget.rowSpaces ?? 0 * widget.itemCount) +
                  ((widget.rowSpaces ?? 0) * (widget.itemCount / 2.0) + 0.0))
          : (((widget.childHeight * widget.itemCount) / 2) +
                  widget.childHeight / 2) +
              ((widget.rowSpaces ?? 0 * widget.itemCount) +
                  ((widget.rowSpaces ?? 0) * (widget.itemCount / 2.0).round() +
                      0.0)),
      child: ListView.builder(
        physics: (widget.Scroll == false)
            ? const NeverScrollableScrollPhysics()
            : null,
        shrinkWrap: widget.Scroll ?? true,
        itemCount: (adjustedItemCount / widget.crossAxisCount).round(),
        itemBuilder: (context, RowIndex) {
          return CMaker(
            margin: EdgeInsets.only(
                top: (RowIndex == 0)
                    ? widget.rowSpaces ?? 0
                    : (((widget.rowSpaces) ?? 0) / 2),
                bottom: ((RowIndex + 1) ==
                        (adjustedItemCount / widget.crossAxisCount).round())
                    ? (widget.rowSpaces ?? 0)
                    : (((widget.rowSpaces) ?? 0) / 2)),
            height: widget.childHeight ?? 150,
            width: widget.childWidth ?? 150.0 * widget.crossAxisCount,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.crossAxisCount,
                itemBuilder: (context, ColumnIndex) {
                  int currentIndex =
                      (widget.crossAxisCount * RowIndex) + ColumnIndex;
                  return (currentIndex >= widget.itemCount)
                      ? const SizedBox.shrink() // Placeholder for empty slot
                      : CMaker(
                          margin: EdgeInsets.only(
                              left: (ColumnIndex == 0)
                                  ? widget.columnSpaces ?? 0
                                  : (((widget.columnSpaces) ?? 0) / 2),
                              right:
                                  ((ColumnIndex + 1) == widget.crossAxisCount)
                                      ? (widget.columnSpaces ?? 0)
                                      : (((widget.columnSpaces) ?? 0) / 2)),
                          child: InkWell(
                            onTap: (widget.onSelected != null)
                                ? () {
                                    widget.onSelected!(currentIndex);
                                  }
                                : null,
                            child: CMaker(
                                padding: widget.childPadding,
                                boxShadow: widget.childBoxShadow,
                                BackGroundimage: widget.childBackGroundimage,
                                alignment: widget.childAlignment,
                                border: widget.childBorder,
                                gradient: widget.childGradient,
                                width: widget.childWidth ?? 150,
                                circularRadius:
                                    widget.childCircularRadius ?? 20,
                                color: widget.childColor ??
                                    const Color.fromARGB(96, 216, 216, 216),
                                child: widget.builder(currentIndex)),
                          ),
                        );
                }),
          );
        },
      ),
    );
  }
}

//----------------------------------------------------------

//===========================================
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// package: google_maps_flutter 2.10.0
// add: flutter pub add google_maps_flutter

//===========================================

//----------------------------------------------------------

//===========================================
// addectional package: {
// import 'package:video_player/video_player.dart';
// Package : video_player: ^2.9.2
// add : flutter pub add video_player
// }
// import 'package:chewie/chewie.dart';
// Package : chewie 1.8.5
// add : flutter pub add chewie
// ==
// main looks like :
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(App());
// }
// ==
// works on : Android
// link type : direct mp4 link
// class ChewieVideoPlayer extends StatefulWidget {
//   ChewieVideoPlayer(
//       {super.key, this.url, this.height, this.width, this.path, this.file});

//   final double? height;
//   final double? width;
//   final String? url;
//   final String? path;
//   final File? file;

//   @override
//   State<ChewieVideoPlayer> createState() => _ChewieVideoPlayerState();
// }

// class _ChewieVideoPlayerState extends State<ChewieVideoPlayer> {
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }

//   Future<void> _initializeVideoPlayer() async {
//     _videoPlayerController = (widget.path != null)
//         ? VideoPlayerController.asset(
//             widget.path!,
//           )
//         : (widget.file != null)
//             ? VideoPlayerController.file(widget.file!)
//             : VideoPlayerController.networkUrl(
//                 Uri.parse(widget.url ??
//                     "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"),
//               );

//     await _videoPlayerController!.initialize();

//     setState(() {
//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController!,
//         autoPlay: false,
//         looping: false,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _chewieController?.dispose();
//     _videoPlayerController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_chewieController == null) {
//       return SizedBox(
//         height: widget.height ?? 235,
//         width: widget.width ?? double.infinity,
//         child: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     return SizedBox(
//       height: widget.height ?? 235,
//       width: widget.width ?? double.infinity,
//       child: Chewie(controller: _chewieController!),
//     );
//   }
// }

//===========================================

//----------------------------------------------------------

//===========================================
// import 'package:insta_image_viewer/insta_image_viewer.dart';
// package: insta_image_viewer 1.0.4
// add : flutter pub add insta_image_viewer
class ViewImage extends StatelessWidget {
  const ViewImage(
      {super.key,
      this.ImageLink,
      this.ImagePath,
      this.file,
      this.bytes,
      this.Height,
      this.Width,
      this.borderRadius});
  final String? ImageLink;
  final String? ImagePath;
  final File? file;
  final Uint8List? bytes;
  final double? Height;
  final double? Width;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    if (ImagePath != null &&
        ImageLink == null &&
        file == null &&
        bytes == null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: SizedBox(
          width: Width ?? 100,
          height: Height ?? 100,
          child: InstaImageViewer(
            child: Image(
              image: Image.asset(ImagePath!).image,
            ),
          ),
        ),
      );
    } else if (ImageLink == null && file != null && bytes == null) {
      return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: SizedBox(
            width: Width ?? double.infinity,
            height: Height ?? double.infinity,
            child: InstaImageViewer(
              child: Image(
                image: Image.file(file!).image,
              ),
            ),
          ));
    } else if (ImageLink == null && bytes != null) {
      return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: SizedBox(
            width: Width ?? double.infinity,
            height: Height ?? double.infinity,
            child: InstaImageViewer(
              child: Image(
                image: Image.memory(bytes!).image,
              ),
            ),
          ));
    } else {
      return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          child: SizedBox(
            width: Width ?? double.infinity,
            height: Height ?? double.infinity,
            child: InstaImageViewer(
              child: Image(
                image: Image.network(
                        ImageLink ?? "https://picsum.photos/id/507/1000")
                    .image,
              ),
            ),
          ));
    }
  }
}

//===========================================

//----------------------------------------------------------

//===========================================

// ImageEditor(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// StoryViewer(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// PlayAudio(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// SendNotification(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// ViewPdf(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// DownloadFile(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// UploadFile(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// VibrateTheDevice(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// RecordAudio(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// GetAproximitySensorData(){

// }

//===========================================

//----------------------------------------------------------

//===========================================

// TurnAudioIntoText(){

// }

//===========================================

//----------------------------------------------------------

//===========================================
// Prevent taking screenshots

//===========================================

//----------------------------------------------------------

//===========================================

//===========================================

//----------------------------------------------------------

// class NavBar extends StatefulWidget {
//   NavBar(
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
//       required this.onPageChange,
//       this.ScrollDuration,
//       this.SelectionContainerAnimationDuration,
//       this.NavBarPositionBottom,
//       this.NavBarPositionLeft,
//       this.NavBarPositionRight,
//       this.NavBarPositionTop,
//       this.BetweenSpaces});
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
//   double? BarCircularRadius;
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
//   @override
//   State<NavBar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
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
//             child: CMaker(
//               boxShadow: widget.BarShadow,
//               circularRadius: widget.BarCircularRadius ?? 20,
//               border: widget.BarBorder,
//               alignment: Alignment.center,
//               gradient: widget.BarGradient,
//               color: widget.barColor ?? Colors.white,
//               height: widget.height,
//               width: widget.width,
//               child: SizedBox(
//                 width: widget.SelectionContainerWidth,
//                 child: Column(
//                   children: [
//                     Container(
//                       height: widget.BetweenSpaces ??
//                           (widget.height -
//                                   (widget.iconsList.length *
//                                       (widget.SelectionContainerHeight ??
//                                           60))) /
//                               (widget.iconsList.length + 1),
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
//                         physics: const NeverScrollableScrollPhysics(),
//                         shrinkWrap: false,
//                         itemCount: widget.iconsList.length,
//                         itemBuilder: (context, index) {
//                           return Column(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   _pageController!.animateToPage(index,
//                                       curve: Curves.linear,
//                                       duration: widget.ScrollDuration ??
//                                           const Duration(milliseconds: 200));
//                                 },
//                                 child: CMaker(
//                                     alignment: Alignment.center,
//                                     child: ACMaker(
//                                         duration: widget
//                                             .SelectionContainerAnimationDuration,
//                                         padding: EdgeInsets.all(
//                                             widget.SelectionContainerPadding ??
//                                                 0),
//                                         alignment: Alignment.center,
//                                         height: widget.SelectionContainerHeight ??
//                                             60,
//                                         width: widget.SelectionContainerWidth ??
//                                             60,
//                                         circularRadius:
//                                             widget.SelectionContainerCircularRadius ??
//                                                 15,
//                                         border: (PageIndex == index)
//                                             ? widget.SelectedContainerBorder
//                                             : widget.unSelectedContainerBorder,
//                                         gradient:
//                                             widget.SelectionContainerGradient,
//                                         color: (PageIndex == index)
//                                             ? widget.selectedContainerColor ??
//                                                 const Color.fromARGB(
//                                                     255, 0, 0, 0)
//                                             : widget.unselectedContainerColor ??
//                                                 Colors.transparent,
//                                         child: widget.iconsList[index])),
//                               ),
//                               Container(
//                                 height: widget.BetweenSpaces ??
//                                     (widget.height -
//                                             (widget.iconsList.length *
//                                                 (widget.SelectionContainerHeight ??
//                                                     60))) /
//                                         (widget.iconsList.length + 1),
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
//               child: CMaker(
//                 boxShadow: widget.BarShadow,
//                 circularRadius: widget.BarCircularRadius ?? 20,
//                 border: widget.BarBorder,
//                 alignment: Alignment.center,
//                 gradient: widget.BarGradient,
//                 color: widget.barColor ?? Colors.white,
//                 height: widget.height,
//                 width: widget.width,
//                 child: SizedBox(
//                   height: widget.SelectionContainerHeight,
//                   child: Row(
//                     children: [
//                       Container(
//                         width: widget.BetweenSpaces ??
//                             (widget.width -
//                                     (widget.iconsList.length *
//                                         (widget.SelectionContainerWidth ??
//                                             60))) /
//                                 (widget.iconsList.length + 1),
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
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: false,
//                           itemCount: widget.iconsList.length,
//                           itemBuilder: (context, index) {
//                             return Row(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     PageIndex = index;
//                                     _pageController!.animateToPage(index,
//                                         curve: Curves.linear,
//                                         duration:
//                                             const Duration(milliseconds: 200));
//                                   },
//                                   child: CMaker(
//                                       alignment: Alignment.center,
//                                       child: ACMaker(
//                                           duration: widget
//                                               .SelectionContainerAnimationDuration,
//                                           padding: EdgeInsets.all(
//                                               widget.SelectionContainerPadding ??
//                                                   0),
//                                           alignment: Alignment.center,
//                                           height:
//                                               widget.SelectionContainerHeight ??
//                                                   60,
//                                           width:
//                                               widget.SelectionContainerWidth ??
//                                                   60,
//                                           circularRadius: widget
//                                                   .SelectionContainerCircularRadius ??
//                                               15,
//                                           border: (PageIndex == index)
//                                               ? widget.SelectedContainerBorder
//                                               : widget
//                                                   .unSelectedContainerBorder,
//                                           gradient:
//                                               widget.SelectionContainerGradient,
//                                           color: (PageIndex == index)
//                                               ? widget.selectedContainerColor ??
//                                                   const Color.fromARGB(255, 0, 0, 0)
//                                               : widget.unselectedContainerColor ?? Colors.transparent,
//                                           child: widget.iconsList[index])),
//                                 ),
//                                 Container(
//                                   width: widget.BetweenSpaces ??
//                                       (widget.width -
//                                               (widget.iconsList.length *
//                                                   (widget.SelectionContainerWidth ??
//                                                       60))) /
//                                           (widget.iconsList.length + 1),
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

class PopAndVanishNavBar extends StatefulWidget {
  PopAndVanishNavBar(
      {super.key,
      required this.pages,
      required this.iconsList,
      this.orientation,
      required this.height,
      required this.width,
      this.barColor,
      this.selectedContainerColor,
      this.pageBackgroundColor,
      this.unselectedContainerColor,
      this.SelectionContainerHeight,
      this.unSelectionContainerHeight,
      this.SelectionContainerWidth,
      this.unSelectionContainerWidth,
      this.SelectionContainerPadding,
      this.unSelectionContainerPadding,
      this.BackgroundImage,
      this.BarShadow,
      this.BarBorder,
      this.BarCircularRadius,
      this.BarGradient,
      this.SelectedContainerBorder,
      this.unSelectedContainerBorder,
      this.SelectionContainerCircularRadius,
      this.unSelectionContainerCircularRadius,
      this.SelectionContainerGradient,
      this.unSelectionContainerGradient,
      this.onPageChange,
      this.NavBarPositionBottom,
      this.NavBarPositionLeft,
      this.NavBarPositionRight,
      this.NavBarPositionTop,
      this.vanishDuration});
  List<Widget> pages;
  List<Widget> iconsList;
  String? orientation;
  Function(int index)? onPageChange;
  double height;
  double width;
  double? NavBarPositionTop;
  double? NavBarPositionBottom;
  double? NavBarPositionLeft;
  double? NavBarPositionRight;
  double? SelectionContainerHeight;
  double? unSelectionContainerHeight;
  double? SelectionContainerWidth;
  double? unSelectionContainerWidth;
  double? SelectionContainerPadding;
  double? unSelectionContainerPadding;
  double? SelectionContainerCircularRadius;
  double? unSelectionContainerCircularRadius;
  double? BarCircularRadius;
  BoxBorder? SelectedContainerBorder;
  BoxBorder? unSelectedContainerBorder;
  Gradient? SelectionContainerGradient;
  Gradient? unSelectionContainerGradient;
  BoxBorder? BarBorder;
  Gradient? BarGradient;
  Duration? vanishDuration;
  Color? barColor;
  Color? selectedContainerColor;
  Color? unselectedContainerColor;
  Color? pageBackgroundColor;
  Widget? BackgroundImage;
  List<BoxShadow>? BarShadow;
  @override
  State<PopAndVanishNavBar> createState() => _PopAndVanishNavBarState();
}

class _PopAndVanishNavBarState extends State<PopAndVanishNavBar> {
  int PageIndex = 0;
  bool VanishIsOn = false;
  @override
  Widget build(BuildContext context) {
    late Widget BarBody;
    if (widget.orientation == "H") {
      BarBody = Stack(
        children: [
          CMaker(
              height: double.infinity,
              color: widget.pageBackgroundColor ?? Colors.transparent,
              width: double.infinity,
              child: Stack(
                children: [
                  (widget.BackgroundImage != null)
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: widget.BackgroundImage!)
                      : Container(),
                  AnimatedOpacity(
                    opacity: (VanishIsOn) ? 0 : 1,
                    duration:
                        widget.vanishDuration ?? Duration(milliseconds: 200),
                    child: widget.pages[PageIndex],
                  ),
                ],
              )),
          Positioned(
            top: widget.NavBarPositionTop,
            left: widget.NavBarPositionLeft,
            bottom: widget.NavBarPositionBottom,
            right: widget.NavBarPositionRight,
            child: CMaker(
              boxShadow: widget.BarShadow,
              circularRadius: widget.BarCircularRadius ?? 20,
              border: widget.BarBorder,
              alignment: Alignment.center,
              gradient: widget.BarGradient,
              color: widget.barColor ?? Colors.white,
              height: widget.height,
              width: widget.width,
              child: Container(
                width: widget.SelectionContainerWidth,
                child: Column(
                  children: [
                    Container(
                      height: (widget.height -
                              (widget.iconsList.length *
                                  (widget.SelectionContainerHeight ?? 60))) /
                          (widget.iconsList.length + 1),
                    ),
                    CMaker(
                      boxShadow: widget.BarShadow,
                      height: widget.height -
                          (widget.height -
                                  (widget.iconsList.length *
                                      (widget.SelectionContainerHeight ??
                                          60))) /
                              (widget.iconsList.length + 1),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: false,
                        itemCount: widget.iconsList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () async {
                                    if (index != PageIndex) {
                                      setState(() => VanishIsOn = true);
                                      await Future.delayed(widget
                                              .vanishDuration ??
                                          const Duration(milliseconds: 200));
                                      setState(() {
                                        PageIndex = index;
                                        widget.onPageChange?.call(PageIndex);
                                        VanishIsOn = false;
                                      });
                                    }
                                  },
                                  child: CMaker(
                                      padding: EdgeInsets.all(
                                          widget.SelectionContainerPadding ??
                                              0),
                                      alignment: Alignment.center,
                                      height:
                                          widget.SelectionContainerHeight ?? 60,
                                      width:
                                          widget.SelectionContainerWidth ?? 60,
                                      circularRadius: widget
                                              .SelectionContainerCircularRadius ??
                                          15,
                                      border: (PageIndex == index)
                                          ? widget.SelectedContainerBorder ??
                                              null
                                          : widget.unSelectedContainerBorder ??
                                              null,
                                      gradient:
                                          widget.SelectionContainerGradient,
                                      color: (PageIndex == index)
                                          ? widget.selectedContainerColor ??
                                              Color.fromARGB(255, 0, 0, 0)
                                          : widget.unselectedContainerColor ??
                                              Colors.transparent,
                                      child: widget.iconsList[index])),
                              Container(
                                height: (widget.height -
                                        (widget.iconsList.length *
                                            (widget.SelectionContainerHeight ??
                                                60))) /
                                    (widget.iconsList.length + 1),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      BarBody = Stack(
        children: [
          CMaker(
              height: double.infinity,
              color: widget.pageBackgroundColor ?? Colors.transparent,
              width: double.infinity,
              child: Stack(
                children: [
                  (widget.BackgroundImage != null)
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: widget.BackgroundImage!)
                      : Container(),
                  AnimatedOpacity(
                    opacity: (VanishIsOn) ? 0 : 1,
                    duration:
                        widget.vanishDuration ?? Duration(milliseconds: 200),
                    child: widget.pages[PageIndex],
                  ),
                ],
              )),
          Positioned(
              top: widget.NavBarPositionTop,
              left: widget.NavBarPositionLeft,
              bottom: widget.NavBarPositionBottom,
              right: widget.NavBarPositionRight,
              child: CMaker(
                boxShadow: widget.BarShadow,
                circularRadius: widget.BarCircularRadius ?? 20,
                border: widget.BarBorder,
                alignment: Alignment.center,
                gradient: widget.BarGradient,
                color: widget.barColor ?? Colors.white,
                height: widget.height,
                width: widget.width,
                child: Container(
                  height: widget.SelectionContainerHeight,
                  child: Row(
                    children: [
                      Container(
                        width: (widget.width -
                                (widget.iconsList.length *
                                    (widget.SelectionContainerWidth ?? 60))) /
                            (widget.iconsList.length + 1),
                      ),
                      CMaker(
                        width: widget.width -
                            (widget.width -
                                    (widget.iconsList.length *
                                        (widget.SelectionContainerWidth ??
                                            60))) /
                                (widget.iconsList.length + 1),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: false,
                          itemCount: widget.iconsList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (index != PageIndex) {
                                      setState(() => VanishIsOn = true);
                                      await Future.delayed(widget
                                              .vanishDuration ??
                                          const Duration(milliseconds: 200));
                                      setState(() {
                                        PageIndex = index;
                                        widget.onPageChange?.call(PageIndex);
                                        VanishIsOn = false;
                                      });
                                    }
                                  },
                                  child: CMaker(
                                      alignment: Alignment.center,
                                      child: CMaker(
                                          padding: EdgeInsets.all(
                                              widget.SelectionContainerPadding ??
                                                  0),
                                          alignment: Alignment.center,
                                          height:
                                              widget.SelectionContainerHeight ??
                                                  60,
                                          width: widget.SelectionContainerWidth ??
                                              60,
                                          circularRadius:
                                              widget.SelectionContainerCircularRadius ??
                                                  15,
                                          border: (PageIndex == index)
                                              ? widget.SelectedContainerBorder ??
                                                  null
                                              : widget.unSelectedContainerBorder ??
                                                  null,
                                          gradient:
                                              widget.SelectionContainerGradient,
                                          color: (PageIndex == index)
                                              ? widget.selectedContainerColor ??
                                                  Color.fromARGB(255, 0, 0, 0)
                                              : widget.unselectedContainerColor ??
                                                  Colors.transparent,
                                          child: widget.iconsList[index])),
                                ),
                                Container(
                                  width: (widget.width -
                                          (widget.iconsList.length *
                                              (widget.SelectionContainerWidth ??
                                                  60))) /
                                      (widget.iconsList.length + 1),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      );
    }
    return BarBody;
  }
}

class PopAndVanishLAyerBetweenNavBar extends StatefulWidget {
  PopAndVanishLAyerBetweenNavBar(
      {super.key,
      required this.pages,
      required this.iconsList,
      this.orientation,
      required this.height,
      required this.width,
      this.barColor,
      this.selectedContainerColor,
      this.pageBackgroundColor,
      this.unselectedContainerColor,
      this.SelectionContainerHeight,
      this.unSelectionContainerHeight,
      this.SelectionContainerWidth,
      this.unSelectionContainerWidth,
      this.SelectionContainerPadding,
      this.unSelectionContainerPadding,
      this.BackgroundImage,
      this.BarShadow,
      this.BarBorder,
      this.BarCircularRadius,
      this.BarGradient,
      this.SelectedContainerBorder,
      this.unSelectedContainerBorder,
      this.SelectionContainerCircularRadius,
      this.unSelectionContainerCircularRadius,
      this.SelectionContainerGradient,
      this.unSelectionContainerGradient,
      this.onPageChange,
      this.NavBarPositionBottom,
      this.NavBarPositionLeft,
      this.NavBarPositionRight,
      this.NavBarPositionTop,
      this.vanishDuration,
      this.LayerBetween});
  List<Widget> pages;
  List<Widget> iconsList;
  String? orientation;
  Function(int index)? onPageChange;
  double height;
  double width;
  Widget? LayerBetween;
  double? NavBarPositionTop;
  double? NavBarPositionBottom;
  double? NavBarPositionLeft;
  double? NavBarPositionRight;
  double? SelectionContainerHeight;
  double? unSelectionContainerHeight;
  double? SelectionContainerWidth;
  double? unSelectionContainerWidth;
  double? SelectionContainerPadding;
  double? unSelectionContainerPadding;
  double? SelectionContainerCircularRadius;
  double? unSelectionContainerCircularRadius;
  double? BarCircularRadius;
  BoxBorder? SelectedContainerBorder;
  BoxBorder? unSelectedContainerBorder;
  Gradient? SelectionContainerGradient;
  Gradient? unSelectionContainerGradient;
  BoxBorder? BarBorder;
  Gradient? BarGradient;
  Duration? vanishDuration;
  Color? barColor;
  Color? selectedContainerColor;
  Color? unselectedContainerColor;
  Color? pageBackgroundColor;
  Widget? BackgroundImage;
  List<BoxShadow>? BarShadow;
  @override
  State<PopAndVanishLAyerBetweenNavBar> createState() =>
      _PopAndVanishLAyerBetweenNavBarState();
}

class _PopAndVanishLAyerBetweenNavBarState
    extends State<PopAndVanishLAyerBetweenNavBar> {
  int PageIndex = 0;
  bool VanishIsOn = false;
  @override
  Widget build(BuildContext context) {
    late Widget BarBody;
    if (widget.orientation == "H") {
      BarBody = Stack(
        children: [
          CMaker(
              height: double.infinity,
              color: widget.pageBackgroundColor ?? Colors.transparent,
              width: double.infinity,
              child: Stack(
                children: [
                  (widget.BackgroundImage != null)
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: widget.BackgroundImage!)
                      : Container(),
                  AnimatedOpacity(
                    opacity: (VanishIsOn) ? 0 : 1,
                    duration:
                        widget.vanishDuration ?? Duration(milliseconds: 200),
                    child: widget.pages[PageIndex],
                  ),
                ],
              )),
          widget.LayerBetween ?? CMaker(),
          Positioned(
            top: widget.NavBarPositionTop,
            left: widget.NavBarPositionLeft,
            bottom: widget.NavBarPositionBottom,
            right: widget.NavBarPositionRight,
            child: CMaker(
              boxShadow: widget.BarShadow,
              circularRadius: widget.BarCircularRadius ?? 20,
              border: widget.BarBorder,
              alignment: Alignment.center,
              gradient: widget.BarGradient,
              color: widget.barColor ?? Colors.white,
              height: widget.height,
              width: widget.width,
              child: Container(
                width: widget.SelectionContainerWidth,
                child: Column(
                  children: [
                    Container(
                      height: (widget.height -
                              (widget.iconsList.length *
                                  (widget.SelectionContainerHeight ?? 60))) /
                          (widget.iconsList.length + 1),
                    ),
                    CMaker(
                      boxShadow: widget.BarShadow,
                      height: widget.height -
                          (widget.height -
                                  (widget.iconsList.length *
                                      (widget.SelectionContainerHeight ??
                                          60))) /
                              (widget.iconsList.length + 1),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: false,
                        itemCount: widget.iconsList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                  onTap: () async {
                                    if (index != PageIndex) {
                                      setState(() => VanishIsOn = true);
                                      await Future.delayed(widget
                                              .vanishDuration ??
                                          const Duration(milliseconds: 200));
                                      setState(() {
                                        PageIndex = index;
                                        widget.onPageChange?.call(PageIndex);
                                        VanishIsOn = false;
                                      });
                                    }
                                  },
                                  child: CMaker(
                                      padding: EdgeInsets.all(
                                          widget.SelectionContainerPadding ??
                                              0),
                                      alignment: Alignment.center,
                                      height:
                                          widget.SelectionContainerHeight ?? 60,
                                      width:
                                          widget.SelectionContainerWidth ?? 60,
                                      circularRadius: widget
                                              .SelectionContainerCircularRadius ??
                                          15,
                                      border: (PageIndex == index)
                                          ? widget.SelectedContainerBorder ??
                                              null
                                          : widget.unSelectedContainerBorder ??
                                              null,
                                      gradient:
                                          widget.SelectionContainerGradient,
                                      color: (PageIndex == index)
                                          ? widget.selectedContainerColor ??
                                              Color.fromARGB(255, 0, 0, 0)
                                          : widget.unselectedContainerColor ??
                                              Colors.transparent,
                                      child: widget.iconsList[index])),
                              Container(
                                height: (widget.height -
                                        (widget.iconsList.length *
                                            (widget.SelectionContainerHeight ??
                                                60))) /
                                    (widget.iconsList.length + 1),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      BarBody = Stack(
        children: [
          CMaker(
              height: double.infinity,
              color: widget.pageBackgroundColor ?? Colors.transparent,
              width: double.infinity,
              child: Stack(
                children: [
                  (widget.BackgroundImage != null)
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: widget.BackgroundImage!)
                      : Container(),
                  AnimatedOpacity(
                    opacity: (VanishIsOn) ? 0 : 1,
                    duration:
                        widget.vanishDuration ?? Duration(milliseconds: 200),
                    child: widget.pages[PageIndex],
                  ),
                ],
              )),
          widget.LayerBetween ?? CMaker(),
          Positioned(
              top: widget.NavBarPositionTop,
              left: widget.NavBarPositionLeft,
              bottom: widget.NavBarPositionBottom,
              right: widget.NavBarPositionRight,
              child: CMaker(
                boxShadow: widget.BarShadow,
                circularRadius: widget.BarCircularRadius ?? 20,
                border: widget.BarBorder,
                alignment: Alignment.center,
                gradient: widget.BarGradient,
                color: widget.barColor ?? Colors.white,
                height: widget.height,
                width: widget.width,
                child: Container(
                  height: widget.SelectionContainerHeight,
                  child: Row(
                    children: [
                      Container(
                        width: (widget.width -
                                (widget.iconsList.length *
                                    (widget.SelectionContainerWidth ?? 60))) /
                            (widget.iconsList.length + 1),
                      ),
                      CMaker(
                        width: widget.width -
                            (widget.width -
                                    (widget.iconsList.length *
                                        (widget.SelectionContainerWidth ??
                                            60))) /
                                (widget.iconsList.length + 1),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: false,
                          itemCount: widget.iconsList.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (index != PageIndex) {
                                      setState(() => VanishIsOn = true);
                                      await Future.delayed(widget
                                              .vanishDuration ??
                                          const Duration(milliseconds: 200));
                                      setState(() {
                                        PageIndex = index;
                                        widget.onPageChange?.call(PageIndex);
                                        VanishIsOn = false;
                                      });
                                    }
                                  },
                                  child: CMaker(
                                      alignment: Alignment.center,
                                      child: CMaker(
                                          padding: EdgeInsets.all(
                                              widget.SelectionContainerPadding ??
                                                  0),
                                          alignment: Alignment.center,
                                          height:
                                              widget.SelectionContainerHeight ??
                                                  60,
                                          width: widget.SelectionContainerWidth ??
                                              60,
                                          circularRadius:
                                              widget.SelectionContainerCircularRadius ??
                                                  15,
                                          border: (PageIndex == index)
                                              ? widget.SelectedContainerBorder ??
                                                  null
                                              : widget.unSelectedContainerBorder ??
                                                  null,
                                          gradient:
                                              widget.SelectionContainerGradient,
                                          color: (PageIndex == index)
                                              ? widget.selectedContainerColor ??
                                                  Color.fromARGB(255, 0, 0, 0)
                                              : widget.unselectedContainerColor ??
                                                  Colors.transparent,
                                          child: widget.iconsList[index])),
                                ),
                                Container(
                                  width: (widget.width -
                                          (widget.iconsList.length *
                                              (widget.SelectionContainerWidth ??
                                                  60))) /
                                      (widget.iconsList.length + 1),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      );
    }
    return BarBody;
  }
}

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

class MyButton extends StatefulWidget {
  MyButton(
      {super.key,
      required this.text,
      this.textFont,
      this.textFontWeight,
      this.textColor,
      this.buttonColor,
      this.buttonHeight,
      this.buttonWidth,
      this.buttonCircularRadius,
      this.addShadow,
      this.border,
      this.gradient,
      this.margin,
      this.padding,
      this.onTap,
      this.textFontFamily});
  String text;
  void Function()? onTap;
  double? textFont;
  double? buttonHeight;
  double? buttonWidth;
  double? buttonCircularRadius;
  FontWeight? textFontWeight;
  Color? textColor;
  Color? buttonColor;
  bool? addShadow;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Gradient? gradient;
  BoxBorder? border;
  String? textFontFamily;
  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: CMaker(
          gradient: widget.gradient,
          border: widget.border,
          padding: widget.padding,
          margin: widget.margin,
          height: widget.buttonHeight ?? 50,
          width: widget.buttonWidth ?? 90,
          circularRadius: widget.buttonCircularRadius ?? 10,
          color: widget.buttonColor ?? Colors.amber,
          alignment: Alignment.center,
          boxShadow: (widget.addShadow ?? false)
              ? const [
                  BoxShadow(
                      color: Color.fromARGB(61, 0, 0, 0),
                      offset: Offset(2, 2),
                      blurRadius: 10,
                      spreadRadius: .06)
                ]
              : null,
          child: TMaker(
              fontFamily: widget.textFontFamily,
              text: widget.text,
              fontSize: widget.textFont ?? 20,
              fontWeight: widget.textFontWeight ?? FontWeight.w500,
              color: widget.textColor ?? Colors.white),
        ));
  }
}

class PMaker extends StatelessWidget {
  PMaker({
    super.key,
    this.horizontal,
    this.vertical,
  });
  double? horizontal;
  double? vertical;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
      top: vertical ?? 0,
      left: horizontal ?? 0,
    ));
  }
}

class ResponsivePMaker extends StatelessWidget {
  ResponsivePMaker(
      {super.key,
      this.horizontal,
      this.vertical,
      this.designScreenHeight,
      this.designScreenWidth});
  double? horizontal;
  double? vertical;
  double? designScreenHeight;
  double? designScreenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
      top: ResponsiveHeight(context, vertical ?? 0,
          designScreenHeight: designScreenHeight),
      left: ResponsiveWidth(context, horizontal ?? 0,
          designScreenWidth: designScreenWidth),
    ));
  }
}

// class CenterHorizontal extends StatelessWidget {
//   CenterHorizontal({super.key, required this.child});
//   Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return CMaker(
//       width: double.infinity,
//       child: Row(
//         children: [
//           Expanded(child: Container()),
//           child,
//           Expanded(child: Container()),
//         ],
//       ),
//     );
//   }
// }

// class CenterVertical extends StatelessWidget {
//   CenterVertical({super.key, required this.child});
//   Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: CMaker(
//         child: Column(
//           children: [
//             Expanded(child: Container()),
//             child,
//             Expanded(child: Container()),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

//----------------------------------------------------------

//===========================================
// import 'package:video_player/video_player.dart';
// package : video_player: ^2.9.2;
// add : flutter pub add video_player
class MyVideoPlayer extends StatefulWidget {
  MyVideoPlayer({
    super.key,
    this.url,
    this.height,
    this.width,
    this.allowFullScreen = true,
    this.allowSettings = false,
    this.asset,
    this.uri,
    this.file,
    this.autoPlay = false,
    this.showPlayPauseButton = true,
    this.showProgressBar = true,
    this.showVolumeControl = true,
    this.isFullScreen = false, // New parameter
  });

  final String? url;
  final Uri? uri;
  final String? asset;
  final double? height;
  final double? width;
  final File? file;
  final bool allowFullScreen;
  final bool allowSettings;
  final bool autoPlay;
  final bool showPlayPauseButton;
  final bool showProgressBar;
  final bool showVolumeControl;
  final bool isFullScreen; // New property

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.url != null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url!))
        ..initialize().then((_) {
          if (widget.autoPlay) {
            _controller!.play();
          }
          setState(() {});
        });
    } else if (widget.asset != null) {
      _controller = VideoPlayerController.asset(widget.asset!)
        ..initialize().then((_) {
          if (widget.autoPlay) {
            _controller!.play();
          }
          setState(() {});
        });
    } else if (widget.uri != null) {
      _controller = VideoPlayerController.contentUri(widget.uri!)
        ..initialize().then((_) {
          if (widget.autoPlay) {
            _controller!.play();
          }
          setState(() {});
        });
    } else if (widget.file != null) {
      _controller = VideoPlayerController.file(widget.file!)
        ..initialize().then((_) {
          if (widget.autoPlay) {
            _controller!.play();
          }
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ACMaker(
      duration: Duration(milliseconds: 300),
      height: widget.height ?? 200,
      width: widget.width ?? MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Stack(
        children: [
          Center(child: _VideoPlayer(controller: _controller!)),
          _Controls(
            controller: _controller!,
            onChange: (newController) {
              _controller = newController;
            },
            allowSettings: widget.allowSettings,
            allowFullScreen: widget.allowFullScreen,
            showPlayPauseButton: widget.showPlayPauseButton,
            showProgressBar: widget.showProgressBar,
            onScreenModeChange: (fullScreen) {
              if (fullScreen) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      body: Stack(
                        children: [
                          Center(
                            child: _VideoPlayer(controller: _controller!),
                          ),
                          CMaker(
                            height: PageHeight(context),
                            width: PageWidth(context),
                            child: _Controls(
                              controller: _controller!,
                              onChange: (newController) {
                                _controller = newController;
                              },
                              allowFullScreen: widget.allowFullScreen,
                              showPlayPauseButton: widget.showPlayPauseButton,
                              showProgressBar: widget.showProgressBar,
                              onScreenModeChange: (fullScreen) {
                                Navigator.of(context).pop();
                              },
                              allowSettings: widget.allowSettings,
                              showVolumeControl: widget.showVolumeControl,
                              isFullScreen: widget.isFullScreen,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ));
              }
            },
            showVolumeControl: widget.showVolumeControl,
            isFullScreen: widget.isFullScreen,
          ),
        ],
      ),
    );
  }
}

class _Controls extends StatefulWidget {
  final VideoPlayerController controller;
  final Function(VideoPlayerController) onChange;
  final bool allowSettings;
  final bool allowFullScreen;
  final bool showPlayPauseButton;
  final bool showProgressBar;
  final bool showVolumeControl;
  final Function(bool) onScreenModeChange;
  final bool isFullScreen; // New parameter

  const _Controls({
    required this.controller,
    required this.onChange,
    required this.allowSettings,
    required this.allowFullScreen,
    required this.showPlayPauseButton,
    required this.showProgressBar,
    required this.showVolumeControl,
    required this.onScreenModeChange,
    required this.isFullScreen, // New parameter
  });

  @override
  __ControlsState createState() => __ControlsState();
}

class __ControlsState extends State<_Controls> {
  bool fullScreenIsOn = false;
  bool isMuted = false;

  @override
  Widget build(BuildContext context) {
    bool isFullScreen = MediaQuery.of(context).orientation == Orientation.landscape;

    return (!widget.controller.value.isInitialized)
        ? Center(
            child: CircularProgressIndicator(
            color: Colors.white,
          ))
        : AnimatedOpacity(
            opacity: widget.controller.value.isPlaying ? 0 : 1,
            duration: Duration(milliseconds: 300),
            child: CMaker(
              padding: EdgeInsets.symmetric(vertical: 5),
              color: const Color.fromARGB(100, 52, 52, 52),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isFullScreen && widget.allowSettings)
                    Expanded(
                      child: CMaker(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Spacer(),
                            CMaker(
                              width: 40,
                              height: 40,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (widget.showPlayPauseButton)
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            widget.controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 50,
                          ),
                          onPressed: () {
                            widget.controller.value.isPlaying
                                ? widget.controller.pause()
                                : widget.controller.play();
                            widget.onChange(widget.controller);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  if (widget.showProgressBar)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TMaker(
                            fontWeight: FontWeight.w400,
                            text: '${_formatDuration(widget.controller.value.position)} / ${_formatDuration(widget.controller.value.duration)}',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          SizedBox(height: 2),
                          VideoProgressIndicator(
                            widget.controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: Colors.red,
                              bufferedColor: Colors.grey,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isFullScreen && widget.showVolumeControl) // Added isFullScreen condition
                        CMaker(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isMuted = !isMuted;
                                if (isMuted) {
                                  widget.controller.setVolume(0);
                                } else {
                                  widget.controller.setVolume(1);
                                }
                              });
                            },
                            icon: Icon(
                              isMuted ? Icons.volume_off : Icons.volume_up,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      if (widget.allowFullScreen)
                        CMaker(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            onPressed: () {
                              (widget.isFullScreen == false)
                                  ? SystemChrome.setPreferredOrientations([
                                      DeviceOrientation.landscapeLeft
                                    ])
                                  : SystemChrome.setPreferredOrientations([
                                      DeviceOrientation.portraitUp
                                    ]);
                              widget.onScreenModeChange(!widget.isFullScreen);
                            },
                            icon: Icon(
                              (!widget.isFullScreen)
                                  ? Icons.fullscreen
                                  : Icons.fullscreen_exit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}

class _VideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;
  _VideoPlayer({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller),
    );
  }
}

//===========================================

//----------------------------------------------------------

//===========================================
// import 'package:media_kit/media_kit.dart';
// import 'package:media_kit_video/media_kit_video.dart';
// package : media_kit 1.1.11
// ===============
// [
// package : media_kit_video: ^1.2.5
// package : media_kit_libs_video: ^1.0.5
//]
// // add them manually to your dependencies
// ===============
// add : dart pub add media_kit
// ==========================
// you must add to the main :
// WidgetsFlutterBinding.ensureInitialized();
// MediaKit.ensureInitialized();
// ==========================
// class MyMediaKitVideo extends StatefulWidget {
//   MyMediaKitVideo({
//     super.key,
//     // required this.source,
//   });
//   // String source;
//   @override
//   State<MyMediaKitVideo> createState() => _MyMediaKitVideoState();
// }

// class _MyMediaKitVideoState extends State<MyMediaKitVideo> {
//   // Create a [Player] to control playback.
//   late final player = Player();
//   // Create a [VideoController] to handle video output from [Player].
//   late final controller = VideoController(player);

//   @override
//   void initState() {
//     super.initState();
//       player.open(Media("file:///C:/Users/karee/Desktop/GitHub/My-Flutter-tools/my_tools_development/images/h.mp4"));
//   }
//   @override
//   void dispose() {
//     // Dispose of the player and controller
//     player.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Video(controller: controller);
//   }
// }

//===========================================

//----------------------------------------------------------

//===========================================

// import 'package:pretty_qr_code/pretty_qr_code.dart';
// package : pretty_qr_code 3.3.0
// add : flutter pub add pretty_qr_code

// Widget generateQRCode(String data, {double size = 200}) {
//   return PrettyQr(
//     data: data,
//     size: size,
//     roundEdges: true, // Makes the QR code edges rounded
//     elementColor: Colors.black, // Customize QR code color
//     errorCorrectLevel: QrErrorCorrectLevel.M, // Adjust error correction
//   );
// }

//===========================================

//----------------------------------------------------------

//===========================================

//===========================================

//----------------------------------------------------------

//===========================================

//===========================================

//----------------------------------------------------------

//===========================================

//===========================================

//----------------------------------------------------------

//===========================================

//===========================================

//----------------------------------------------------------

//===========================================

//===========================================

//----------------------------------------------------------

//===========================================
// import 'package:mobile_scanner/mobile_scanner.dart';
// package: mobile_scanner: ^6.0.2
// add: flutter pub add mobile_scanner


// Future<String> scanQR(BuildContext context) async {
//   // Using Completer to handle the async flow properly
//   final Completer<String> completer = Completer<String>();
//   await Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) {
//       return scanQRWidget(
//         onScanned: (result) {
//           completer.complete(result); // Complete only when we have a confirmed result
//         },
//       );
//     },
//   ));

//   // Wait for the completer to complete before returning
//   return await completer.future;
// }

// class scanQRWidget extends StatelessWidget {
//   const scanQRWidget({super.key, required this.onScanned});
//   final Function(String result) onScanned;

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope( // Prevent accidental back navigation
//       onWillPop: () async {
//         // Show confirmation dialog before allowing back navigation
//         final bool? shouldPop = await showDialog<bool>(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('إلغاء المسح؟'),
//             content: Text('هل أنت متأكد أنك تريد إلغاء عملية المسح؟'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   onScanned("no result"); // Return no result if user confirms cancel
//                   Navigator.pop(context, true); // Close dialog with true
//                 },
//                 child: Text('نعم'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false), // Close dialog with false
//                 child: Text('لا'),
//               ),
//             ],
//           ),
//         );
//         return shouldPop ?? false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('مسح رمز QR'),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () async {
//               // Show the same confirmation dialog when back button is pressed
//               final bool? shouldPop = await showDialog<bool>(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('إلغاء المسح؟'),
//                   content: Text('هل أنت متأكد أنك تريد إلغاء عملية المسح؟'),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         onScanned("no result");
//                         Navigator.pop(context, true);
//                       },
//                       child: Text('نعم'),
//                     ),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context, false),
//                       child: Text('لا'),
//                     ),
//                   ],
//                 ),
//               );
//               if (shouldPop ?? false) {
//                 Navigator.pop(context);
//               }
//             },
//           ),
//         ),
//         body: MobileScanner(
//           onDetect: (capture) {
//             final List<Barcode> barcodes = capture.barcodes;
//             if (barcodes.isNotEmpty && barcodes[0].rawValue != null) {
//               String scannedValue = barcodes[0].rawValue.toString();
//               onScanned(scannedValue); // Set the scan result
//                               Navigator.pop(context); // Close dialog
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

//===========================================
