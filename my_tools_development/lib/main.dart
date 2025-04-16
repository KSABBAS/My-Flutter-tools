import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';

void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Video Player Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(body: MyApp()),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CMaker(
      height: 200,
      width: 300,
      color: Colors.amber,
      onTap: () {
        print("hi");
      },
      alignment: Alignment.center,
      child: TMaker(text: "hi", fontSize: 40, fontWeight:FontWeight.w700, color: Colors.black)
    ));
  }
}
