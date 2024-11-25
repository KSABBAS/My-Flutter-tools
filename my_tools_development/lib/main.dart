import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tools_development/MyTools.dart';

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
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child: Container(
            height: 300,
            width: 300,
            child: Row(
              children: [
                Container(
                  height: 300,
                  width: 145,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 145,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,end: Alignment.bottomRight,
                                colors: [const Color.fromARGB(255, 255, 137, 229), const Color.fromARGB(255, 255, 227, 105)])),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 180,
                        width: 145,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,end: Alignment.bottomRight,
                                colors: [const Color.fromARGB(255, 255, 137, 229), const Color.fromARGB(255, 255, 227, 105)])),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 10,
                ),
                Container(
                  height: 300,
                  width: 145,
                  child: Column(
                    children: [
                      Container(
                        height: 180,
                        width: 145,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,end: Alignment.bottomRight,
                                colors: [const Color.fromARGB(255, 255, 137, 229), const Color.fromARGB(255, 255, 227, 105)])),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        width: 145,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,end: Alignment.bottomRight,
                                colors: [const Color.fromARGB(255, 255, 137, 229), const Color.fromARGB(255, 255, 227, 105)])),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
