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
late MyResponsive Res; 

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    Res = MyResponsive(context);
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return MaterialApp(
        home: Scaffold(
      body: CMaker(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CMaker(
              height: Res.height(200), //792),
              width:Res.width(768), //1536),
              color: const Color.fromARGB(255, 104, 187, 22),
              child: TMaker(
                  text: "Hi Kimo",
                  fontSize:Res.fontSizeByWidth(40),
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            CMaker(
              height: 200,
              width: 200,
              color: const Color.fromARGB(255, 104, 187, 22),
              child: TMaker(
                  text: "Hi Kimo",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    ));
  }
}
