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
            color: const Color.fromARGB(255, 255, 7, 7),
            height: 400,
            width: 400,
            child: WGridBuilder(
                childAlignment: Alignment.center,
                childWidth: 170,
                childHeight: 170,
                columnSpaces: 20,
                rowSpaces: 20,
                onSelected: (SelectedIndex) {
                  print(SelectedIndex);
                },
                builder: (Index) {
                  return Text("hi ${Index + 1}");
                },
                itemCount: 5,
                crossAxisCount: 2),
          ),
        ));
  }
}
