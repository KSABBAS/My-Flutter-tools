import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_tools_development/MyTools/MyFunctionTools.dart';
import 'package:my_tools_development/MyTools/MyTools.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(MaterialApp(
    home: Scaffold(
      body: App(),
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? qrResult;

  @override
  Widget build(BuildContext context) {
    return NavBar(
      NavBarPositionBottom: 30,
      NavBarPositionLeft: (PageWidth(context) - (PageWidth(context) * .85)) / 2,
      pages: [
        Center(child: Text("1")),
        Center(child: Text("2")),
        Center(child: Text("3")),
        Center(child: Text("4")),
        Center(child: Text("2")),
        Center(child: Text("3")),
        Center(child: Text("4")),
      ],
      iconsList: [
        Icon(Icons.home),
        Icon(Icons.search),
        Icon(Icons.add_box_outlined),
        Icon(Icons.person),
        Icon(Icons.search),
        Icon(Icons.add_box_outlined),
        Icon(Icons.person),
      ],
      height: 80,
      width: PageWidth(context) * .85,
      onPageChange: (index) {},
    );
  }
}
