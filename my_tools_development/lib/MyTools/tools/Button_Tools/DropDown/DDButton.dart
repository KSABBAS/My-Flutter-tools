import 'package:flutter/material.dart';
class DDButton extends StatefulWidget {
  DDButton(
      {super.key, required this.values, this.onChanged, this.initValueIndex});
  Function(dynamic value)? onChanged;
  List values = [];
  int? initValueIndex;
  @override
  State<DDButton> createState() => _DDButtonState();
}

class _DDButtonState extends State<DDButton> {
  int? indexChosen;
  var commonVar;
  @override
  Widget build(BuildContext context) {
    commonVar = widget.values[indexChosen ?? widget.initValueIndex ?? 0];
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