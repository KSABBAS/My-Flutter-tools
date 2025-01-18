import 'package:flutter/material.dart';
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

  List data = [
    [
      "ahmed 1", //value
      false, //state
      "hi 1", //title
      Icon(Icons.home)
    ],
    [
      "ahmed 2", //value
      false, //state
      "hi 2", //title
      Icon(Icons.home)
    ],
    [
      "ahmed 3", //value
      false, //state
      "hi 3", //title
      Icon(Icons.home)
    ],
  ];
class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MySwitchBuilder(
      dataList: data,
      BackLayerColorOff: Colors.red,
      BallColorOff: Colors.green,
      BallColorOn: Colors.amber,
      onChange: () {
        
        print("1");
      },
    );
  }
}

class MySwitchBuilder extends StatefulWidget {
  MySwitchBuilder({
    super.key,
    this.SwitchHeight,
    this.SwitchWidth,
    this.BackLayerColorOn,
    required this.dataList,
    required this.BackLayerColorOff,
    required this.BallColorOff,
    required this.BallColorOn,
    this.OffIconBall,
    this.ONIconBall,
    this.SwitchHeight2,
    this.SwitchWidth2,
    this.colorcmaker2,
    this.onChange,
    this.Cardcolorincmaker2,
    this.style,
    this.marginInRowCard,
    this.paddingInRowCard,
    this.paddingInRowCard2,
  });

  double? SwitchHeight;
  List dataList;
  double? SwitchWidth;
  double? SwitchHeight2;
  double? SwitchWidth2;
  Color? BackLayerColorOff;
  Color? colorcmaker2;
  Color? BackLayerColorOn;
  Color? BallColorOn;
  Color? BallColorOff;
  Color? Cardcolorincmaker2;
  Icon? OffIconBall;
  Icon? ONIconBall;
  EdgeInsetsGeometry? paddingInRowCard;
  EdgeInsetsGeometry? paddingInRowCard2;
  TextStyle? style;
  EdgeInsetsGeometry? marginInRowCard;

  Function()? onChange;

  @override
  State<MySwitchBuilder> createState() => _MySwitchBuilderState();
}

class _MySwitchBuilderState extends State<MySwitchBuilder> {
  @override
  Widget build(BuildContext context) {
    return CMaker(
      height: 300,
      width: double.infinity,
      child: ListView.builder(
        itemCount: widget.dataList.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                if (widget.dataList[index][1]) {
                  widget.dataList[index][1] = false;
                  widget.OffIconBall;
                  widget.BackLayerColorOff;
                  widget.BallColorOff;
                } else {
                  widget.dataList[index][1] = true;
                  widget.ONIconBall;
                  widget.BackLayerColorOn;
                  widget.BallColorOn;
                }
                widget.onChange!();
                setState(() {});
              },
              child: Card(
                color: widget.Cardcolorincmaker2,
                child: Container(
                  color: widget.colorcmaker2,
                  width: widget.SwitchWidth2,
                  height: widget.SwitchHeight2,
                  child: Row(
                    children: [
                      Container(
                        padding: widget.paddingInRowCard2,
                        child: widget.dataList[index][3],
                      ),
                      Padding(
                        padding: widget.paddingInRowCard ?? EdgeInsets.only(),
                        child: Text(
                          widget.dataList[index][2] ?? "",
                          style: widget.style,
                        ),
                      ),
                      Spacer(),
                      Container(
                          alignment: Alignment.center,
                          height: widget.SwitchHeight ?? 80,
                          width: widget.SwitchWidth ?? 70,
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                height: (widget.SwitchHeight ?? 40) - 20,
                                width: (widget.SwitchWidth ?? 50) - 2,
                                decoration: BoxDecoration(
                                    color: (widget.dataList[index][1])
                                        ? widget.BackLayerColorOn
                                        : widget.BackLayerColorOff,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 280),
                                height: widget.SwitchHeight ?? 50,
                                width: widget.SwitchWidth ?? 100,
                                alignment: (widget.dataList[index][1])
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  child: (widget.dataList[index][1])
                                      ? widget.ONIconBall
                                      : widget.OffIconBall,
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      color: (widget.dataList[index][1])
                                          ? widget.BallColorOn
                                          : widget.BallColorOff,
                                      borderRadius: BorderRadius.circular(500)),
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
