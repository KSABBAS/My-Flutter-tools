import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/CMaker_Tools/CMaker.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/DistributiveGView.dart';

class SearchAppBar extends StatefulWidget {
  SearchAppBar({
    super.key,
    required this.childHeight,
    this.appBarHeight,
    this.appBarColor,
    this.body,
    this.Scroll,
    this.childAlignment,
    this.childBackGroundimage,
    this.childBorder,
    this.childBoxShadow,
    this.childCircularRadius,
    this.childColor,
    this.childGradient,
    this.childPadding,
    this.childWidth,
    this.columnSpaces,
    required this.onSelected,
    this.rowSpaces,
    required this.builder,
    required this.itemCount,
    this.FilterWidget,
    this.SortWidget,
    this.SubAppBarVisible,
    required this.onTheSearch,
    this.OnTheRightWidget,
    this.SearchIcon,
    this.SearchIconVisible,
    this.barLeftPadding,
    this.barRightPadding,
    this.paddingBetweenSearchBarAndRightWidget,
    this.onValueChange,
    this.onSearchTapped,
    this.OnTheLeftWidget,
    this.paddingBetweenSearchBarAndLeftWidget,
  });
  // AppBar & overall parameters:
  double? appBarHeight;
  Color? appBarColor;
  Widget? body;
  // Grid parameters:
  double childHeight;
  double? childWidth;
  Color? childColor;
  AlignmentGeometry? childAlignment;
  EdgeInsetsGeometry? childPadding;
  DecorationImage? childBackGroundimage;
  List<BoxShadow>? childBoxShadow;
  Gradient? childGradient;
  BoxBorder? childBorder;
  double? childCircularRadius;
  double? rowSpaces;
  double? columnSpaces;
  int itemCount;
  bool? Scroll;
  // Builder and callbacks:
  Widget Function(int Index) builder;
  Function(bool isOnTheSearch, String SearchText)? onTheSearch;
  Function(String value)? onValueChange;
  Function(int SelectedIndex) onSelected;
  Function()? onSearchTapped;
  // Extra widgets in the app bar:
  Widget? FilterWidget;
  Widget? SortWidget;
  bool? SubAppBarVisible;
  bool? SearchIconVisible;
  Icon? SearchIcon;
  Widget? OnTheRightWidget;
  Widget? OnTheLeftWidget;
  // Padding for the app bar:
  double? barLeftPadding;
  double? barRightPadding;
  double? paddingBetweenSearchBarAndRightWidget;
  double? paddingBetweenSearchBarAndLeftWidget;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool inSearch = false;
  String SearchText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          // App Bar portion:
          Container(
            padding: EdgeInsets.only(
                left: widget.barLeftPadding ?? 30,
                right: widget.barRightPadding ?? 30),
            color: widget.appBarColor ?? Colors.blue,
            height: widget.appBarHeight ?? 100,
            width: double.infinity,
            child: Column(
              children: [
                Spacer(),
                Row(
                  children: [
                    (widget.OnTheLeftWidget != null)
                        ? widget.OnTheLeftWidget!
                        : Container(),
                    (widget.OnTheLeftWidget != null)
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: widget
                                        .paddingBetweenSearchBarAndLeftWidget ??
                                    20))
                        : Container(),
                    (inSearch)
                        ? IconButton(
                            onPressed: () {
                              if (widget.onTheSearch != null) {
                                inSearch = false;
                                widget.onTheSearch!(inSearch, SearchText);
                              }
                            },
                            icon: Icon(Icons.arrow_back))
                        : Container(),
                    (inSearch)
                        ? Padding(padding: EdgeInsets.only(left: 10))
                        : Container(),
                    Expanded(
                      child: CMaker(
                        circularRadius: 5,
                        color: Colors.white,
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          onChanged: (value) {
                            SearchText = value;
                            if (widget.onValueChange != null) {
                              widget.onValueChange!(value);
                            }
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              inSearch = true;
                            });
                            if (widget.onTheSearch != null) {
                              widget.onTheSearch!(inSearch, SearchText);
                            }
                          },
                          onTap: () {
                            if (widget.onSearchTapped != null) {
                              widget.onSearchTapped!();
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: (widget.SearchIconVisible ?? true)
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          inSearch = true;
                                        });
                                        if (widget.onTheSearch != null) {
                                          widget.onTheSearch!(
                                              inSearch, SearchText);
                                        }
                                      },
                                      child: widget.SearchIcon ??
                                          Icon(Icons.search))
                                  : null,
                              hintText: "بحث",
                              enabledBorder: OutlineInputBorder(),
                              border: OutlineInputBorder(),
                              disabledBorder: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    (widget.OnTheRightWidget != null)
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: widget
                                        .paddingBetweenSearchBarAndRightWidget ??
                                    20))
                        : Container(),
                    (widget.OnTheRightWidget != null)
                        ? widget.OnTheRightWidget!
                        : Container(),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          // Body / Search Page portion:
          Expanded(
            child: Container(
              width: double.infinity,
              child: (inSearch)
                  ? _SearchPage(
                      childHeight: widget.childHeight,
                      childWidth: widget.childWidth,
                      childColor: widget.childColor,
                      childAlignment: widget.childAlignment,
                      childPadding: widget.childPadding,
                      childBackGroundimage: widget.childBackGroundimage,
                      childBorder: widget.childBorder,
                      childBoxShadow: widget.childBoxShadow,
                      childGradient: widget.childGradient,
                      childCircularRadius: widget.childCircularRadius,
                      rowSpaces: widget.rowSpaces,
                      columnSpaces: widget.columnSpaces,
                      itemCount: widget.itemCount,
                      Scroll: widget.Scroll,
                      FilterWidget: widget.FilterWidget,
                      SortWidget: widget.SortWidget,
                      SubAppBarVisible: widget.SubAppBarVisible,
                      onSelected: widget.onSelected,
                      builder: widget.builder,
                    )
                  : widget.body ?? Container(),
            ),
          )
        ],
      ),
    );
  }
}

