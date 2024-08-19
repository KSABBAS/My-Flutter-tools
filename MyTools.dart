import 'dart:async';
import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/parser.dart' as Parser;
// import 'package:html/dom.dart' as dom;
// import 'package:html/dom_parsing.dart';
// import 'package:html/html_escape.dart';
// import 'package:beautiful_soup_dart/beautiful_soup.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:lottie/lottie.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

class CMaker extends StatefulWidget {
  CMaker(
      {super.key,
      required this.child,
      this.height,
      this.width,
      this.boxShadow,
      this.border,
      this.BackGroundimage,
      this.margin,
      this.padding,
      this.alignment,
      this.color,
      this.gradient,
      this.circularRadius});
  Color? color;
  double? height;
  double? width;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  DecorationImage? BackGroundimage;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
  BoxBorder? border;
  double? circularRadius;
  Widget child;
  @override
  State<CMaker> createState() => _CMakerState();
}

class _CMakerState extends State<CMaker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.alignment,
      padding: widget.padding,
      margin: widget.margin,
      decoration: BoxDecoration(
          gradient: widget.gradient,
          image: widget.BackGroundimage,
          border: widget.border,
          color: widget.color,
          boxShadow: widget.boxShadow,
          borderRadius: BorderRadius.circular(
            widget.circularRadius ?? 0,
          )),
      height: widget.height,
      width: widget.width,
      child: widget.child,
    );
  }
}

class TMaker extends StatelessWidget {
  TMaker(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.textAlign});
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}

dynamic TStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
}

class TFMaker extends StatefulWidget {
  TFMaker(
      {super.key,
      required this.prefix,
      required this.enabledBorderwidth,
      required this.focusedBorderwidth,
      required this.enabledBorderColor,
      required this.focusedBorderColor,
      required this.suffix,
      required this.focusedCircularRadius,
      required this.enabledCircularRadius,
      required this.hintText,
      required this.hintStyle,
      required this.label});
  Widget? prefix;
  Widget? suffix;
  String? hintText;
  Widget? label;
  TextStyle? hintStyle;
  double? enabledCircularRadius;
  double? disabledCircularRadius;
  double? focusedCircularRadius;
  double? enabledBorderwidth;
  double? disabledBorderwidth;
  double? focusedBorderwidth;
  Color? enabledBorderColor;
  Color? disabledBorderColor;
  Color? focusedBorderColor;
  @override
  State<TFMaker> createState() => _TFMakerState();
}

class _TFMakerState extends State<TFMaker> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefix: widget.prefix,
          suffix: widget.suffix,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          label: widget.label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.enabledBorderColor!,
                width: widget.enabledBorderwidth!),
            borderRadius:
                BorderRadius.circular(widget.enabledCircularRadius ?? 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.focusedBorderColor!,
                width: widget.focusedBorderwidth!),
            borderRadius:
                BorderRadius.circular(widget.focusedCircularRadius ?? 0),
          )),
    );
  }
}

double PageHeight(BuildContext context) {
  List l = [2.2];
  final Sheigt = MediaQuery.of(context).size.height;
  l.add(Sheigt);
  return l[1];
}

double PageWidth(BuildContext context) {
  List l = [2.2];
  final Swidth = MediaQuery.of(context).size.width;
  l.add(Swidth);
  return l[1];
}

// status bar code , inset it in the runApp (SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);)

// to remove the red debug , insert it inside the materialApp (debugShowCheckedModeBanner: false,)

class SplashViewPage extends StatefulWidget {
  const SplashViewPage({super.key});
  @override
  State<SplashViewPage> createState() => _SplashViewPageState();
}

