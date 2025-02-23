import 'dart:math';
import 'package:flutter/material.dart';

class MyFloatingMenuButton extends StatelessWidget {
  final Widget body;
  final DraggableFloatingMenu floatingWidget;

  const MyFloatingMenuButton({
    Key? key,
    required this.body,
    required this.floatingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          body,
          // Floating menu is placed on top of the body.
          floatingWidget,
        ],
      ),
    );
  }
}

/// Enum for eight popup directions.
enum PopupDirection {
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// Helper: compute the offset for the popup relative to the FAB’s top-left corner.
Offset getMenuOffset(
  PopupDirection direction,
  double fabSize,
  double horizontalMargin,
  double verticalMargin,
  double menuWidth,
  double menuHeight,
) {
  switch (direction) {
    case PopupDirection.top:
      return Offset((fabSize - menuWidth) / 2, -menuHeight - verticalMargin);
    case PopupDirection.bottom:
      return Offset((fabSize - menuWidth) / 2, fabSize + verticalMargin);
    case PopupDirection.left:
      return Offset(-menuWidth - horizontalMargin, (fabSize - menuHeight) / 2);
    case PopupDirection.right:
      return Offset(fabSize + horizontalMargin, (fabSize - menuHeight) / 2);
    case PopupDirection.topLeft:
      return Offset(-menuWidth - horizontalMargin, -menuHeight - verticalMargin);
    case PopupDirection.topRight:
      return Offset(fabSize + horizontalMargin, -menuHeight - verticalMargin);
    case PopupDirection.bottomLeft:
      return Offset(-menuWidth - horizontalMargin, fabSize + verticalMargin);
    case PopupDirection.bottomRight:
      return Offset(fabSize + horizontalMargin, fabSize + verticalMargin);
  }
}

/// A draggable floating menu widget that leaves the FAB unchanged but dynamically
/// positions the popup menu in one of eight directions. The popup’s fade animation
/// is calculated based on its opacity. Items are built via an itemBuilder callback.
/// Tapping a menu item calls [onItemTap] with the index of the pressed item.
class DraggableFloatingMenu extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Offset initialPosition;
  final Duration animationDuration;
  final Curve animationCurve;
  // FAB customization.
  final Color fabColor;
  final double fabSize;
  final Icon fabIcon;
  // Popup Menu customization.
  final double menuWidth;
  final double menuItemHeight;
  final Color? menuBackgroundColor;
  final BoxDecoration? menuDecoration;
  // Global menu item style parameters.
  final double? menuItemWidth;
  final EdgeInsets? menuItemPadding;
  final EdgeInsets? menuItemMargin;
  final AlignmentGeometry? menuItemAlignment;
  final double? menuItemSpacing;
  final BoxDecoration? menuItemDecoration;
  /// Callback when a menu item is tapped. Returns the index of the pressed item.
  final ValueChanged<int>? onItemTap;

  const DraggableFloatingMenu({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.onItemTap,
    this.initialPosition = const Offset(20, 100),
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.easeOut,
    this.fabColor = Colors.blue,
    this.fabSize = 56.0,
    this.fabIcon = const Icon(Icons.menu, color: Colors.white),
    this.menuWidth = 220.0,
    required this.menuItemHeight,
    this.menuBackgroundColor = Colors.white,
    this.menuDecoration,
    this.menuItemWidth,
    this.menuItemPadding,
    this.menuItemMargin,
    this.menuItemAlignment,
    this.menuItemSpacing,
    this.menuItemDecoration,
  }) : super(key: key);

  @override
  _DraggableFloatingMenuState createState() => _DraggableFloatingMenuState();
}

