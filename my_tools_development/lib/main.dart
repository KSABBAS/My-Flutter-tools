import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

late MyResponsive ahmed;

class _AppState extends State<App> {
  String? qrResult;

  @override
  Widget build(BuildContext context) {
    ahmed = MyResponsive(context, designHeight: 914, designWidth: 411);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    print(PageHeight(context));
    print(PageWidth(context));
    return Center(
        child: CustomNavigationBar(
            HightBigcontaner: double.infinity,
            WidthFristPading: double.infinity,
            Colors: Colors.white,
            Alignment1: Alignment.center,
            fontWeightIntext: FontWeight.bold,
            circularRadiusLineContaner: 50,
            MargenSoucndPading: 10));
  }
}
