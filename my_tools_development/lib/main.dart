import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_tools_development/MyTools/Functions/Height_and_width_Functions.dart';
import 'package:my_tools_development/MyTools/Functions/MyResponsive.dart';
import 'package:my_tools_development/MyTools/MyFunctionTools.dart';
import 'package:my_tools_development/MyTools/MyTools.dart';
import 'package:my_tools_development/MyTools/tools/App_Containing_Tools/SearchAppBar.dart';
import 'package:my_tools_development/MyTools/tools/App_Containing_Tools/StageIndicator.dart';
import 'package:my_tools_development/MyTools/tools/Audio_tools/audio_recorder.dart';
import 'package:my_tools_development/MyTools/tools/Audio_tools/miniAudioPlayer.dart';
import 'package:my_tools_development/MyTools/tools/Button_Tools/Checkbox/MultiCBox.dart';
import 'package:my_tools_development/MyTools/tools/Button_Tools/MyButton.dart';
import 'package:my_tools_development/MyTools/tools/Button_Tools/Radio/MultiRButton.dart';
import 'package:my_tools_development/MyTools/tools/Button_Tools/StarsRating.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
import 'package:my_tools_development/MyTools/tools/Generator_Tools/CustomToolTip.dart';
import 'package:my_tools_development/MyTools/tools/Generator_Tools/FlipCard.dart';
import 'package:my_tools_development/MyTools/tools/Generator_Tools/GenerateStarRating.dart';
import 'package:my_tools_development/MyTools/tools/Generator_Tools/PopUpWidget.dart';
import 'package:my_tools_development/MyTools/tools/Generator_Tools/dayListGenerator.dart';
import 'package:my_tools_development/MyTools/tools/Generator_Tools/generateQRCode.dart';
import 'package:my_tools_development/MyTools/tools/Image_Tools/Image_Viewers/ClickToOpenImageViwer.dart';
import 'package:my_tools_development/MyTools/tools/Image_Tools/Image_Viewers/Dotted_image_viewer.dart';
import 'package:my_tools_development/MyTools/tools/Image_Tools/Image_Viewers/miniOnTheRightImageView.dart';
import 'package:my_tools_development/MyTools/tools/Painter_tools/PercentageCircle.dart';
import 'package:my_tools_development/MyTools/tools/Scanner_Tools/scanQR.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyColumnWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyExpandingColumnWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyExpandingRowWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyRowWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Text_Tools/TMaker.dart';
import 'package:my_tools_development/MyTools/tools/Timer_Tools/CircularCountdownTimer.dart';
import 'package:my_tools_development/MyTools/tools/Video_Tools/miniVideoPlayer/miniVideoPlayer.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/DistributiveGView.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/Specific_height_width_grid.dart';
import 'package:my_tools_development/MyTools/Functions/WidgetListBuilder.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/MyMiniOnTheRightCardViewer.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/cardViewWidget.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
            child: MyCircularCountdownTimer(
          seconds: 20,
          minutes: 5,
          textStyle: TextStyle(color: Colors.white, fontSize: 30),
          backgroundColor: Colors.white,
          controlButtonIconSize: 20,
          controlButtonContainerHeight: 35,
          controlButtonContainerWidth: 35,
          size: 300,
          strokeWidth: 30,
          controlButtonAlignment: Alignment(0, .6),
          onChangedTime: (value) {
            print(value.seconds);
          },
          progressGradient: LinearGradient(colors: [Colors.greenAccent, Colors.blueAccent]),
        )));
  }
}























// CustomCountdownTimer(
//               minutes: 5,
//               seconds: 20,
//           strokeWidth: 30,
//           showControlButton: true,
//           size: 300,
//           textStyle: TextStyle(color: Colors.white, fontSize: 30),
//           onChangedTime: (value) {
//             print(value);
//           },
//           onPause:(value) {
//             print(value);
//           },
//           onComplete: () {
//             print("Timer Completed");
//           },
//           onPlay: (value) {
//             print(value);
//           },
//           progressGradient: LinearGradient(colors: [Colors.greenAccent,Colors.blueAccent]),
//           controlButtonAlignment: Alignment(0,.6),
//           controlButtonBackgroundColor: Colors.white,
//           controlButtonIconSize: 20,
//           controlButtonIconColor: Colors.indigo,
//           controlButtonContainerHeight: 35,
//           controlButtonContainerWidth: 35,
//           backgroundColor: Colors.white,
//         )