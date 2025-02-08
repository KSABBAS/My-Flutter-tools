import 'package:flutter/material.dart';
import 'package:my_tools_development/MyTools/tools/builder_tools/DistributiveGView.dart';

/// نموذج المنتج (Product) للمثال
class Product {
  final int id;
  final String name;
  final double price;
  final DateTime date;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.date,
  });
}

/// خيارات الفرز
enum SortOption { none, priceAsc, priceDesc, newest, oldest }

/// لتحديد اتجاه ظهور الدرج
enum DrawerSide { left, right }

/// لتحديد نوع اللوحة المفتوحة
enum PanelType { none, filter, sort }

/// الـ SearchAppBar هو الـ widget الرئيسي الذي يتحكم بواجهة البحث بالإضافة إلى إعدادات الدرج والفلترة والفرز.
class SearchAppBar extends StatefulWidget {
  SearchAppBar({
    Key? key,
    // إعدادات شبكة عرض المنتجات
    required this.childHeight,
    required this.childWidth,
    this.childAlignment,
    this.childPadding,
    this.childBackGroundimage,
    this.childBorder,
    this.childBoxShadow,
    this.childCircularRadius,
    this.childColor,
    this.childGradient,
    this.rowSpaces,
    this.columnSpaces,
    this.Scroll,
    // إعدادات شريط البحث
    this.appBarHeight,
    this.appBarColor,
    this.body,
    this.onTheSearch,
    this.onValueChange,
    this.SearchIconVisible,
    this.SearchIcon,
    this.OnTheRightWidget,
    this.OnTheLeftWidget,
    this.onSearchTapped,
    this.barLeftPadding,
    this.barRightPadding,
    this.paddingBetweenSearchBarAndRightWidget,
    this.paddingBetweenSearchBarAndLeftWidget,
    // إعدادات الدرج
    this.drawerWidth,
    this.drawerBackgroundColor,
    this.drawerAnimationDuration,
    this.filterDrawerSide = DrawerSide.right,
    this.sortDrawerSide = DrawerSide.right,
    // أيقونات الفلتر والفرز (يمكن تمرير ودجت مخصصة)
    this.FilterWidget,
    this.SortWidget,
    this.SubAppBarVisible,
    // Sort menu customization parameters:
    this.sortMenuWidth,
    this.sortMenuHeight,
    this.sortMenuBackgroundColor,
    this.sortMenuElevation,
    this.sortMenuBorderRadius,
    this.sortMenuPadding,
    this.sortMenuAnimationDuration,
    // **Slider Color Customization Parameters:**
    this.priceSliderActiveColor,
    this.priceSliderInactiveColor,
    this.priceSliderThumbColor,
    this.dateSliderActiveColor,
    this.dateSliderInactiveColor,
    this.dateSliderThumbColor,
    this.alphabetSliderActiveColor,
    this.alphabetSliderInactiveColor,
    this.alphabetSliderThumbColor,
    // New slider callback parameters:
    this.onPriceSliderChanged,
    this.onPriceSliderChangeEnd,
    this.onDateSliderChanged,
    this.onDateSliderChangeEnd,
    this.onAlphabetSliderChanged,
    this.onAlphabetSliderChangeEnd,
    // Callbacks for applying the filter when Apply Filter is pressed.
    required this.onPriceFilterChanged,
    required this.onDateFilterChanged,
    required this.onAlphabetFilterChanged,
    // قائمة المنتجات والـ builder الخاص بكل منتج
    required this.products,
    required this.productBuilder,
  }) : super(key: key);

  // إعدادات شبكة عرض المنتجات
  final double childHeight;
  final double childWidth;
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
  final bool? Scroll;

  // إعدادات شريط البحث
  final double? appBarHeight;
  final Color? appBarColor;
  final Widget? body;
  final Function(bool isOnTheSearch, String searchText)? onTheSearch;
  final Function(String value)? onValueChange;
  final bool? SearchIconVisible;
  final Icon? SearchIcon;
  final Widget? OnTheRightWidget;
  final Widget? OnTheLeftWidget;
  final Function()? onSearchTapped;
  final double? barLeftPadding;
  final double? barRightPadding;
  final double? paddingBetweenSearchBarAndRightWidget;
  final double? paddingBetweenSearchBarAndLeftWidget;

