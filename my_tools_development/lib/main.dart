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
          height: 300,
          width: 390,
          child: RButton(
            rowSpaces: 20,
            columnSpaces: 30,
                list: ["male", "female","trans","human","other"],
                crossAxisCount: 2,
                onChanged: (SelectedValue) {
                  print(SelectedValue);
                },
              ),
        )),
    );
  }
}