class _SplashViewPageState extends State<SplashViewPage>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? fading;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    fading = Tween<double>(begin: 0, end: 1).animate(animationController!)
      ..addListener(() {
        setState(() {
          if (animationController!.isCompleted) {
            Timer(Duration(milliseconds: 300), () {
              Navigator.pushReplacementNamed(context, "LogInPage");
            });
          }
        });
      });
    animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
              Color.fromARGB(255, 8, 125, 159),
              Color.fromARGB(255, 74, 193, 241)
            ])),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(flex: 10, child: Container()),
              Expanded(
                  flex: 7,
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 8,
                          child: Opacity(
                            opacity: fading?.value,
                            child: Container(
                              child: Image.asset("images/Logo.png"),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )),
                    ],
                  )),
              Expanded(flex: 10, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

class GVBuilder extends StatefulWidget {
  GVBuilder(
      {super.key,
      required this.scroll,
      required this.list,
      required this.crossAxisCount,
      this.mainAxisSpacing,
      this.crossAxisSpacing,
      required this.onTap,
      this.boxShadow,
      this.border,
      this.BackGroundimage,
      this.margin,
      this.padding,
      this.alignment,
      this.color,
      this.gradient,
      this.circularRadius});
  bool? scroll;
  List list;
  Color? color;
  int? crossAxisCount;
  double? mainAxisSpacing;
  double? crossAxisSpacing;
  void Function()? onTap;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  DecorationImage? BackGroundimage;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
  BoxBorder? border;
  double? circularRadius;
  @override
  State<GVBuilder> createState() => _GVBuilderState();
}

class _GVBuilderState extends State<GVBuilder> {
  @override
  Widget build(BuildContext context) {
    ScrollPhysics? physi;
    if (widget.scroll ?? true) {
      physi = null;
    } else {
      physi = NeverScrollableScrollPhysics();
    }
    return GridView.builder(
      shrinkWrap: widget.scroll!,
      physics: physi,
      itemCount: widget.list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount ?? 1,
          mainAxisSpacing: widget.mainAxisSpacing ?? 0,
          crossAxisSpacing: widget.crossAxisSpacing ?? 0),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              setState(() {
                widget.onTap;
              });
            },
            child: Container(
                alignment: widget.alignment,
                padding: widget.padding,
                margin: widget.margin,
                decoration: BoxDecoration(
                    gradient: widget.gradient,
                    image: widget.BackGroundimage,
                    border: widget.border,
                    color: widget.color,
                    boxShadow: widget.boxShadow,
                    borderRadius: BorderRadius.circular(
                      widget.circularRadius ?? 0,
                    )),
                child: widget.list[index]));
      },
    );
  }
}

class DDButton extends StatefulWidget {
  DDButton({super.key, required this.values});
  // void Function()? onChosen;
  List values = [];
  var commonVar;
  @override
  State<DDButton> createState() => _DDButtonState();
}

class _DDButtonState extends State<DDButton> {
  @override
  Widget build(BuildContext context) {
    widget.commonVar = widget.values[0];
    List<DropdownMenuItem<Object?>>? t(List values) {
      List<DropdownMenuItem<Object?>>? list = [];
      for (int i = 0; i < values.length; i++) {
        list.add(
          DropdownMenuItem(
            child: Text(values[i].toString()),
            value: values[i],
          ),
        );
      }
      return list;
    }

    return DropdownButton(
        onChanged: (val) {
          setState(() {
            widget.commonVar = val;
          });
        },
        underline: Container(),
        value: widget.commonVar,
        items: t(widget.values));
  }
}

class RButton extends StatefulWidget {
  RButton({
    super.key,
    required this.list,
    required this.crossAxisCount,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
  });
  List list;
  int? crossAxisCount;
  double? mainAxisSpacing;
  double? crossAxisSpacing;
  @override
  State<RButton> createState() => _RButtonState();
}

var selected = "";

