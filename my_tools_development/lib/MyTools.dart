import 'dart:async';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as Parser;
// import 'package:html/dom.dart' as dom;
// import 'package:html/dom_parsing.dart';
// import 'package:html/html_escape.dart';
// import 'package:beautiful_soup_dart/beautiful_soup.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:lottie/lottie.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

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
      this.circularRadius});
  Color? color;
  double? height;
  double? width;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  DecorationImage? BackGroundimage;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
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

class TMaker extends StatelessWidget {
  TMaker(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.textAlign,
      this.fontFamily});
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  TextAlign? textAlign;
  String? fontFamily;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color),
    );
  }
}

dynamic TStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
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

double PageHeight(BuildContext context) {
  List l = [2.2];
  final Sheigt = MediaQuery.of(context).size.height;
  l.add(Sheigt);
  return l[1];
}

double PageWidth(BuildContext context) {
  List l = [2.2];
  final Swidth = MediaQuery.of(context).size.width;
  l.add(Swidth);
  return l[1];
}

// status bar code , inset it in the runApp (SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);)

// to remove the red debug , insert it inside the materialApp (debugShowCheckedModeBanner: false,)

class SplashViewPage extends StatefulWidget {
  SplashViewPage(
      {super.key,
      this.backgroundGradient,
      this.backgroundColor,
      this.poweredByColor,
      required this.child,
      this.fadingBegin,
      this.fadingEnd,
      this.animationDurationInMilliseconds,
      this.afterAnimationDurationInMilliseconds,
      this.reverseAnimation,
      required this.afterAnimationIsDone,
      this.textFontFamily});
  Gradient? backgroundGradient;
  Color? backgroundColor;
  Color? poweredByColor;
  Widget? child;
  double? fadingBegin;
  double? fadingEnd;
  int? animationDurationInMilliseconds;
  int? afterAnimationDurationInMilliseconds;
  bool? reverseAnimation;
  String? textFontFamily;
  Function()? afterAnimationIsDone;
  @override
  State<SplashViewPage> createState() => _SplashViewPageState();
}

class _SplashViewPageState extends State<SplashViewPage>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? fading;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: widget.animationDurationInMilliseconds ?? 3000));
    fading = Tween<double>(
            begin: widget.fadingBegin ?? 0, end: widget.fadingEnd ?? 1)
        .animate(animationController!)
      ..addListener(() {
        setState(() {
          if (animationController!.isCompleted) {
            Timer(
                Duration(
                    milliseconds: widget.afterAnimationDurationInMilliseconds ??
                        300), () {
              widget.afterAnimationIsDone!();
            });
          }
        });
      });
    animationController!.forward().whenComplete(() {
      if (widget.reverseAnimation ?? false) {
        animationController!.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CMaker(
        height: double.infinity,
        width: double.infinity,
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(flex: 10, child: Container()),
              CMaker(
                child: Row(
                  children: [
                    Expanded(
                        child: Opacity(
                      opacity: fading?.value,
                      child: Container(
                        child: widget.child,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Expanded(flex: 5, child: Container()),
              Expanded(
                  flex: 2,
                  child: CMaker(
                      alignment: Alignment.bottomCenter,
                      child: Opacity(
                          opacity: fading?.value,
                          child: TMaker(
                              fontFamily: widget.textFontFamily,
                              text: "Powered By",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: widget.poweredByColor ??
                                  const Color.fromARGB(210, 243, 243, 243))))),
              Expanded(
                  flex: 3,
                  child: CMaker(
                      alignment: Alignment.topCenter,
                      child: Opacity(
                          opacity: fading?.value,
                          child: TMaker(
                              fontFamily: widget.textFontFamily,
                              text: "Codeveloper",
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: widget.poweredByColor ??
                                  const Color.fromARGB(210, 243, 243, 243))))),
            ],
          ),
        ),
      ),
    );
  }
}

class DDButton extends StatefulWidget {
  DDButton({super.key, required this.values, this.onChanged,this.initValueIndex});
  Function(dynamic value)? onChanged;
  List values = [];
  int? initValueIndex;
  @override
  State<DDButton> createState() => _DDButtonState();
}

class _DDButtonState extends State<DDButton> {
  int? indexChosen ;
  var commonVar;
  @override
  Widget build(BuildContext context) {
    commonVar = widget.values[indexChosen??widget.initValueIndex??0];
    List<DropdownMenuItem<Object?>>? t(List values) {
      List<DropdownMenuItem<Object?>>? list = [];
      for (int i = 0; i < values.length; i++) {
        list.add(
          DropdownMenuItem(
            child: Text(values[i].toString()),
            value: values[i],
            onTap: () {
              indexChosen = i;
            },
          ),
        );
      }
      return list;
    }

    return DropdownButton(
        onChanged: (val) {
          setState(() {
            commonVar = val;
            widget.onChanged!(val);
          });
        },
        underline: Container(),
        value: commonVar,
        items: t(widget.values));
  }
}

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
      this.childHeight,
      this.childPadding,
      this.childWidth,
      this.textAlign,
      this.textColor,
      this.textFontFamily,
      this.textFontSize,
      this.textFontWeight,
      this.activeColor,
      this.fillColor,
      this.hoverColor,
      this.overlayColor,
      this.tileColor});
  List list;
  int crossAxisCount;
  double? mainAxisSpacing;
  double? rowSpaces;
  double? columnSpaces;
  double? crossAxisSpacing;
  double? childWidth;
  double? childHeight;
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
  WidgetStateProperty<Color?>? fillColor;
  Color? hoverColor;
  Color? tileColor;
  WidgetStateProperty<Color?>? overlayColor;
  Color? activeColor;
  Function(dynamic SelectedValue) onChanged;
  @override
  State<MultiRButton> createState() => _MultiRButtonState();
}

