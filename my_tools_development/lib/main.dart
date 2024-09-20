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
        body: NavBar(barColor: const Color.fromARGB(255, 50, 95, 255),pages: [Center(child: Text("hi 1"),),Center(child: Text("hi 2"),)], iconsList: [Icons.home,Icons.person], height: 100, width: 200));
  }
}