class _RButtonState extends State<RButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: GridView.builder(
        itemCount: widget.list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount ?? 1,
            mainAxisSpacing: widget.mainAxisSpacing ?? 0,
            crossAxisSpacing: widget.crossAxisSpacing ?? 0),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(96, 216, 216, 216),
            ),
            child: RadioListTile(
                activeColor: Color.fromARGB(255, 74, 193, 241),
                title: Text(
                  widget.list[index],
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                ),
                value: widget.list[index],
                groupValue: selected,
                onChanged: (val) {
                  setState(() {
                    selected = val;
                  });
                }),
          );
        },
      ),
    );
  }
}

// Future<List> getjasonData(String link) async {
//   var res = await get(Uri.parse("$link"));
//   List resDecoded = jsonDecode(res.body);
//   return resDecoded;
// }

// class GetAndDisplayTextJsonData extends StatefulWidget {
//   GetAndDisplayTextJsonData({super.key, required this.link, required this.tag});
//   String link;
//   String tag;
//   @override
//   State<GetAndDisplayTextJsonData> createState() =>
//       _GetAndDisplayTextJsonDataState();
// }

// class _GetAndDisplayTextJsonDataState extends State<GetAndDisplayTextJsonData> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List>(
//         future: getjasonData("${widget.link}"),
//         builder: (context, t) {
//           if (t.connectionState == ConnectionState.waiting) {
//             return Center(child: Expanded(child: CircularProgressIndicator()));
//           } else {
//             return ListView.builder(
//                 itemCount: t.data!.length,
//                 itemBuilder: (context, ind) {
//                   return Card(
//                     child: Container(
//                         margin: EdgeInsets.all(10),
//                         alignment: Alignment.center,
//                         child: Text("${t.data![ind]["${widget.tag}"]}")),
//                   );
//                 });
//           }
//         });
//   }
// }

// Future<List> ScrapeByClass(String link, String tag, String class_) async {
//   String html = "";
//   List result = [];
//   http.Response t = await http.get(Uri.parse(link));
//   html = dom.Document.html(t.body).outerHtml;
//   BeautifulSoup soup = BeautifulSoup(html);
//   for (var vercs in soup.findAll(tag, class_: class_)) {
//     result.add(vercs.text);
//   }
//   return result;
// }

// class Scrape extends StatefulWidget {
//   Scrape(
//       {super.key, required this.link, required this.tag, required this.class_});
//   String link;
//   String tag;
//   String class_;
//   @override
//   State<Scrape> createState() => _ScrapeState();
// }

// class _ScrapeState extends State<Scrape> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List>(
//         future: ScrapeByClass(widget.link, widget.tag, widget.class_),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else {
//             return Container();
//           }
//         });
//   }
// }