  // إعدادات الدرج
  final double? drawerWidth;
  final Color? drawerBackgroundColor;
  final Duration? drawerAnimationDuration;
  final DrawerSide filterDrawerSide;
  final DrawerSide sortDrawerSide;

  // أيقونات الفلتر والفرز (يمكن تمرير ودجت مخصصة)
  final Widget? FilterWidget;
  final Widget? SortWidget;
  final bool? SubAppBarVisible;

  // Sort menu customization parameters:
  final double? sortMenuWidth;
  final double? sortMenuHeight;
  final Color? sortMenuBackgroundColor; // Use Colors.transparent if needed.
  final double? sortMenuElevation;
  final BorderRadius? sortMenuBorderRadius;
  final EdgeInsetsGeometry? sortMenuPadding;
  final Duration? sortMenuAnimationDuration;

  // **Slider Color Customization Parameters:**
  final Color? priceSliderActiveColor;
  final Color? priceSliderInactiveColor;
  final Color? priceSliderThumbColor;
  final Color? dateSliderActiveColor;
  final Color? dateSliderInactiveColor;
  final Color? dateSliderThumbColor;
  final Color? alphabetSliderActiveColor;
  final Color? alphabetSliderInactiveColor;
  final Color? alphabetSliderThumbColor;

  // New slider callback parameters:
  final Function(RangeValues value)? onPriceSliderChanged;
  final Function(RangeValues value)? onPriceSliderChangeEnd;
  final Function(RangeValues value)? onDateSliderChanged;
  final Function(RangeValues value)? onDateSliderChangeEnd;
  final Function(RangeValues value)? onAlphabetSliderChanged;
  final Function(RangeValues value)? onAlphabetSliderChangeEnd;

  // Callbacks for applying filters when Apply Filter is pressed.
  final Function(RangeValues value) onPriceFilterChanged;
  final Function(RangeValues value) onDateFilterChanged;
  final Function(RangeValues value) onAlphabetFilterChanged;

  // قائمة المنتجات والـ builder الخاص بكل منتج
  final List<Product> products;
  final Widget Function(Product product) productBuilder;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool inSearch = false;
  String searchText = "";
  late List<Product> displayedProducts;
  late double minPrice;
  late double maxPrice;
  late RangeValues selectedPriceRange;
  late DateTime minDate;
  late DateTime maxDate;
  late RangeValues selectedDateRange;
  late int minAlphabet;
  late int maxAlphabet;
  late RangeValues selectedAlphabetRange;
  SortOption selectedSortOption = SortOption.none;

  @override
  void initState() {
    super.initState();
    // Initially display all products.
    displayedProducts = List.from(widget.products);
    if (widget.products.isNotEmpty) {
      minPrice = widget.products.map((p) => p.price).reduce((a, b) => a < b ? a : b);
      maxPrice = widget.products.map((p) => p.price).reduce((a, b) => a > b ? a : b);
    } else {
      minPrice = 0;
      maxPrice = 100;
    }
    selectedPriceRange = RangeValues(minPrice, maxPrice);
    if (widget.products.isNotEmpty) {
      minDate = widget.products.map((p) => p.date).reduce((a, b) => a.isBefore(b) ? a : b);
      maxDate = widget.products.map((p) => p.date).reduce((a, b) => a.isAfter(b) ? a : b);
    } else {
      minDate = DateTime.now();
      maxDate = DateTime.now();
    }
    selectedDateRange = RangeValues(
      minDate.millisecondsSinceEpoch.toDouble(),
      maxDate.millisecondsSinceEpoch.toDouble(),
    );
    if (widget.products.isNotEmpty) {
      minAlphabet = widget.products.map((p) => p.name.toUpperCase().codeUnitAt(0)).reduce((a, b) => a < b ? a : b);
      maxAlphabet = widget.products.map((p) => p.name.toUpperCase().codeUnitAt(0)).reduce((a, b) => a > b ? a : b);
    } else {
      minAlphabet = 65;
      maxAlphabet = 90;
    }
    selectedAlphabetRange = RangeValues(minAlphabet.toDouble(), maxAlphabet.toDouble());
  }

