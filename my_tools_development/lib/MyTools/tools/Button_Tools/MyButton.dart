import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';
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
      this.onDoubleTap,
      this.onHover,
      this.onLongPress,
      this.textFontFamily,
      });
  String text;
  void Function()? onTap;
  void Function()? onDoubleTap;
  void Function(bool)? onHover;
  void Function()? onLongPress;
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
        onDoubleTap: widget.onDoubleTap,
        onHover: widget.onHover,
        onLongPress: widget.onLongPress,
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