// bool IsConnectedToInternet() {
//   Future<bool> check() async {
//     var state = await Connectivity().checkConnectivity();
//     print(state.first);
//     return state.first.toString() == "ConnectivityResult.none";
//   }
//   return true;
// }
// Future PhotoImageFromGalary() async {
//   return await ImagePicker().pickImage(source: ImageSource.gallery);
// }
class NavBar extends StatefulWidget {
  NavBar({
    super.key,
    required this.pages,
    required this.initIndex,
    required this.iconsList,
    this.orientation,
    required this.height,
    required this.width,
    this.barColor,
    this.sectedIconColor,
    this.pageBackgroundColor,
    this.iconBackgroundColor,
    this.unselectedIconColor,
    this.iconSize,
    this.iconFrameHeight,
    this.iconFrameWidth
  });
  List pages;
  int initIndex;
  List iconsList;
  String? orientation;
  double height;
  double width;
  double? iconFrameHeight;
  double? iconFrameWidth;
  Color? barColor;
  Color? sectedIconColor;
  Color? unselectedIconColor;
  Color? iconBackgroundColor;
  Color? pageBackgroundColor;
  double? iconSize;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
  int PageIndex = widget.initIndex;
    late Widget BarBody;
    if (widget.orientation == "vertical") {
      BarBody = Stack(
        children: [
          CMaker(
                  color: widget.pageBackgroundColor ?? Colors.white,
                  width: double.infinity,
                  child: widget.pages[PageIndex]),
          Positioned(
            top: (PageHeight(context) - widget.height) / 2,
            left: 20,
            child: CMaker(
              circularRadius: 20,
              color: widget.barColor ?? Colors.white,
              height: widget.height,
              width: widget.width,
              child: Column(
                children: [
                  Container(
                    height: (widget.height - (widget.iconsList.length * (widget.iconFrameHeight??60))) /
                        (widget.iconsList.length + 1),
                  ),
                  CMaker(
                    height: widget.height-(widget.height - (widget.iconsList.length * (widget.iconFrameHeight??60))) /
                        (widget.iconsList.length + 1),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: false,
                        itemCount: widget.iconsList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    print(index);
                                    PageIndex = index;
                                  });
                                },
                                child: CMaker(
                                    alignment: Alignment.center,
                                    child: CMaker(
                                      alignment: Alignment.center,
                                      height: widget.iconFrameHeight??60,
                                    width: widget.iconFrameWidth??60,
                                        circularRadius: 15,
                                        color: (PageIndex == index)
                                            ? widget.iconBackgroundColor ??
                                                Color.fromARGB(255, 0, 0, 0)
                                            : widget.unselectedIconColor,
                                        child: Icon(
                                          widget.iconsList[index],
                                          color: (PageIndex == index)
                                              ? widget.sectedIconColor ??
                                                  Colors.white
                                              : widget.unselectedIconColor ??
                                                  Colors.black,
                                          size: widget.iconSize,
                                        ))),
                              ),
                              Container(
                                height: (widget.height -
                                        (widget.iconsList.length * (widget.iconFrameHeight??60))) /
                                    (widget.iconsList.length + 1),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      BarBody = Stack(
        children: [
          CMaker(
            height: double.infinity,
                  color: widget.pageBackgroundColor ?? Colors.white,
                  width: double.infinity,
                  child: widget.pages[PageIndex]),
          Positioned(
            left: (PageWidth(context) - widget.width) / 2,
            bottom: 20,
            child: CMaker(
              circularRadius: 20,
              color: widget.barColor ?? Colors.white,
              height: widget.height,
              width: widget.width,
              child: Row(
                children: [
                  Container(
                    width: (widget.width - (widget.iconsList.length * (widget.iconFrameWidth??60))) /
                        (widget.iconsList.length + 1),
                  ),
                  CMaker(
                    width: widget.width-(widget.width - (widget.iconsList.length * (widget.iconFrameWidth??60))) /
                        (widget.iconsList.length + 1),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: false,
                        itemCount: widget.iconsList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    print(index);
                                    PageIndex = index;
                                  });
                                },
                                child: CMaker(
                                    alignment: Alignment.center,
                                    child: CMaker(
                                      alignment: Alignment.center,
                                      height: widget.iconFrameHeight??60,
                                    width: widget.iconFrameWidth??60,
                                        circularRadius: 15,
                                        color: (PageIndex == index)
                                            ? widget.iconBackgroundColor ??
                                                Color.fromARGB(255, 0, 0, 0)
                                            : widget.unselectedIconColor,
                                        child: Icon(
                                          widget.iconsList[index],
                                          color: (PageIndex == index)
                                              ? widget.sectedIconColor ??
                                                  Colors.white
                                              : widget.unselectedIconColor ??
                                                  Colors.black,
                                          size: widget.iconSize,
                                        ))),
                              ),
                              Container(
                                width: (widget.width -
                                        (widget.iconsList.length * (widget.iconFrameWidth??60))) /
                                    (widget.iconsList.length + 1),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return Scaffold(body: BarBody);
  }
}
class NowClock extends StatefulWidget {
  NowClock({super.key,this.BackGroundColor});
  Color? BackGroundColor;
  @override
  State<NowClock> createState() => _NowClockState();
}

class _NowClockState extends State<NowClock> with TickerProviderStateMixin {
  double SecondOp = 1;
  double MinuteOp = 1;
  double HourOp = 1;
  bool Start = true;
  AlignmentGeometry ali = Alignment.center;
  bool FadeIn = true;
  SecondRe() async {
    while (true) {
      setState(() {
        FadeIn = true;
        SecondOp = 0;
        ali = Alignment.topCenter;
      });
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        FadeIn = true;
        SecondOp = 1;
        ali = Alignment.center;
      });
      await Future.delayed(Duration(milliseconds: 600));
      setState(() {
        FadeIn = true;
        SecondOp = 0;
        ali = Alignment.bottomCenter;
      });
      await Future.delayed(Duration(milliseconds: 200));
      Start = false;
    }
  }

  @override
  void initState() {
    super.initState();
    SecondRe();
  }

  @override
  Widget build(BuildContext context) {
    Widget HourTW = TMaker(
        text: (DateTime.now().hour.toInt() > 11)
            ? DateTime.now().add(Duration(hours: -11)).hour.toString()
            : DateTime.now().add(Duration(hours: 1)).hour.toString(),
        fontSize: 50,
        fontWeight: FontWeight.w800,
        color: Colors.white);
    Widget MinutesTW = TMaker(
        text: DateTime.now().minute.toString(),
        fontSize: 50,
        fontWeight: FontWeight.w800,
        color: Colors.white);
    Widget SecondsTW = TMaker(
        text: DateTime.now().second.toString(),
        fontSize:  50 ,
        fontWeight: FontWeight.w800,
        color: Colors.white);
    return CMaker(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: Container()),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.BackGroundColor??const Color.fromARGB(255, 255, 0, 0),
                ),
                alignment: Alignment.center,
                height: 100,
                width: 100,
              ),
              AnimatedOpacity(
                opacity: HourOp,
                duration: Duration(seconds: (Start) ? 1 : 3598),
                child: AnimatedContainer(
                    duration: Duration(seconds: (Start) ? 1 : 3598),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.BackGroundColor??const Color.fromARGB(255, 255, 0, 0),
                    ),
                    height: 100,
                    alignment: ali,
                    width: 100,
                    child: HourTW),
              ),
            ],
          ),
          Expanded(child: Container()),
          TMaker(
              text: ":",
              fontSize: 50,
              fontWeight: FontWeight.w800,
              color: Colors.white),
          Expanded(child: Container()),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.BackGroundColor??const Color.fromARGB(255, 255, 0, 0),
                ),
                alignment: Alignment.center,
                height: 100,
                width: 100,
              ),
              AnimatedOpacity(
                opacity: MinuteOp,
                duration: Duration(seconds: (Start) ? 1 : 58),
                child: AnimatedContainer(
                    duration: Duration(seconds: (Start) ? 1 : 58),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.BackGroundColor??const Color.fromARGB(255, 255, 0, 0),
                    ),
                    height: 100,
                    alignment: ali,
                    width: 100,
                    child: MinutesTW),
              ),
            ],
          ),
          Expanded(child: Container()),
          TMaker(
              text: ":",
              fontSize: 50,
              fontWeight: FontWeight.w800,
              color: Colors.white),
          Expanded(child: Container()),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.BackGroundColor??const Color.fromARGB(255, 255, 0, 0),
                ),
                alignment: Alignment.center,
                height: 100,
                width: 100,
              ),
              AnimatedOpacity(
                opacity: SecondOp,
                duration: Duration(milliseconds: 150),
                child: AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: widget.BackGroundColor??const Color.fromARGB(255, 255, 0, 0),
                    ),
                    height: 100,
                    alignment: ali,
                    width: 100,
                    child: SecondsTW),
              ),
            ],
          ),
          Expanded(flex: 3, child: Container()),
        ],
      ),
    );
  }
}