  void updateSort(SortOption newSort) {
    setState(() {
      selectedSortOption = newSort;
      applyFilterSort();
    });
  }

  void applyFilterSort() {
    List<Product> filtered = widget.products.where((product) {
      bool priceOk = product.price >= selectedPriceRange.start &&
          product.price <= selectedPriceRange.end;
      DateTime productDate = product.date;
      bool dateOk = productDate.isAfter(
              DateTime.fromMillisecondsSinceEpoch(selectedDateRange.start.toInt())
                  .subtract(const Duration(milliseconds: 1))) &&
          productDate.isBefore(
              DateTime.fromMillisecondsSinceEpoch(selectedDateRange.end.toInt())
                  .add(const Duration(milliseconds: 1)));
      int firstChar = product.name.toUpperCase().codeUnitAt(0);
      bool alphabetOk = firstChar >= selectedAlphabetRange.start &&
          firstChar <= selectedAlphabetRange.end;
      return priceOk && dateOk && alphabetOk;
    }).toList();

    if (selectedSortOption == SortOption.priceAsc) {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (selectedSortOption == SortOption.priceDesc) {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    } else if (selectedSortOption == SortOption.newest) {
      filtered.sort((a, b) => b.date.compareTo(a.date));
    } else if (selectedSortOption == SortOption.oldest) {
      filtered.sort((a, b) => a.date.compareTo(b.date));
    }
    setState(() {
      displayedProducts = filtered;
    });
  }

  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          // AppBar
          Container(
            padding: EdgeInsets.only(
              left: widget.barLeftPadding ?? 30,
              right: widget.barRightPadding ?? 30,
            ),
            color: widget.appBarColor ?? Colors.blue,
            height: widget.appBarHeight ?? 100,
            width: double.infinity,
            child: Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    if (widget.OnTheLeftWidget != null) widget.OnTheLeftWidget!,
                    if (widget.OnTheLeftWidget != null)
                      SizedBox(width: widget.paddingBetweenSearchBarAndLeftWidget ?? 20),
                    if (inSearch)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            inSearch = false;
                          });
                          if (widget.onTheSearch != null) {
                            widget.onTheSearch!(inSearch, searchText);
                          }
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    if (inSearch) const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          onChanged: (value) {
                            searchText = value;
                            if (widget.onValueChange != null) {
                              widget.onValueChange!(value);
                            }
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              inSearch = true;
                            });
                            if (widget.onTheSearch != null) {
                              widget.onTheSearch!(inSearch, searchText);
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
                                        widget.onTheSearch!(inSearch, searchText);
                                      }
                                    },
                                    child: widget.SearchIcon ?? const Icon(Icons.search),
                                  )
                                : null,
                            hintText: "Search",
                            enabledBorder: const OutlineInputBorder(),
                            border: const OutlineInputBorder(),
                            disabledBorder: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    if (widget.OnTheRightWidget != null)
                      SizedBox(width: widget.paddingBetweenSearchBarAndRightWidget ?? 20),
                    if (widget.OnTheRightWidget != null) widget.OnTheRightWidget!,
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          // Content: Search Results & Filter Drawer
          Expanded(
            child: Container(
              width: double.infinity,
              child: inSearch
                  ? _SearchPage(
                      products: displayedProducts,
                      productBuilder: widget.productBuilder,
                      childHeight: widget.childHeight,
                      childWidth: widget.childWidth,
                      childAlignment: widget.childAlignment,
                      childPadding: widget.childPadding,
                      childBackGroundimage: widget.childBackGroundimage,
                      childBorder: widget.childBorder,
                      childBoxShadow: widget.childBoxShadow,
                      childCircularRadius: widget.childCircularRadius,
                      childColor: widget.childColor,
                      childGradient: widget.childGradient,
                      rowSpaces: widget.rowSpaces,
                      columnSpaces: widget.columnSpaces,
                      drawerWidth: widget.drawerWidth,
                      drawerBackgroundColor: widget.drawerBackgroundColor,
                      drawerAnimationDuration: widget.drawerAnimationDuration,
                      filterDrawerSide: widget.filterDrawerSide,
                      sortDrawerSide: widget.sortDrawerSide,
                      filterWidget: widget.FilterWidget,
                      SortWidget: widget.SortWidget, // Not used for overlay.
                      minPrice: minPrice,
                      maxPrice: maxPrice,
                      selectedPriceRange: selectedPriceRange,
                      onPriceFilterChanged: widget.onPriceFilterChanged,
                      minDate: minDate,
                      maxDate: maxDate,
                      selectedDateRange: selectedDateRange,
                      onDateFilterChanged: widget.onDateFilterChanged,
                      selectedAlphabetRange: selectedAlphabetRange,
                      onAlphabetFilterChanged: widget.onAlphabetFilterChanged,
                      selectedSortOption: selectedSortOption,
                      onSortChanged: updateSort,
                      // Slider color customization:
                      priceSliderActiveColor: widget.priceSliderActiveColor,
                      priceSliderInactiveColor: widget.priceSliderInactiveColor,
                      priceSliderThumbColor: widget.priceSliderThumbColor,
                      dateSliderActiveColor: widget.dateSliderActiveColor,
                      dateSliderInactiveColor: widget.dateSliderInactiveColor,
                      dateSliderThumbColor: widget.dateSliderThumbColor,
                      alphabetSliderActiveColor: widget.alphabetSliderActiveColor,
                      alphabetSliderInactiveColor: widget.alphabetSliderInactiveColor,
                      alphabetSliderThumbColor: widget.alphabetSliderThumbColor,
                      // Sort menu customization:
                      sortMenuWidth: widget.sortMenuWidth,
                      sortMenuHeight: widget.sortMenuHeight,
                      sortMenuBackgroundColor: widget.sortMenuBackgroundColor,
                      sortMenuElevation: widget.sortMenuElevation,
                      sortMenuBorderRadius: widget.sortMenuBorderRadius,
                      sortMenuPadding: widget.sortMenuPadding,
                      sortMenuAnimationDuration: widget.sortMenuAnimationDuration,
                      // New slider callback parameters:
                      onPriceSliderChanged: widget.onPriceSliderChanged,
                      onPriceSliderChangeEnd: widget.onPriceSliderChangeEnd,
                      onDateSliderChanged: widget.onDateSliderChanged,
                      onDateSliderChangeEnd: widget.onDateSliderChangeEnd,
                      onAlphabetSliderChanged: widget.onAlphabetSliderChanged,
                      onAlphabetSliderChangeEnd: widget.onAlphabetSliderChangeEnd,
                    )
                  : widget.body ?? Container(),
            ),
          ),
        ],
      ),
    );
  }
}