class _MultiRButtonState extends State<MultiRButton> {
  var selected = "";
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                            ((widget.crossAxisCount * RowIndex + ColumnIndex)))
                    ? CMaker(
                        height: widget.childHeight ?? 60,
                        width:
                            widget.childWidth ?? 150.0 * widget.crossAxisCount,
                      )
                    : CMaker(
                        margin: EdgeInsets.only(
                            left: (ColumnIndex == 0)
                                ? widget.columnSpaces ?? 0
                                : (((widget.columnSpaces) ?? 0) / 2),
                            right: ((ColumnIndex + 1) == widget.crossAxisCount)
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
                            Color.fromARGB(96, 216, 216, 216),
                        child: RadioListTile(
                            tileColor: widget.tileColor,
                            fillColor: widget.fillColor,
                            overlayColor: widget.overlayColor,
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
                                widget.crossAxisCount * RowIndex + ColumnIndex],
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
    );
  }
}

class MultiCBox extends StatefulWidget {
  MultiCBox({
    super.key,
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
    this.childHeight,
    this.childWidth,
    this.childPadding,
    this.textAlign,
    this.textColor,
    this.textFontFamily,
    this.textFontSize,
    this.textFontWeight,
  });
  List list;
  int crossAxisCount;
  double? mainAxisSpacing;
  double? rowSpaces;
  double? columnSpaces;
  double? crossAxisSpacing;
  int? maxNumber;
  double? childWidth;
  double? childHeight;
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
  Function(List SelectedValues) onChanged;
  @override
  State<MultiCBox> createState() => _MultiCBoxState();
}

class _MultiCBoxState extends State<MultiCBox> {
  List selectedItems = [];
  var selected = "";
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                            ((widget.crossAxisCount * RowIndex + ColumnIndex)))
                    ? Container(
                        width: widget.childWidth ?? 150,
                      )
                    : CMaker(
                        margin: EdgeInsets.only(
                            left: (ColumnIndex == 0)
                                ? widget.columnSpaces ?? 0
                                : (((widget.columnSpaces) ?? 0) / 2),
                            right: ((ColumnIndex + 1) == widget.crossAxisCount)
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
                              Color.fromARGB(96, 216, 216, 216),
                          child: CheckboxListTile(
                            activeColor: Color.fromARGB(255, 74, 193, 241),
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
                                      ? selectedItems.length < widget.maxNumber!
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
    );
  }
}

