import 'dart:io';

import 'package:flutter/material.dart';
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

double rating1 = 0;
double rating2 = 0;
double rating3 = 0;

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StarRating(
            onRatingChanged: (value) {
              rating1 = value.toDouble();
              print((rating1+rating2+rating3)/3);
              setState(() {
                
              });
            },
            initialRating: rating1.toInt(),
            starEdgeStyle: StarEdgeStyle.smooth,
            starSpacing: 10,
            unselectedStrokeColor: Colors.red,
          ),
          StarRating(
            onRatingChanged: (value) {
              rating2 = value.toDouble();
              print((rating1+rating2+rating3)/3);
              setState(() {
                
              });
            },
            initialRating: rating2.toInt(),
            starEdgeStyle: StarEdgeStyle.smooth,
            starSpacing: 10,
            unselectedStrokeColor: Colors.red,
          ),
          StarRating(
            onRatingChanged: (value) {
              rating3 = value.toDouble();
              print((rating1+rating2+rating3)/3);
              setState(() {
                
              });
            },
            initialRating: rating3.toInt(),
            starEdgeStyle: StarEdgeStyle.smooth,
            starSpacing: 10,
            unselectedStrokeColor: Colors.red,
          ),
           StarRatingDisplay(
            key: ValueKey((rating1+rating2+rating3)/3),
            rating: (rating1+rating2+rating3)/3,
            starSpacing: 10,
            unselectedStrokeColor: Colors.red,
            animationDuration: Duration(milliseconds: 0),
          ),

        ],
      ),
    );
  }
}
