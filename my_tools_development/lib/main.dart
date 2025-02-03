import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_tools_development/MyTools/Functions/Height_and_width_Functions.dart';
import 'package:my_tools_development/MyTools/Functions/MyResponsive.dart';
import 'package:my_tools_development/MyTools/MyFunctionTools.dart';
import 'package:my_tools_development/MyTools/MyTools.dart';
import 'package:my_tools_development/MyTools/tools/Button_Tools/Checkbox/MultiCBox.dart';
import 'package:my_tools_development/MyTools/tools/Button_Tools/MyButton.dart';
import 'package:my_tools_development/MyTools/tools/Button_Tools/Radio/MultiRButton.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
import 'package:my_tools_development/MyTools/tools/Generator_Tools/generateQRCode.dart';
import 'package:my_tools_development/MyTools/tools/Image_Tools/Image_Viewers/ClickToOpenImageViwer.dart';
import 'package:my_tools_development/MyTools/tools/Painter_tools/PercentageCircle.dart';
import 'package:my_tools_development/MyTools/tools/Scanner_Tools/scanQR.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyColumnWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyExpandingColumnWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyExpandingRowWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyRowWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/DistributiveGView.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/Specific_height_width_grid.dart';
import 'package:my_tools_development/MyTools/Functions/WidgetListBuilder.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   MediaKit.ensureInitialized();
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: App(),
//     ),
//     debugShowCheckedModeBanner: false,
//   ));
// }

// class App extends StatefulWidget {
//   const App({super.key});

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: ListView(
//             children: WidgetListBuilder(
//       itemCount: 20,
//       builder: (index) {
//         return Text("hi $index");
//       },
//       finalList: (finalList) {
//         print(finalList);
//       },
//     )));
//   }
// }
// import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PercentageCirclePage(),
    );
  }
}

class PercentageCirclePage extends StatefulWidget {
  @override
  _PercentageCirclePageState createState() => _PercentageCirclePageState();
}

class _PercentageCirclePageState extends State<PercentageCirclePage> {
  double _percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circular Percentage Slider'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: PercentageCircle(_percentage,backgroundColor: Colors.green),
                child: Center(
                  child: Text(
                    '${(_percentage * 100).toInt()}%',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Slider(
            value: _percentage,
            min: 0,
            max: 1,
            divisions: 1000,
            label: '${(_percentage * 100).toInt()}%',
            onChanged: (value) {
              setState(() {
                _percentage = value;
              });
            },
          ),
        ],
      ),
    );
  }
}



