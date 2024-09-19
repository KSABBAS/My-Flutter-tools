import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tools_development/MyTools.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

String sub = "";
GlobalKey<FormState> key = GlobalKey();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
        body: Center(
      child: CMaker(
          height: 400,
          width: 400,
          child: MultiCBox(
            childWidth: 200,
            childHeight: 100,
            childColor: Colors.amber,
            rowSpaces: 20,
            columnSpaces: 20,
            maxNumber: 2,
            list: ["kareem", "hamsa", "malak"],
            crossAxisCount: 2,
            onChanged: (SelectedValues) {
              print(SelectedValues);
            },
          )),
    ));
  }
}
