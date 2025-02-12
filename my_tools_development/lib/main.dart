import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_tools_development/MyTools/Functions/Height_and_width_Functions.dart';
import 'package:my_tools_development/MyTools/Functions/MyResponsive.dart';
import 'package:my_tools_development/MyTools/MyFunctionTools.dart';
import 'package:my_tools_development/MyTools/MyTools.dart';
import 'package:my_tools_development/MyTools/tools/App_Containing_Tools/SearchAppBar.dart';
import 'package:my_tools_development/MyTools/tools/Audio_tools/miniAudioPlayer.dart';
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
import 'package:my_tools_development/MyTools/tools/Video_Tools/miniVideoPlayer/miniVideoPlayer.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/DistributiveGView.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/Specific_height_width_grid.dart';
import 'package:my_tools_development/MyTools/Functions/WidgetListBuilder.dart';

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

List data = [
  [1, DateTime(2025, 2, 1), 15.99, "Wireless Mouse"],
  [2, DateTime(2025, 1, 28), 89.49, "Bluetooth Headphones"],
  [3, DateTime(2025, 2, 3), 42.99, "Mechanical Keyboard"],
  [4, DateTime(2025, 1, 30), 7.99, "USB Flash Drive 32GB"],
  [5, DateTime(2025, 1, 25), 299.99, "Smartwatch Series 6"],
  [6, DateTime(2025, 2, 5), 18.49, "Portable Phone Stand"],
  [7, DateTime(2025, 1, 15), 54.99, "External Hard Drive 1TB"],
  [8, DateTime(2025, 1, 20), 1299.99, "Gaming Laptop"],
  [9, DateTime(2025, 2, 4), 23.99, "Wireless Charger"],
  [10, DateTime(2025, 1, 27), 5.99, "Stylus Pen"],
  [11, DateTime(2025, 1, 18), 699.99, "Smartphone"],
  [12, DateTime(2025, 2, 2), 44.99, "Backpack with USB Port"],
  [13, DateTime(2025, 1, 26), 15.49, "Gaming Mouse Pad"],
  [14, DateTime(2025, 1, 29), 249.99, "Noise-Canceling Earbuds"],
  [15, DateTime(2025, 1, 22), 75.00, "Mini Projector"],
  [16, DateTime(2025, 1, 17), 9.99, "Portable Fan"],
  [17, DateTime(2025, 1, 24), 349.99, "Wireless Speaker"],
  [18, DateTime(2025, 2, 6), 25.00, "Ergonomic Office Chair"],
  [19, DateTime(2025, 1, 19), 6.49, "Laptop Cooling Pad"],
  [20, DateTime(2025, 2, 1), 49.99, "Monitor Stand Riser"]
];

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomVideoPlayer(videoSource: "videos/1.mp4", isAsset: true,containerHeight: 300,containerWidth: 400));
  }

  //   return SearchAppBar(

  //       body: CMaker(color: Colors.red,),
  //       childHeight: 100,
  //       childWidth: 200,
  //       onAlphabetFilterChanged: (value) => print(value),
  //       onDateFilterChanged: (value) => print(value),
  //       onPriceFilterChanged: (value) => print(value),
  //       products: MyListBuilder(
  //         itemCount: data.length,
  //         builder: (index) {
  //           return Product(
  //               id: data[index][0],
  //               name: data[index][3],
  //               price: data[index][2],
  //               date: data[index][1]);
  //         },
  //       ),
  //       // childColor: Colors.green,
  //       // rowSpaces: 20,

  //       // columnSpaces: 20,
  //       // drawerWidth:400,
  //       productBuilder: (product) {
  //         return Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Text("${product.id}"),
  //             Text("${product.name}"),
  //             Text("${product.price}"),
  //             Text("${product.date}")
  //           ],
  //         );
  //       });
}
// onAlphabetFilterChanged: (value) => print(value),
//         onDateFilterChanged: (value) => print(value),
//         onPriceFilterChanged: (value) => print(value),
//         onAlphabetSliderChanged: (value) => print(value),
//         onDateSliderChanged:(value) =>  print(value),
//         onPriceSliderChanged: (value) => print(value),
//         onAlphabetSliderChangeEnd: (value) => print(value),
//         onPriceSliderChangeEnd: (value) => print(value),
//         onDateSliderChangeEnd: (value) => print(value),
//         childHeight: 100,
//         childWidth: 200,
//         onTheSearch: (isOnTheSearch, SearchText) {
//           setState(() {});
//         },
//         SubAppBarVisible: true,
//         SortWidget: Icon(Icons.sort),
//         FilterWidget: Icon(Icons.filter),
//         childColor: Colors.red,
//         rowSpaces: 20,
//         columnSpaces: 20,
//         appBarColor: Colors.white,
//         appBarHeight: 150,
//         drawerWidth: 400,
//         sortDrawerSide: DrawerSide.left,
//         productBuilder: (product) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text("${product.id}"),
//               Text("${product.name}"),
//               Text("${product.price}"),
//               Text("${product.date}")
//             ],
//           );
//         },
//         products: MyListBuilder(
//           itemCount: data.length,
//           builder: (index) {
//             return Product(
//                 id: data[index][0],
//                 name: data[index][3],
//                 price: data[index][2],
//                 date: data[index][1]);
//           },
//         )
