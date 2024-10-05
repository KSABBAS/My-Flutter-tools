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
    return Scaffold(body: Column(
      children: [
        Container(width: 150,height: 200,color: Colors.amber,child: Center(child: Text("hi")),),
        Container(width: 150,height: 200,color: const Color.fromARGB(255, 0, 0, 0),),
        Container(width: 150,height: 200,color: const Color.fromARGB(255, 255, 107, 107),),
      ],
    ),);
  }
}



























// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     return Scaffold(
//       body: GridView(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,crossAxisSpacing: 20,mainAxisSpacing: 20),
//         children: [
           
//         ],
//       )
//     );
//   }
// }