class WGrid extends StatefulWidget {
  WGrid(
      {super.key,
      required this.list,
      required this.crossAxisCount,
      this.onSelected,
      this.childHeight,
      this.childWidth,
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
      this.childPadding});
  List<Widget> list;
  int crossAxisCount;
  double? mainAxisSpacing;
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
  double? crossAxisSpacing;
  double? childHeight;
  Function(int SelectedIndex)? onSelected;
  @override
  State<WGrid> createState() => _WGridState();
}

class _WGridState extends State<WGrid> {
  var selected = "";
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
          height: widget.childHeight ?? 150,
          width: widget.childWidth ?? 150.0 * widget.crossAxisCount,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.crossAxisCount,
              itemBuilder: (context, ColumnIndex) {
                return ((widget.list.length % widget.crossAxisCount) != 0 &&
                        widget.list.length ==
                            ((widget.crossAxisCount * RowIndex + ColumnIndex)))
                    ? Container(
                        width: widget.childWidth ?? 150,
                      )
                    : CMaker(
                        margin: EdgeInsets.only(
                            left: (ColumnIndex == 0)
                                ? widget.columnSpaces ?? 0
                                : (((widget.columnSpaces) ?? 0) / 2),
                            right: ((ColumnIndex + 1) == widget.crossAxisCount)
                                ? (widget.columnSpaces ?? 0)
                                : (((widget.columnSpaces) ?? 0) / 2)),
                        child: InkWell(
                          onTap: (widget.onSelected != null)
                              ? () {
                                  widget.onSelected!(
                                      (widget.crossAxisCount * RowIndex +
                                          ColumnIndex));
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
                              circularRadius: widget.childCircularRadius ?? 20,
                              color: widget.childColor ??
                                  Color.fromARGB(96, 216, 216, 216),
                              child: widget.list[
                                  (widget.crossAxisCount * RowIndex +
                                      ColumnIndex)]),
                        ),
                      );
              }),
        );
      },
    );
  }
}

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
  var selected = "";
  @override
  Widget build(BuildContext context) {
    List<Widget> list = () {
      List<Widget>? list = [];
      for (int i = 0; i < widget.itemCount; i++) {
        list.add(widget.builder(i));
      }
      return list;
    }();
    return Container(
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
        physics:
            (widget.Scroll == false) ? NeverScrollableScrollPhysics() : null,
        shrinkWrap: widget.Scroll ?? true,
        itemCount: (widget.itemCount / widget.crossAxisCount).round(),
        itemBuilder: (context, RowIndex) {
          return CMaker(
            margin: EdgeInsets.only(
                top: (RowIndex == 0)
                    ? widget.rowSpaces ?? 0
                    : (((widget.rowSpaces) ?? 0) / 2),
                bottom: ((RowIndex + 1) ==
                        (widget.itemCount / widget.crossAxisCount).round())
                    ? (widget.rowSpaces ?? 0)
                    : (((widget.rowSpaces) ?? 0) / 2)),
            height: widget.childHeight ?? 150,
            width: widget.childWidth ?? 150.0 * widget.crossAxisCount,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.crossAxisCount,
                itemBuilder: (context, ColumnIndex) {
                  return ((widget.itemCount % widget.crossAxisCount) != 0 &&
                          widget.itemCount ==
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
                          child: InkWell(
                            onTap: (widget.onSelected != null)
                                ? () {
                                    widget.onSelected!(
                                        (widget.crossAxisCount * RowIndex +
                                            ColumnIndex));
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
                                    Color.fromARGB(96, 216, 216, 216),
                                child: (list != [])
                                    ? list[(widget.crossAxisCount * RowIndex +
                                        ColumnIndex)]
                                    : Container(
                                        width: widget.childWidth ?? 150,
                                      )),
                          ),
                        );
                }),
          );
        },
      ),
    );
  }
}

// Future<List> getjasonData(String link) async {
//   var res = await get(Uri.parse("$link"));
//   List resDecoded = jsonDecode(res.body);
//   return resDecoded;
// }

// class GetAndDisplayTextJsonData extends StatefulWidget {
//   GetAndDisplayTextJsonData({super.key, required this.link, required this.tag});
//   String link;
//   String tag;
//   @override
//   State<GetAndDisplayTextJsonData> createState() =>
//       _GetAndDisplayTextJsonDataState();
// }

