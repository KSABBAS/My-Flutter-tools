import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Controls the overall layout orientation.
enum DateDisplayOrientation { horizontal, vertical }

/// When displaying horizontally (each item is a Column),
/// controls whether the day name appears on top or the day number does.
enum HorizontalDateOrder { dayNameOnTop, dayNumberOnTop }

/// When displaying vertically (each item is a Row),
/// controls whether the day name appears on the left or the day number does.
enum VerticalDateOrder { dayNameOnLeft, dayNumberOnLeft }

class MyAutoDateDisplayer extends StatefulWidget {
  /// How many days before today to display. Defaults to 3.
  final int daysBefore;

  /// How many days after today to display. Defaults to 10.
  final int daysAfter;

  /// Overall orientation: horizontal (items scroll horizontally) or vertical (items scroll vertically).
  final DateDisplayOrientation orientation;

  /// When horizontal, order of texts.
  final HorizontalDateOrder horizontalOrder;

  /// When vertical, order of texts.
  final VerticalDateOrder verticalOrder;

  /// Decoration for the container that holds the list view.
  final BoxDecoration containerDecoration;

  /// Padding for the container that holds the list view.
  final EdgeInsets containerPadding;

  /// Margin for the container that holds the list view.
  final EdgeInsets containerMargin;

  /// Optional: The width of the container that holds the entire widget.
  final double? containerWidth;

  /// Optional: The height of the container that holds the entire widget.
  final double? containerHeight;

  /// Decoration for each date item container.
  final BoxDecoration itemDecoration;

  /// Padding for each date item.
  final EdgeInsets itemPadding;

  /// Optionally, you can set a fixed width for each date item.
  final double? itemWidth;

  /// Optionally, you can set a fixed height for each date item.
  final double? itemHeight;

  /// Spacing between adjacent date items.
  final double itemSpacing;

  /// Text style for the day name.
  final TextStyle dayNameTextStyle;

  /// Text style for the day number.
  final TextStyle dayNumberTextStyle;

  /// Whether to show the day name.
  final bool showDayName;

  /// Whether to show the day number.
  final bool showDayNumber;

  /// Highlight color for the current day.
  final Color currentDayHighlightColor;

  /// Callback when a date is tapped; returns the selected date.
  final ValueChanged<DateTime> onDateSelected;

  /// Callback called on initialization (or when today changes) to indicate what today is.
  final ValueChanged<DateTime>? onTodayChanged;

  /// When horizontal, controls the inner Column's main axis alignment.
  final MainAxisAlignment horizontalItemMainAxisAlignment;

  /// When horizontal, controls the inner Column's cross axis alignment.
  final CrossAxisAlignment horizontalItemCrossAxisAlignment;

  /// When vertical, controls the inner Row's main axis alignment.
  final MainAxisAlignment verticalItemMainAxisAlignment;

  /// When vertical, controls the inner Row's cross axis alignment.
  final CrossAxisAlignment verticalItemCrossAxisAlignment;

  /// Whether to show the selector border around the selected date.
  final bool showSelector;

  /// Selector border width.
  final double selectorBorderWidth;

  /// Selector border color.
  final Color selectorBorderColor;

  /// Selector border radius.
  final BorderRadius? selectorBorderRadius;

  /// Callback that returns the index of the selected date.
  final ValueChanged<int>? onSelectedIndexChanged;

  const MyAutoDateDisplayer({
    Key? key,
    this.daysBefore = 3,
    this.daysAfter = 10,
    this.orientation = DateDisplayOrientation.horizontal,
    this.horizontalOrder = HorizontalDateOrder.dayNameOnTop,
    this.verticalOrder = VerticalDateOrder.dayNameOnLeft,
    this.containerDecoration = const BoxDecoration(color: Colors.transparent),
    this.containerPadding = const EdgeInsets.all(8.0),
    this.containerMargin = const EdgeInsets.all(0),
    this.containerWidth,
    this.containerHeight,
    this.itemDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
    ),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    this.itemWidth,
    this.itemHeight,
    this.itemSpacing = 8.0,
    this.dayNameTextStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.dayNumberTextStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    this.showDayName = true,
    this.showDayNumber = true,
    this.currentDayHighlightColor = Colors.blue,
    required this.onDateSelected,
    this.onTodayChanged,
    this.horizontalItemMainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.horizontalItemCrossAxisAlignment = CrossAxisAlignment.center,
    this.verticalItemMainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.verticalItemCrossAxisAlignment = CrossAxisAlignment.center,
    this.showSelector = false, // New parameter to control selector visibility.
    this.selectorBorderWidth = 3.0,
    this.selectorBorderColor = Colors.green,
    this.selectorBorderRadius,
    this.onSelectedIndexChanged,
  }) : super(key: key);

  @override
  _MyAutoDateDisplayerState createState() => _MyAutoDateDisplayerState();
}

