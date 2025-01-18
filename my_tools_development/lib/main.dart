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

Map data = {
  "title 1": "value 1",
  "title 2": "value 2",
  "title 3": "value 3",
  "title 4": "value 4",
  "title 5": "value 5",
  "title 6": "value 6",
  "title 7": "value 7",
};

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return SearchAppBar(
      data: data,
      crossAxisCount: 2,
      childHeight: 150,
      columnSpaces: 40,
      rowSpaces: 40,
      appBarColor: Colors.green,
      appBarHeight: 70,
      body: Center(child: Text("hi")),
      childWidth: 300,
      onSelected: (SelectedIndex) {
        print(data[data.keys.elementAt(SelectedIndex)]);
      },
      itemCount: data.length,
      builder: (Index) {
        return Center(child: Text(data[data.keys.elementAt(Index)]));
      },
    );
  }
}