/// _SearchPage displays the product grid and manages the filter drawer and sort overlay.
/// It uses temporary state for the filter slider values so that the filters are only applied when "Apply Filter" is pressed.
class _SearchPage extends StatefulWidget {
  _SearchPage({
    Key? key,
    required this.products,
    required this.productBuilder,
    required this.childHeight,
    required this.childWidth,
    this.childAlignment,
    this.childPadding,
    this.childBackGroundimage,
    this.childBorder,
    this.childBoxShadow,
    this.childCircularRadius,
    this.childColor,
    this.childGradient,
    this.rowSpaces,
    this.columnSpaces,
    this.drawerWidth,
    this.drawerBackgroundColor,
    this.drawerAnimationDuration,
    this.filterDrawerSide = DrawerSide.right,
    this.sortDrawerSide = DrawerSide.right,
    this.filterWidget,
    this.SortWidget,
    required this.minPrice,
    required this.maxPrice,
    required this.selectedPriceRange,
    required this.onPriceFilterChanged,
    required this.minDate,
    required this.maxDate,
    required this.selectedDateRange,
    required this.onDateFilterChanged,
    required this.selectedAlphabetRange,
    required this.onAlphabetFilterChanged,
    required this.selectedSortOption,
    required this.onSortChanged,
    // Slider color customization:
    this.priceSliderActiveColor,
    this.priceSliderInactiveColor,
    this.priceSliderThumbColor,
    this.dateSliderActiveColor,
    this.dateSliderInactiveColor,
    this.dateSliderThumbColor,
    this.alphabetSliderActiveColor,
    this.alphabetSliderInactiveColor,
    this.alphabetSliderThumbColor,
    // Sort menu customization:
    this.sortMenuWidth,
    this.sortMenuHeight,
    this.sortMenuBackgroundColor,
    this.sortMenuElevation,
    this.sortMenuBorderRadius,
    this.sortMenuPadding,
    this.sortMenuAnimationDuration,
    // New slider callback parameters:
    this.onPriceSliderChanged,
    this.onPriceSliderChangeEnd,
    this.onDateSliderChanged,
    this.onDateSliderChangeEnd,
    this.onAlphabetSliderChanged,
    this.onAlphabetSliderChangeEnd,
  }) : super(key: key);

