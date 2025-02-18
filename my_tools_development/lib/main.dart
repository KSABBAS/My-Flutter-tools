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
    return CMaker(
        width: double.infinity,
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 163, 175, 76),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          MyPopupMenu(
          direction: PopupDirection.left,
          overlayBlur: 5,
          excludeChildFromBlur: true,
          child: CMaker(
            height: 200,
            width: 200,
            color: Colors.blue,
            child:Text('Hello'),
          ),
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Hello'),
                Text('World'),
              ],
            );
          },
        ),MyPopupMenu(
          direction: PopupDirection.left,
          overlayBlur: 5,
          excludeChildFromBlur: true,
          child: CMaker(
            height: 200,
            width: 200,
            color: Colors.blue,
            child:Text('Hello'),
          ),
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Hello'),
                Text('World'),
              ],
            );
          },
        ),MyPopupMenu(
          direction: PopupDirection.left,
          overlayBlur: 5,
          excludeChildFromBlur: true,
          child: CMaker(
            height: 200,
            width: 200,
            color: Colors.blue,
            child:Text('Hello'),
          ),
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Hello'),
                Text('World'),
              ],
            );
          },
        )
        ],));
  }
}








// Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           CustomPopupMenu(
//             overlayBlur: 1,
//             excludeChildFromBlur: true,
//             direction: PopupDirection.bottom,
//             slideReverse: true,
//             animationType: PopupAnimationType.slide,
//             builder: (context) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text('Hello'),
//                 Text('World'),
//               ],
//             );
//           },child: CMaker(height: 100,width: 100,circularRadius: 15,color: Colors.red,)),
//           CMaker(height: 100,width: 100,circularRadius: 15,color: Colors.red,),
//           CMaker(height: 100,width: 100,circularRadius: 15,color: Colors.red,),
//           CMaker(height: 100,width: 100,circularRadius: 15,color: Colors.red,),
//         ],
//       ),