// class _GetAndDisplayTextJsonDataState extends State<GetAndDisplayTextJsonData> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List>(
//         future: getjasonData("${widget.link}"),
//         builder: (context, t) {
//           if (t.connectionState == ConnectionState.waiting) {
//             return Center(child: Expanded(child: CircularProgressIndicator()));
//           } else {
//             return ListView.builder(
//                 itemCount: t.data!.length,
//                 itemBuilder: (context, ind) {
//                   return Card(
//                     child: Container(
//                         margin: EdgeInsets.all(10),
//                         alignment: Alignment.center,
//                         child: Text("${t.data![ind]["${widget.tag}"]}")),
//                   );
//                 });
//           }
//         });
//   }
// }

// Future<List> ScrapeByClass(String link, String tag, String class_) async {
//   String html = "";
//   List result = [];
//   http.Response t = await http.get(Uri.parse(link));
//   html = dom.Document.html(t.body).outerHtml;
//   BeautifulSoup soup = BeautifulSoup(html);
//   for (var vercs in soup.findAll(tag, class_: class_)) {
//     result.add(vercs.text);
//   }
//   return result;
// }

// class Scrape extends StatefulWidget {
//   Scrape(
//       {super.key, required this.link, required this.tag, required this.class_});
//   String link;
//   String tag;
//   String class_;
//   @override
//   State<Scrape> createState() => _ScrapeState();
// }

// class _ScrapeState extends State<Scrape> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List>(
//         future: ScrapeByClass(widget.link, widget.tag, widget.class_),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             return Container();
//           }
//         });
//   }
// }