  final List<Product> products;
  final Widget Function(Product product) productBuilder;
  final double childHeight;
  final double childWidth;
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
  final double? drawerWidth;
  final Color? drawerBackgroundColor;
  final Duration? drawerAnimationDuration;
  final DrawerSide filterDrawerSide;
  final DrawerSide sortDrawerSide;
  final Widget? filterWidget;
  final Widget? SortWidget;
  final double minPrice;
  final double maxPrice;
  final RangeValues selectedPriceRange;
  final Function(RangeValues newRange) onPriceFilterChanged;
  final DateTime minDate;
  final DateTime maxDate;
  final RangeValues selectedDateRange;
  final Function(RangeValues newRange) onDateFilterChanged;
  final RangeValues selectedAlphabetRange;
  final Function(RangeValues newRange) onAlphabetFilterChanged;
  final SortOption selectedSortOption;
  final Function(SortOption newSort) onSortChanged;
  // Slider color customization:
  final Color? priceSliderActiveColor;
  final Color? priceSliderInactiveColor;
  final Color? priceSliderThumbColor;
  final Color? dateSliderActiveColor;
  final Color? dateSliderInactiveColor;
  final Color? dateSliderThumbColor;
  final Color? alphabetSliderActiveColor;
  final Color? alphabetSliderInactiveColor;
  final Color? alphabetSliderThumbColor;
  // Sort menu customization:
  final double? sortMenuWidth;
  final double? sortMenuHeight;
  final Color? sortMenuBackgroundColor;
  final double? sortMenuElevation;
  final BorderRadius? sortMenuBorderRadius;
  final EdgeInsetsGeometry? sortMenuPadding;
  final Duration? sortMenuAnimationDuration;
  // New slider callback parameters:
  final Function(RangeValues value)? onPriceSliderChanged;
  final Function(RangeValues value)? onPriceSliderChangeEnd;
  final Function(RangeValues value)? onDateSliderChanged;
  final Function(RangeValues value)? onDateSliderChangeEnd;
  final Function(RangeValues value)? onAlphabetSliderChanged;
  final Function(RangeValues value)? onAlphabetSliderChangeEnd;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  PanelType _currentPanel = PanelType.none;
  DrawerSide _currentPanelSide = DrawerSide.right;

  // For sort overlay:
  final GlobalKey _sortButtonKey = GlobalKey();
  OverlayEntry? _sortOverlayEntry;
  bool _isSortOverlayVisible = false;
  late AnimationController _sortMenuController;
  late Animation<Offset> _sortMenuOffsetAnimation;
  SortOption _tempSortOption = SortOption.none;

