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
        body: WGridBuilder(
            childAlignment: Alignment.center,
            columnSpaces: 20,
            rowSpaces: 20,
            onSelected: (SelectedIndex) {
              print(SelectedIndex);
            },
            builder: (Index) {
              return Text("hi ${Index + 1}");
            },
            itemCount: 20,
            crossAxisCount: 2));
  }
}
