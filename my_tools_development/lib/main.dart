import 'package:flutter/material.dart';
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
    return SplashViewPage();
    // Scaffold(
    //   body: Center(
    //     child: Column(
    //       children: [
    //         Text("${sub.length}"),
    //         Form(
    //           key: key,
    //           child: TFFMaker(
    //             onSaved: (value) {
    //               sub = value! + "done";
    //             },
    //             validator: (value) {
    //               if (sub.isEmpty) {
    //                 return "is empty";
    //               }
    //             },
    //             label: TMaker(
    //                 text: "Enter your name",
    //                 fontSize: 15,
    //                 fontWeight: FontWeight.w500,
    //                 color: const Color.fromARGB(255, 92, 92, 92)),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