class _DraggableFloatingMenuState extends State<DraggableFloatingMenu>
    with SingleTickerProviderStateMixin {
  late Offset position;
  late AnimationController _menuController;
  late Animation<double> _menuFadeAnimation;
  bool isMenuOpen = false;
  // For dragging.
  Offset? dragStart;
  Offset? dragStartPosition;

  @override
  void initState() {
    super.initState();
    position = widget.initialPosition;
    _menuController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _menuFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _menuController, curve: widget.animationCurve),
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
      if (isMenuOpen) {
        _menuController.forward();
      } else {
        _menuController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fabSize = widget.fabSize;
    final screenSize = MediaQuery.of(context).size;
    const threshold = 100.0;
    const fixedMargin = 8.0;

    // Compute distances from the FAB to the screen edges.
    final dTop = position.dy;
    final dBottom = screenSize.height - (position.dy + fabSize);
    final dLeft = position.dx;
    final dRight = screenSize.width - (position.dx + fabSize);

    // Determine the popup direction based on the FAB position.
    PopupDirection popupDirection;
    if (dRight <= threshold && dBottom <= threshold) {
      popupDirection = PopupDirection.topLeft;
    } else if (dLeft <= threshold && dBottom <= threshold) {
      popupDirection = PopupDirection.topRight;
    } else if (dLeft <= threshold && dTop <= threshold) {
      popupDirection = PopupDirection.bottomRight;
    } else if (dRight <= threshold && dTop <= threshold) {
      popupDirection = PopupDirection.bottomLeft;
    } else if (dRight <= threshold) {
      popupDirection = PopupDirection.left;
    } else if (dLeft <= threshold) {
      popupDirection = PopupDirection.right;
    } else if (dBottom <= threshold) {
      popupDirection = PopupDirection.top;
    } else if (dTop <= threshold) {
      popupDirection = PopupDirection.bottom;
    } else {
      popupDirection = PopupDirection.bottom;
    }

    // Compute the popup menu height based on item count, item height, and spacing.
    final spacing = widget.menuItemSpacing ?? 0.0;
    final computedMenuHeight = (widget.itemCount * widget.menuItemHeight) +
        ((widget.itemCount - 1) * spacing);
    final menuWidth = widget.menuWidth;

    final menuPositionOffset = getMenuOffset(
      popupDirection,
      fabSize,
      fixedMargin,
      fixedMargin,
      menuWidth,
      computedMenuHeight,
    );

    // Build menu items with their own GestureDetector for tap handling.
    Widget buildMenuItems() {
      List<Widget> items = List.generate(widget.itemCount, (i) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (widget.onItemTap != null) {
              widget.onItemTap!(i);
            }
          },
          child: widget.itemBuilder(context, i),
        );
      });
      if (spacing > 0 && items.length > 1) {
        List<Widget> spaced = [];
        for (int i = 0; i < items.length; i++) {
          spaced.add(items[i]);
          if (i < items.length - 1) {
            spaced.add(SizedBox(height: spacing));
          }
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: spaced,
        );
      }
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      );
    }

    // The revised structure: a top-level Stack with separate Positioned widgets for the FAB and popup menu.
    return Stack(
      clipBehavior: Clip.none, // Allows overflow so that menu items outside FAB bounds receive taps. :contentReference[oaicite:0]{index=0}
      children: [
        // Draggable FAB.
        Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onPanStart: (details) {
              dragStart = details.globalPosition;
              dragStartPosition = position;
            },
            onPanUpdate: (details) {
              final delta = details.globalPosition - dragStart!;
              final newPos = dragStartPosition! + delta;
              final clampedX = newPos.dx.clamp(0.0, screenSize.width - fabSize);
              final clampedY = newPos.dy.clamp(0.0, screenSize.height - fabSize);
              setState(() {
                position = Offset(clampedX, clampedY);
              });
            },
            onTap: toggleMenu,
            child: Container(
              width: fabSize,
              height: fabSize,
              decoration: BoxDecoration(
                color: widget.fabColor,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Center(child: widget.fabIcon),
            ),
          ),
        ),
        // Popup menu.
        if (isMenuOpen)
          Positioned(
            left: position.dx + menuPositionOffset.dx,
            top: position.dy + menuPositionOffset.dy,
            child: AnimatedBuilder(
              animation: _menuController,
              builder: (context, child) {
                return Opacity(
                  opacity: _menuFadeAnimation.value,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: menuWidth,
                      height: computedMenuHeight,
                      decoration: widget.menuDecoration ??
                          BoxDecoration(
                            color: widget.menuBackgroundColor ?? Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: (widget.menuBackgroundColor == Colors.transparent)
                                ? []
                                : const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                          ),
                      child: buildMenuItems(),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
