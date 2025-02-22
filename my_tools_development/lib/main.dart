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
import 'package:my_tools_development/MyTools/tools/Button_Tools/ExpandableThrowableButton.dart';
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
import 'package:my_tools_development/MyTools/tools/Timer_Tools/FlipTimer.dart';
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
    return MyFloatingIcon(
      floatingWidget: DraggableFloatingMenu(
          initialPosition: Offset(20, 100),
          itemCount: 4,
          // Build each item with a callback (index provided)
          itemBuilder: (context, index) {
            // Example: alternate background colors and display the index.
            return Container(
              width: 200, // You can override via menuItemWidth if desired.
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: index.isEven ? Colors.white : Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text('Custom Item $index'),
                ],
              ),
            );
          },
          // FAB customizations:
          fabColor: const Color.fromARGB(255, 58, 150, 183),
          fabSize: 60,
          fabIcon: const Icon(Icons.menu, color: Colors.white),
          // Popup Menu customizations:
          menuWidth: 220,
          // Each item's fixed height.
          menuItemHeight: 50,
          // Global popup background (set transparent to have a "floating" look).
          menuBackgroundColor: Colors.transparent,
          // Global menu item style parameters (applied to all items if needed).
          menuItemWidth: 200,
          menuItemPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          menuItemMargin: const EdgeInsets.symmetric(vertical: 2.0),
          menuItemAlignment: Alignment.centerLeft,
          menuItemSpacing: 4.0,
          menuItemDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          animationDuration: const Duration(milliseconds: 300),
          animationCurve: Curves.easeOut,
        ),
      body: Container(
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
              child: MyFlipRotateTimer(
            initialDuration: Duration(seconds: 12),
            displayMode: DisplayMode.current12h,
            customTime: TimeFlipEvent(hour: 7, minute: 37, second: 23,period:"AM"),
            onSecondFlip: (value) {
              print(value.second);
            },
            onComplete: () {
              print("done");
            },
          ))),
    );
  }
}























// MyFlipRotateTimer(
//             animationMode: AnimationMode.flip,
//             displayMode: DisplayMode.current12h,
//             initialDuration: Duration(minutes: 2),
//             onSecondFlip: (value) {
//               print(value);
//             },
//           ),