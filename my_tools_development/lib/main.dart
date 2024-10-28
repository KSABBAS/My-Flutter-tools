import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tools_development/MyTools.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: App(),
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold();
  }
}
