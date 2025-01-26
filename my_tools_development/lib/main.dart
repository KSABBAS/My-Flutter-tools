import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:my_tools_development/MyTools/MyFunctionTools.dart';
import 'package:my_tools_development/MyTools/MyTools.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyExpandingColumnWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyExpandingRowWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/Selector_Tools/MyRowWidgetSelector.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/DistributiveGView.dart';

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
    return MyExpandingRowWidgetSelector(
      iconsList: [
        Icon(Icons.abc),
        Icon(Icons.home),
        Icon(Icons.home),
        Icon(Icons.home),
        Icon(Icons.home),
        Icon(Icons.abc),
        Icon(Icons.home),
        Icon(Icons.home),
        Icon(Icons.home),
        Icon(Icons.home),
        Icon(Icons.abc),
        Icon(Icons.home),
        Icon(Icons.home),
        Icon(Icons.home),
        Icon(Icons.home),
      ],
      // reverseDirection: true,
      betweenSpaces: 150,
      height: 200,
      onChange: (index) {},
    );
    // DistributiveGView(
    //     itemCount: 20,
    //     itemBuilder: (context, index) {
    //       return Container(
    //         color: Colors.blue,
    //         child: Center(
    //           child: Text("Item $index"),
    //         ),
    //       );
    //     },
    //     itemHeight: 500,
    //     itemWidth: 400,
    //     mainAxisSpacing: 20,
    //     crossAxisSpacing: 20,
    //     surroundpadding: EdgeInsets.all(20),
    //     );
    // SearchAppBar(
    //   crossAxisCount: 1,
    //   childHeight: 150,
    //   columnSpaces: 40,
    //   rowSpaces: 40,
    //   appBarColor: Colors.white,
    //   appBarHeight: 70,
    //   body: [
    //     Center(
    //       child: Text("1"),
    //     ),
    //     Center(
    //       child: Text("2"),
    //     ),
    //     Center(
    //       child: Text("3"),
    //     )
    //   ][PageIndex],
    //   childWidth: 300,
    //   onSelected: (SelectedIndex) {
    //     print(data[data.keys.elementAt(SelectedIndex)]);
    //   },
    //   itemCount: data.length,
    //   builder: (Index) {
    //     return Center(child: Text(data[data.keys.elementAt(Index)]));
    //   },
    //   FilterWidget:
    //       IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt_rounded)),
    //   SortWidget: IconButton(onPressed: () {}, icon: Icon(Icons.sort)),
    //   SubAppBarVisible: true,
    //   onTheSearch: (isOnTheSearch, value) {
    //     isOnTheSearch1=isOnTheSearch;
    //     if (isOnTheSearch) {
    //       data = {
    //         "title 1": "value 1",
    //         "title 2": "value 2",
    //         "title 3": "value 3",
    //         "title 4": "value 4",
    //         "title 5": "value 5",
    //         "title 6": "value 6",
    //       };
    //       print("searching for $value");
    //     } else {
    //       print("not searching ");
    //     }
    //     setState(() {});
    //   },
    //   OnTheRightWidget:(!isOnTheSearch1)? MyRowWidgetSelector(
    //     iconsList: [
    //       Icon(Icons.home_outlined),
    //       Icon(Icons.tv_outlined),
    //       Icon(Icons.person_outline_rounded)
    //     ],
    //     height: 60,
    //     width: 200,
    //     onChange: (index) {
    //       PageIndex = index!;
    //       setState(() {});
    //     },
    //   ):null,
    // );
  }
}
