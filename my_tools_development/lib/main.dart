import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/MyFunctionTools.dart';
import 'package:my_tools_development/MyTools/MyTools.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Column(
          children: [
            // CMaker(
            //   height: ResponsiveHeight(context, 600), //792),
            //   width: ResponsiveWidth(context, 600), //1536),
            //   color: const Color.fromARGB(255, 104, 187, 22),
            //   child: TMaker(
            //       text: "Hi Kimo",
            //       fontSize: ResponsiveFontSizeByWidth(context, 80),
            //       fontWeight: FontWeight.w500,
            //       color: Colors.black),
            // ),
            // CMaker(
            //   height: 200,
            //   width: 200,
            //   color: const Color.fromARGB(255, 104, 187, 22),
            //   child: TMaker(
            //       text: "Hi Kimo",
            //       fontSize: 20,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.black),
            // ),
          ],
        ),
      ),
    ));
  }
}