  // Temporary slider state variables for filters (applied only when "Apply Filter" is pressed)
  late RangeValues _tempPriceRange;
  late RangeValues _tempDateRange;
  late RangeValues _tempAlphabetRange;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.drawerAnimationDuration ?? const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _sortMenuController = AnimationController(
      vsync: this,
      duration: widget.sortMenuAnimationDuration ?? const Duration(milliseconds: 300),
    );
    _sortMenuOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _sortMenuController, curve: Curves.easeInOut));

    _tempSortOption = widget.selectedSortOption;
    // Initialize temporary slider values from the provided current filter values.
    _tempPriceRange = widget.selectedPriceRange;
    _tempDateRange = widget.selectedDateRange;
    _tempAlphabetRange = widget.selectedAlphabetRange;
  }

  void openPanel(PanelType type, DrawerSide side) {
    setState(() {
      _currentPanel = type;
      _currentPanelSide = side;
      _slideAnimation = Tween<Offset>(
        begin: side == DrawerSide.right ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    });
    _animationController.forward();
  }

  void closePanel() {
    _animationController.reverse().then((_) {
      setState(() {
        _currentPanel = PanelType.none;
      });
    });
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  /// Toggles the sort overlay.
  void _toggleSortOverlay() {
    if (_isSortOverlayVisible) {
      _hideSortOverlay();
    } else {
      _showSortOverlay();
    }
  }

  /// Displays the sort overlay just below the sort button.
  void _showSortOverlay() {
    RenderBox renderBox = _sortButtonKey.currentContext!.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Size size = renderBox.size;
    _tempSortOption = widget.selectedSortOption;

    // Compute top position ensuring a 20-pixel margin at the bottom.
    double topPosition = offset.dy + size.height;
    double screenHeight = MediaQuery.of(context).size.height;
    double menuHeight = widget.sortMenuHeight ?? 300;
    if (topPosition + menuHeight > screenHeight) {
      topPosition = screenHeight - menuHeight - 20;
    }

    _sortOverlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          _hideSortOverlay();
        },
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              left: offset.dx,
              top: topPosition,
              width: widget.sortMenuWidth ?? 250,
              child: Material(
                color: Colors.white,
                elevation: widget.sortMenuElevation ?? 4,
                borderRadius: widget.sortMenuBorderRadius ?? BorderRadius.circular(8),
                child: SlideTransition(
                  position: _sortMenuOffsetAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: widget.sortMenuBackgroundColor ?? Colors.white,
                    ),
                    height: widget.sortMenuHeight ?? 300,
                    padding: widget.sortMenuPadding ?? const EdgeInsets.all(16),
                    // The sort overlay now shows only the options.
                    child: ListView(
                      children: [
                        // Each option is applied immediately when tapped.
                        RadioListTile<SortOption>(
                          title: const Text("None"),
                          value: SortOption.none,
                          groupValue: _tempSortOption,
                          onChanged: (value) {
                            setState(() {
                              _tempSortOption = value!;
                            });
                            widget.onSortChanged(_tempSortOption);
                            _hideSortOverlay();
                          },
                        ),
                        RadioListTile<SortOption>(
                          title: const Text("Price: Low to High"),
                          value: SortOption.priceAsc,
                          groupValue: _tempSortOption,
                          onChanged: (value) {
                            setState(() {
                              _tempSortOption = value!;
                            });
                            widget.onSortChanged(_tempSortOption);
                            _hideSortOverlay();
                          },
                        ),
                        RadioListTile<SortOption>(
                          title: const Text("Price: High to Low"),
                          value: SortOption.priceDesc,
                          groupValue: _tempSortOption,
                          onChanged: (value) {
                            setState(() {
                              _tempSortOption = value!;
                            });
                            widget.onSortChanged(_tempSortOption);
                            _hideSortOverlay();
                          },
                        ),
                        RadioListTile<SortOption>(
                          title: const Text("Newest"),
                          value: SortOption.newest,
                          groupValue: _tempSortOption,
                          onChanged: (value) {
                            setState(() {
                              _tempSortOption = value!;
                            });
                            widget.onSortChanged(_tempSortOption);
                            _hideSortOverlay();
                          },
                        ),
                        RadioListTile<SortOption>(
                          title: const Text("Oldest"),
                          value: SortOption.oldest,
                          groupValue: _tempSortOption,
                          onChanged: (value) {
                            setState(() {
                              _tempSortOption = value!;
                            });
                            widget.onSortChanged(_tempSortOption);
                            _hideSortOverlay();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    Overlay.of(context)!.insert(_sortOverlayEntry!);
    _sortMenuController.forward();
    _isSortOverlayVisible = true;
  }

  void _hideSortOverlay() {
    _sortMenuController.reverse().then((_) {
      _sortOverlayEntry?.remove();
      _sortOverlayEntry = null;
      _isSortOverlayVisible = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _sortMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // Sub AppBar with filter and sort buttons.
            if (widget.rowSpaces != null || widget.filterWidget != null || widget.SortWidget != null) ...[
              SizedBox(height: widget.columnSpaces ?? 20),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(width: widget.rowSpaces ?? 20),
                    GestureDetector(
                      onTap: () => openPanel(PanelType.filter, widget.filterDrawerSide),
                      child: widget.filterWidget ?? const Icon(Icons.filter_alt),
                    ),
                    const SizedBox(width: 20),
                    // The sort button is wrapped with a GlobalKey for positioning.
                    GestureDetector(
                      key: _sortButtonKey,
                      onTap: _toggleSortOverlay,
                      child: widget.SortWidget ?? const Icon(Icons.sort),
                    ),
                    const Spacer(),
                    const Text(
                      "Search Results",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
            ],
            // Product grid view.
            Expanded(
              child: DistributiveGView(
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: widget.childWidth,
                      height: widget.childHeight,
                      alignment: widget.childAlignment,
                      padding: widget.childPadding,
                      decoration: BoxDecoration(
                        color: widget.childColor,
                        gradient: widget.childGradient,
                        border: widget.childBorder,
                        borderRadius: BorderRadius.circular(widget.childCircularRadius ?? 0),
                        image: widget.childBackGroundimage,
                        boxShadow: widget.childBoxShadow,
                      ),
                      child: widget.productBuilder(product),
                    ),
                  );
                },
                itemHeight: widget.childHeight,
                itemWidth: widget.childWidth,
                mainAxisSpacing: widget.rowSpaces ?? 0,
                crossAxisSpacing: widget.columnSpaces ?? 0,
                surroundpadding: EdgeInsets.symmetric(
                  horizontal: widget.rowSpaces ?? 0,
                  vertical: widget.columnSpaces ?? 0,
                ),
              ),
            ),
          ],
        ),
        // Filter Drawer Overlay.
        if (_currentPanel != PanelType.none) ...[
          Positioned.fill(
            child: GestureDetector(
              onTap: closePanel,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          _buildDrawerPanel(context),
        ],
      ],
    );
  }

  /// Builds the filter drawer. The slider values are stored in temporary variables and are applied only when "Apply Filter" is pressed.
  Widget _buildDrawerPanel(BuildContext context) {
    double calculatedDrawerWidth = widget.drawerWidth ??
        MediaQuery.of(context).size.width * 0.8;
    Widget content;
    if (_currentPanel == PanelType.filter) {
      content = SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Price Filter Container.
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Price Range", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.minPrice.toStringAsFixed(2)),
                        Text(widget.maxPrice.toStringAsFixed(2)),
                      ],
                    ),
                    // SliderTheme for Price Range Slider using temporary state.
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: widget.priceSliderActiveColor ?? Colors.blue,
                        inactiveTrackColor: widget.priceSliderInactiveColor ?? Colors.grey,
                        thumbColor: widget.priceSliderThumbColor ?? Colors.blue,
                      ),
                      child: RangeSlider(
                        min: widget.minPrice,
                        max: widget.maxPrice,
                        values: _tempPriceRange,
                        onChanged: (value) {
                          setState(() {
                            _tempPriceRange = value;
                          });
                          if (widget.onPriceSliderChanged != null) {
                            widget.onPriceSliderChanged!(value);
                          }
                        },
                        onChangeEnd: (value) {
                          if (widget.onPriceSliderChangeEnd != null) {
                            widget.onPriceSliderChangeEnd!(value);
                          }
                        },
                        labels: RangeLabels(
                          _tempPriceRange.start.toStringAsFixed(2),
                          _tempPriceRange.end.toStringAsFixed(2),
                        ),
                        divisions: 100,
                      ),
                    ),
                    Text("Selected: ${_tempPriceRange.start.toStringAsFixed(2)} - ${_tempPriceRange.end.toStringAsFixed(2)}"),
                  ],
                ),
              ),
              // Date Filter Container.
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Date Range", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDate(widget.minDate)),
                        Text(_formatDate(widget.maxDate)),
                      ],
                    ),
                    // SliderTheme for Date Range Slider using temporary state.
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: widget.dateSliderActiveColor ?? Colors.green,
                        inactiveTrackColor: widget.dateSliderInactiveColor ?? Colors.grey,
                        thumbColor: widget.dateSliderThumbColor ?? Colors.green,
                      ),
                      child: RangeSlider(
                        min: widget.minDate.millisecondsSinceEpoch.toDouble(),
                        max: widget.maxDate.millisecondsSinceEpoch.toDouble(),
                        values: _tempDateRange,
                        onChanged: (value) {
                          setState(() {
                            _tempDateRange = value;
                          });
                          if (widget.onDateSliderChanged != null) {
                            widget.onDateSliderChanged!(value);
                          }
                        },
                        onChangeEnd: (value) {
                          if (widget.onDateSliderChangeEnd != null) {
                            widget.onDateSliderChangeEnd!(value);
                          }
                        },
                        labels: RangeLabels(
                          _formatDate(DateTime.fromMillisecondsSinceEpoch(_tempDateRange.start.toInt())),
                          _formatDate(DateTime.fromMillisecondsSinceEpoch(_tempDateRange.end.toInt())),
                        ),
                        divisions: 10,
                      ),
                    ),
                    Text("Selected: ${_formatDate(DateTime.fromMillisecondsSinceEpoch(_tempDateRange.start.toInt()))} - ${_formatDate(DateTime.fromMillisecondsSinceEpoch(_tempDateRange.end.toInt()))}"),
                  ],
                ),
              ),
              // Name Initial Filter Container.
              Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name Initial Range", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(String.fromCharCode(_tempAlphabetRange.start.toInt())),
                        Text(String.fromCharCode(_tempAlphabetRange.end.toInt())),
                      ],
                    ),
                    // SliderTheme for Name Initial Range Slider using temporary state.
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: widget.alphabetSliderActiveColor ?? Colors.red,
                        inactiveTrackColor: widget.alphabetSliderInactiveColor ?? Colors.grey,
                        thumbColor: widget.alphabetSliderThumbColor ?? Colors.red,
                      ),
                      child: RangeSlider(
                        min: 65,
                        max: 90,
                        values: _tempAlphabetRange,
                        onChanged: (value) {
                          setState(() {
                            _tempAlphabetRange = value;
                          });
                          if (widget.onAlphabetSliderChanged != null) {
                            widget.onAlphabetSliderChanged!(value);
                          }
                        },
                        onChangeEnd: (value) {
                          if (widget.onAlphabetSliderChangeEnd != null) {
                            widget.onAlphabetSliderChangeEnd!(value);
                          }
                        },
                        labels: RangeLabels(
                          String.fromCharCode(_tempAlphabetRange.start.toInt()),
                          String.fromCharCode(_tempAlphabetRange.end.toInt()),
                        ),
                        divisions: 25,
                      ),
                    ),
                    Text("Selected: ${String.fromCharCode(_tempAlphabetRange.start.toInt())} - ${String.fromCharCode(_tempAlphabetRange.end.toInt())}"),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Apply the filters only when this button is pressed.
                    widget.onPriceFilterChanged(_tempPriceRange);
                    widget.onDateFilterChanged(_tempDateRange);
                    widget.onAlphabetFilterChanged(_tempAlphabetRange);
                    closePanel();
                  },
                  child: const Text("Apply Filter"),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      content = const SizedBox.shrink();
    }
    return Align(
      alignment: _currentPanelSide == DrawerSide.right
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          width: calculatedDrawerWidth,
          height: MediaQuery.of(context).size.height,
          color: widget.drawerBackgroundColor ?? Colors.white,
          child: SafeArea(child: content),
        ),
      ),
    );
  }
}