// bool IsConnectedToInternet() {
//   Future<bool> check() async {
//     var state = await Connectivity().checkConnectivity();
//     print(state.first);
//     return state.first.toString() == "ConnectivityResult.none";
//   }
//   return true;
// }
// Future PhotoImageFromGalary() async {
//   return await ImagePicker().pickImage(source: ImageSource.gallery);
// }
class NavBar extends StatefulWidget {
  NavBar(
      {super.key,
      required this.pages,
      required this.iconsList,
      this.orientation,
      required this.height,
      required this.width,
      this.barColor,
      this.selectedBackgeoundIconColor,
      this.pageBackgroundColor,
      this.unselectedBackgeoundIconColor,
      this.iconFrameHeight,
      this.iconFrameWidth,
      this.iconFramePadding,
      this.BackgroundImage,
      this.BarShadow});
  List<Widget> pages;
  List<Widget> iconsList;
  String? orientation;
  double height;
  double width;
  double? iconFrameHeight;
  double? iconFrameWidth;
  double? iconFramePadding;
  Color? barColor;
  Color? selectedBackgeoundIconColor;
  Color? unselectedBackgeoundIconColor;
  Color? pageBackgroundColor;
  Widget? BackgroundImage;
  List<BoxShadow>? BarShadow;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int PageIndex = 0;
  @override
  PageController _pageController = PageController(
    initialPage: 0,
  );
  Widget build(BuildContext context) {
    late Widget BarBody;
    if (widget.orientation == "H") {
      BarBody = Stack(
        children: [
          CMaker(
              height: double.infinity,
              color: widget.pageBackgroundColor ?? Colors.white,
              width: double.infinity,
              child: Stack(
                children: [
                  (widget.BackgroundImage != null)
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: widget.BackgroundImage!)
                      : Container(),
                  PageView(
                    onPageChanged: (value) {
                      setState(() {
                        PageIndex = value;
                      });
                    },
                    controller: _pageController,
                    children: widget.pages,
                  ),
                ],
              )),
          Positioned(
            top: (PageHeight(context) - widget.height) / 2,
            left: 20,
            child: CMaker(
              circularRadius: 20,
              color: widget.barColor ?? Colors.white,
              height: widget.height,
              width: widget.width,
              child: Column(
                children: [
                  Container(
                    height: (widget.height -
                            (widget.iconsList.length *
                                (widget.iconFrameHeight ?? 60))) /
                        (widget.iconsList.length + 1),
                  ),
                  CMaker(
                    boxShadow: widget.BarShadow,
                    height: widget.height -
                        (widget.height -
                                (widget.iconsList.length *
                                    (widget.iconFrameHeight ?? 60))) /
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
                              onTap: () {
                                _pageController.animateToPage(index,
                                    curve: Curves.linear,
                                    duration: Duration(milliseconds: 200));
                              },
                              child: CMaker(
                                  alignment: Alignment.center,
                                  child: CMaker(
                                      padding: EdgeInsets.all(
                                          widget.iconFramePadding ?? 0),
                                      alignment: Alignment.center,
                                      height: widget.iconFrameHeight ?? 60,
                                      width: widget.iconFrameWidth ?? 60,
                                      circularRadius: 15,
                                      color: (PageIndex == index)
                                          ? widget.selectedBackgeoundIconColor ??
                                              Color.fromARGB(255, 0, 0, 0)
                                          : widget.unselectedBackgeoundIconColor ??
                                              Colors.transparent,
                                      child: widget.iconsList[index])),
                            ),
                            Container(
                              height: (widget.height -
                                      (widget.iconsList.length *
                                          (widget.iconFrameHeight ?? 60))) /
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
        ],
      );
    } else {
      BarBody = Stack(
        children: [
          CMaker(
              height: double.infinity,
              color: widget.pageBackgroundColor ?? Colors.white,
              width: double.infinity,
              child: Stack(
                children: [
                  (widget.BackgroundImage != null)
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: widget.BackgroundImage!)
                      : Container(),
                  PageView(
                    onPageChanged: (value) {
                      setState(() {
                        PageIndex = value;
                      });
                    },
                    controller: _pageController,
                    children: widget.pages,
                  ),
                ],
              )),
          Positioned(
            left: (PageWidth(context) - widget.width) / 2,
            bottom: 20,
            child: CMaker(
              boxShadow: widget.BarShadow,
              circularRadius: 20,
              color: widget.barColor ?? Colors.white,
              height: widget.height,
              width: widget.width,
              child: Row(
                children: [
                  Container(
                    width: (widget.width -
                            (widget.iconsList.length *
                                (widget.iconFrameWidth ?? 60))) /
                        (widget.iconsList.length + 1),
                  ),
                  CMaker(
                    width: widget.width -
                        (widget.width -
                                (widget.iconsList.length *
                                    (widget.iconFrameWidth ?? 60))) /
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
                              onTap: () {
                                PageIndex = index;
                                _pageController.animateToPage(index,
                                    curve: Curves.linear,
                                    duration: Duration(milliseconds: 200));
                              },
                              child: CMaker(
                                  alignment: Alignment.center,
                                  child: CMaker(
                                      padding: EdgeInsets.all(
                                          widget.iconFramePadding ?? 0),
                                      alignment: Alignment.center,
                                      height: widget.iconFrameHeight ?? 60,
                                      width: widget.iconFrameWidth ?? 60,
                                      circularRadius: 15,
                                      color: (PageIndex == index)
                                          ? widget.selectedBackgeoundIconColor ??
                                              Color.fromARGB(255, 0, 0, 0)
                                          : widget.unselectedBackgeoundIconColor ??
                                              Colors.transparent,
                                      child: widget.iconsList[index])),
                            ),
                            Container(
                              width: (widget.width -
                                      (widget.iconsList.length *
                                          (widget.iconFrameWidth ?? 60))) /
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
        ],
      );
    }
    return Scaffold(body: BarBody);
  }
}

class NowClock extends StatefulWidget {
  NowClock({super.key, this.BackGroundColor, this.textFontFamily});
  Color? BackGroundColor;
  String? textFontFamily;
  @override
  State<NowClock> createState() => _NowClockState();
}

class _NowClockState extends State<NowClock> with TickerProviderStateMixin {
  double SecondOp = 1;
  double MinuteOp = 1;
  double HourOp = 1;
  bool Start = true;
  AlignmentGeometry ali = Alignment.center;
  bool FadeIn = true;
  SecondRe() async {
    while (true) {
      setState(() {
        FadeIn = true;
        SecondOp = 0;
        ali = Alignment.topCenter;
      });
      await Future.delayed(Duration(milliseconds: 199));
      setState(() {
        FadeIn = true;
        SecondOp = 1;
        ali = Alignment.center;
      });
      await Future.delayed(Duration(milliseconds: 600));
      setState(() {
        FadeIn = true;
        SecondOp = 0;
        ali = Alignment.bottomCenter;
      });
      await Future.delayed(Duration(milliseconds: 199));
      Start = false;
    }
  }

  @override
  void initState() {
    super.initState();
    SecondRe();
  }

  @override
  Widget build(BuildContext context) {
    Widget HourTW = TMaker(
        fontFamily: widget.textFontFamily,
        text: (DateTime.now().hour.toInt() > 11)
            ? DateTime.now().add(Duration(hours: -11)).hour.toString()
            : DateTime.now().add(Duration(hours: 1)).hour.toString(),
        fontSize: 50,
        fontWeight: FontWeight.w800,
        color: Colors.white);
    Widget MinutesTW = TMaker(
        fontFamily: widget.textFontFamily,
        text: DateTime.now().minute.toString(),
        fontSize: 50,
        fontWeight: FontWeight.w800,
        color: Colors.white);
    Widget SecondsTW = TMaker(
        fontFamily: widget.textFontFamily,
        text: DateTime.now().second.toString(),
        fontSize: 50,
        fontWeight: FontWeight.w800,
        color: Colors.white);
    return CMaker(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: Container()),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.BackGroundColor ??
                      const Color.fromARGB(255, 255, 0, 0),
                ),
                alignment: Alignment.center,
                height: 100,
                width: 100,
              ),
              AnimatedOpacity(
                opacity: HourOp,
                duration: Duration(seconds: (Start) ? 1 : 3598),
                child: AnimatedContainer(
                    duration: Duration(seconds: (Start) ? 1 : 3598),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.BackGroundColor ??
                          const Color.fromARGB(255, 255, 0, 0),
                    ),
                    height: 100,
                    alignment: ali,
                    width: 100,
                    child: HourTW),
              ),
            ],
          ),
          Expanded(child: Container()),
          TMaker(
              fontFamily: widget.textFontFamily,
              text: ":",
              fontSize: 50,
              fontWeight: FontWeight.w800,
              color: Colors.white),
          Expanded(child: Container()),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.BackGroundColor ??
                      const Color.fromARGB(255, 255, 0, 0),
                ),
                alignment: Alignment.center,
                height: 100,
                width: 100,
              ),
              AnimatedOpacity(
                opacity: MinuteOp,
                duration: Duration(seconds: (Start) ? 1 : 58),
                child: AnimatedContainer(
                    duration: Duration(seconds: (Start) ? 1 : 58),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.BackGroundColor ??
                          const Color.fromARGB(255, 255, 0, 0),
                    ),
                    height: 100,
                    alignment: ali,
                    width: 100,
                    child: MinutesTW),
              ),
            ],
          ),
          Expanded(child: Container()),
          TMaker(
              fontFamily: widget.textFontFamily,
              text: ":",
              fontSize: 50,
              fontWeight: FontWeight.w800,
              color: Colors.white),
          Expanded(child: Container()),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.BackGroundColor ??
                      const Color.fromARGB(255, 255, 0, 0),
                ),
                alignment: Alignment.center,
                height: 100,
                width: 100,
              ),
              AnimatedOpacity(
                opacity: SecondOp,
                duration: Duration(milliseconds: 100),
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.BackGroundColor ??
                          const Color.fromARGB(255, 255, 0, 0),
                    ),
                    height: 100,
                    alignment: ali,
                    width: 100,
                    child: SecondsTW),
              ),
            ],
          ),
          Expanded(flex: 3, child: Container()),
        ],
      ),
    );
  }
}

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

class CenterHorizontal extends StatelessWidget {
  CenterHorizontal({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return CMaker(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(child: Container()),
          child,
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

class CenterVertical extends StatelessWidget {
  CenterVertical({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CMaker(
        child: Column(
          children: [
            Expanded(child: Container()),
            child,
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

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

List<Widget>? WidgetListMaker(int number, Widget widget) {
  List<Widget>? list = [];
  for (int i = 0; i < number; i++) {
    list.add(widget);
  }
  return list;
}
Future PhotoImageFromGalary() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}
Future PhotoImageFromCamera() async {
  return await ImagePicker().pickImage(source: ImageSource.camera);
}