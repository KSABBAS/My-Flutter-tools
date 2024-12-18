import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/MyFunctionTools.dart';
import 'package:my_tools_development/MyTools/MyTools.dart';

void main() {
  runApp(MaterialApp(home: App(),debugShowCheckedModeBanner: false,));
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
    return Scaffold(
        body: Column(
          children: [
            MyVideoPlayer(
                  url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
              allowFullScreen: true,
                ),
            Container(height: 200,width: 200,color: Colors.green,)
          ],
        ));
  }
}
