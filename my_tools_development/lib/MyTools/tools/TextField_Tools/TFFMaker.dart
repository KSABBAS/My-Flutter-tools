import 'package:flutter/material.dart';
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