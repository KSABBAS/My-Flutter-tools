import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

XFile? Img;
Uint8List? file;
class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: CMaker(
                  height: 250,
                  child: Column(
                    children: [
                      MyButton(
                            text: "Pick",
                            onTap: () async {
                              Img = await PickMediaFromGalary();
                              file =await Img!.readAsBytes();
                              setState(() {
                              });
                            },
                          ),
                      SizedBox(height: 200,width: 200,child: ViewImage(bytes:file,),)
                    ],
                  ),
                ))));
  }
}