class _MyAutoDateDisplayerState extends State<MyAutoDateDisplayer> {
  late DateTime today;
  late List<DateTime> dates;
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    // Normalize today to remove time portion.
    today = DateTime(today.year, today.month, today.day);
    // Generate dates: from (today - daysBefore) to (today + daysAfter)
    dates = List.generate(
      widget.daysBefore + widget.daysAfter + 1,
      (index) => today.add(Duration(days: index - widget.daysBefore)),
    );
    // Auto-select today's date.
    selectedIndex = dates.indexWhere((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day);
    if (selectedIndex < 0) selectedIndex = 0;
    // Report today's date via callback.
    widget.onTodayChanged?.call(today);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      height: widget.containerHeight,
      decoration: widget.containerDecoration,
      padding: widget.containerPadding,
      margin: widget.containerMargin,
      child: ListView.builder(
        scrollDirection: widget.orientation == DateDisplayOrientation.horizontal
            ? Axis.horizontal
            : Axis.vertical,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final DateTime date = dates[index];
          final String dayName = DateFormat('EEE').format(date); // e.g., Mon, Tue, etc.
          final String dayNumber = date.day.toString();
          final bool isToday = date.year == today.year && date.month == today.month && date.day == today.day;
          final bool isSelected = index == selectedIndex;

          // Build inner content depending on orientation.
          Widget content;
          if (widget.orientation == DateDisplayOrientation.horizontal) {
            List<Widget> columnChildren = [];
            if (widget.showDayName && widget.horizontalOrder == HorizontalDateOrder.dayNameOnTop) {
              columnChildren.add(Text(dayName, style: widget.dayNameTextStyle));
            }
            if (widget.showDayName && widget.showDayNumber && widget.horizontalOrder == HorizontalDateOrder.dayNameOnTop) {
              columnChildren.add(const SizedBox(height: 4));
            }
            if (widget.showDayNumber) {
              columnChildren.add(Text(dayNumber, style: widget.dayNumberTextStyle));
            }
            if (widget.horizontalOrder == HorizontalDateOrder.dayNumberOnTop) {
              columnChildren = [];
              if (widget.showDayNumber) columnChildren.add(Text(dayNumber, style: widget.dayNumberTextStyle));
              if (widget.showDayNumber && widget.showDayName) columnChildren.add(const SizedBox(height: 4));
              if (widget.showDayName) columnChildren.add(Text(dayName, style: widget.dayNameTextStyle));
            }
            content = Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: widget.horizontalItemMainAxisAlignment,
              crossAxisAlignment: widget.horizontalItemCrossAxisAlignment,
              children: columnChildren,
            );
          } else {
            List<Widget> rowChildren = [];
            if (widget.verticalOrder == VerticalDateOrder.dayNameOnLeft) {
              if (widget.showDayName) rowChildren.add(Text(dayName, style: widget.dayNameTextStyle));
              if (widget.showDayName && widget.showDayNumber) rowChildren.add(const SizedBox(width: 4));
              if (widget.showDayNumber) rowChildren.add(Text(dayNumber, style: widget.dayNumberTextStyle));
            } else {
              rowChildren = [];
              if (widget.showDayNumber) rowChildren.add(Text(dayNumber, style: widget.dayNumberTextStyle));
              if (widget.showDayNumber && widget.showDayName) rowChildren.add(const SizedBox(width: 4));
              if (widget.showDayName) rowChildren.add(Text(dayName, style: widget.dayNameTextStyle));
            }
            content = Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: widget.verticalItemMainAxisAlignment,
              crossAxisAlignment: widget.verticalItemCrossAxisAlignment,
              children: rowChildren,
            );
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onDateSelected(date);
              widget.onSelectedIndexChanged?.call(index);
            },
            child: Container(
              width: widget.itemWidth,
              height: widget.itemHeight,
              margin: widget.orientation == DateDisplayOrientation.horizontal
                  ? EdgeInsets.symmetric(horizontal: widget.itemSpacing / 2)
                  : EdgeInsets.symmetric(vertical: widget.itemSpacing / 2),
              padding: widget.itemPadding,
              decoration: widget.itemDecoration.copyWith(
                color: isToday ? widget.currentDayHighlightColor : widget.itemDecoration.color,
                // Add selector border if this item is selected and `showSelector` is true.
                border: (widget.showSelector && isSelected)
                    ? Border.all(color: widget.selectorBorderColor, width: widget.selectorBorderWidth)
                    : widget.itemDecoration.border,
                borderRadius:(widget.showSelector)? widget.selectorBorderRadius : widget.itemDecoration.borderRadius,
              ),
              child: content,
            ),
          );
        },
      ),
    );
  }
}