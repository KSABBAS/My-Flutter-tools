import 'package:flutter/material.dart';
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