class _SearchPage extends StatefulWidget {
  _SearchPage({
    super.key,
    required this.childHeight,
    this.childWidth,
    this.childColor,
    this.childAlignment,
    this.childPadding,
    this.childBackGroundimage,
    this.childBorder,
    this.childBoxShadow,
    this.childGradient,
    this.childCircularRadius,
    this.rowSpaces,
    this.columnSpaces,
    required this.itemCount,
    this.Scroll,
    this.FilterWidget,
    this.SortWidget,
    this.SubAppBarVisible,
    required this.builder,
    required this.onSelected,
  });
  final double childHeight;
  final double? childWidth;
  final Color? childColor;
  final AlignmentGeometry? childAlignment;
  final EdgeInsetsGeometry? childPadding;
  final DecorationImage? childBackGroundimage;
  final List<BoxShadow>? childBoxShadow;
  final Gradient? childGradient;
  final BoxBorder? childBorder;
  final double? childCircularRadius;
  final double? rowSpaces;
  final double? columnSpaces;
  final int itemCount;
  final bool? Scroll;
  final Widget? FilterWidget;
  final Widget? SortWidget;
  final bool? SubAppBarVisible;
  final Widget Function(int Index) builder;
  final Function(int SelectedIndex) onSelected;

  @override
  State<_SearchPage> createState() => __SearchPageState();
}

class __SearchPageState extends State<_SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (widget.SubAppBarVisible ?? false)
            Padding(padding: EdgeInsets.only(top: widget.columnSpaces ?? 20)),
          if (widget.SubAppBarVisible ?? false)
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: widget.rowSpaces ?? 20)),
                  if (widget.FilterWidget != null)
                    Container(child: widget.FilterWidget),
                  if (widget.FilterWidget != null)
                  Padding(padding: EdgeInsets.only(left: 20)),
                  if (widget.SortWidget != null)
                    Container(child: widget.SortWidget),
                  Spacer(),
                  Text(
                    "نتائج البحث",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.only(left: 50)),
                ],
              ),
            ),
          Expanded(
            child: Container(
              child: DistributiveGView(
                itemCount: widget.itemCount,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      widget.onSelected(index);
                    },
                    child: widget.builder(index)),
                itemHeight: widget.childHeight,
                itemWidth: widget.childWidth ?? 100,
                mainAxisSpacing: widget.rowSpaces ?? 0,
                crossAxisSpacing: widget.columnSpaces ?? 0,
                surroundpadding: widget.childPadding,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
