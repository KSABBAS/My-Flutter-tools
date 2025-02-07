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
    super.key,
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
    // قائمة المنتجات والـ builder الخاص بكل منتج
    required this.products,
    required this.productBuilder,
  });

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

  // قائمة المنتجات والـ builder الخاص بكل منتج
  final List<Product> products;
  final Widget Function(Product product) productBuilder;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool inSearch = false;
  String searchText = "";

  // حالة الفلترة والفرز
  late List<Product> displayedProducts;

  // فلتر السعر
  late double minPrice;
  late double maxPrice;
  late RangeValues selectedPriceRange;

  // فلتر التاريخ (قيمه كميّاً هي ميلي ثانية منذ Epoch)
  late DateTime minDate;
  late DateTime maxDate;
  late RangeValues selectedDateRange;

  // فلتر أول حرف من الاسم (قيم ASCII: من 65 = 'A' إلى 90 = 'Z')
  late int minAlphabet;
  late int maxAlphabet;
  late RangeValues selectedAlphabetRange;

  SortOption selectedSortOption = SortOption.none;

  @override
  void initState() {
    super.initState();
    // البداية، نعرض جميع المنتجات
    displayedProducts = List.from(widget.products);

    // حساب نطاق السعر
    if (widget.products.isNotEmpty) {
      minPrice = widget.products.map((p) => p.price).reduce((a, b) => a < b ? a : b);
      maxPrice = widget.products.map((p) => p.price).reduce((a, b) => a > b ? a : b);
    } else {
      minPrice = 0;
      maxPrice = 100;
    }
    selectedPriceRange = RangeValues(minPrice, maxPrice);

    // حساب نطاق التواريخ
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

    // حساب نطاق الحروف الأولى للاسماء
    if (widget.products.isNotEmpty) {
      minAlphabet = widget.products
          .map((p) => p.name.toUpperCase().codeUnitAt(0))
          .reduce((a, b) => a < b ? a : b);
      maxAlphabet = widget.products
          .map((p) => p.name.toUpperCase().codeUnitAt(0))
          .reduce((a, b) => a > b ? a : b);
    } else {
      minAlphabet = 65; // 'A'
      maxAlphabet = 90; // 'Z'
    }
    selectedAlphabetRange = RangeValues(minAlphabet.toDouble(), maxAlphabet.toDouble());
  }

  /// عند تغيير فلتر السعر
  void updatePriceFilter(RangeValues newRange) {
    setState(() {
      selectedPriceRange = newRange;
      applyFilterSort();
    });
  }

  /// عند تغيير فلتر التاريخ
  void updateDateFilter(RangeValues newRange) {
    setState(() {
      selectedDateRange = newRange;
      applyFilterSort();
    });
  }

  /// عند تغيير فلتر الحروف
  void updateAlphabetFilter(RangeValues newRange) {
    setState(() {
      selectedAlphabetRange = newRange;
      applyFilterSort();
    });
  }

  /// عند تغيير خيار الفرز
  void updateSort(SortOption newSort) {
    setState(() {
      selectedSortOption = newSort;
      applyFilterSort();
    });
  }

  /// تطبيق جميع معايير الفلترة والفرز على القائمة الأصلية
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

  /// تنسيق التاريخ (مثلاً: 2023-02-07)
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
          // شريط التطبيق (AppBar)
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
          // عرض النتائج مع إمكانية فتح درج الفلترة والفرز
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
                      // إعدادات الدرج
                      drawerWidth: widget.drawerWidth,
                      drawerBackgroundColor: widget.drawerBackgroundColor,
                      drawerAnimationDuration: widget.drawerAnimationDuration,
                      filterDrawerSide: widget.filterDrawerSide,
                      sortDrawerSide: widget.sortDrawerSide,
                      // تمرير ودجت الفلتر والفرز المُخصصة (إن وُجدت)
                      filterWidget: widget.FilterWidget,
                      sortWidget: widget.SortWidget,
                      // معايير فلتر السعر
                      minPrice: minPrice,
                      maxPrice: maxPrice,
                      selectedPriceRange: selectedPriceRange,
                      onPriceFilterChanged: updatePriceFilter,
                      // معايير فلتر التاريخ
                      minDate: minDate,
                      maxDate: maxDate,
                      selectedDateRange: selectedDateRange,
                      onDateFilterChanged: updateDateFilter,
                      // معايير فلتر أول حرف للاسماء
                      selectedAlphabetRange: selectedAlphabetRange,
                      onAlphabetFilterChanged: updateAlphabetFilter,
                      // معايير الفرز
                      selectedSortOption: selectedSortOption,
                      onSortChanged: updateSort,
                    )
                  : widget.body ?? Container(),
            ),
          ),
        ],
      ),
    );
  }
}

/// _SearchPage مسؤولة عن عرض شبكة المنتجات مع درج الفلترة والفرز.
class _SearchPage extends StatefulWidget {
  _SearchPage({
    super.key,
    // لعرض المنتجات
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
    // إعدادات الدرج
    this.drawerWidth,
    this.drawerBackgroundColor,
    this.drawerAnimationDuration,
    this.filterDrawerSide = DrawerSide.right,
    this.sortDrawerSide = DrawerSide.right,
    // ودجت مخصصة للفلتر والفرز (إن تم تمريرها)
    this.filterWidget,
    this.sortWidget,
    // معايير فلتر السعر
    required this.minPrice,
    required this.maxPrice,
    required this.selectedPriceRange,
    required this.onPriceFilterChanged,
    // معايير فلتر التاريخ
    required this.minDate,
    required this.maxDate,
    required this.selectedDateRange,
    required this.onDateFilterChanged,
    // معايير فلتر أول حرف للاسماء
    required this.selectedAlphabetRange,
    required this.onAlphabetFilterChanged,
    // معايير الفرز
    required this.selectedSortOption,
    required this.onSortChanged,
  });

  // معايير عرض الشبكة
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

  // إعدادات الدرج
  final double? drawerWidth;
  final Color? drawerBackgroundColor;
  final Duration? drawerAnimationDuration;
  final DrawerSide filterDrawerSide;
  final DrawerSide sortDrawerSide;

  // ودجت مخصصة للفلتر والفرز
  final Widget? filterWidget;
  final Widget? sortWidget;

  // معايير فلتر السعر
  final double minPrice;
  final double maxPrice;
  final RangeValues selectedPriceRange;
  final Function(RangeValues newRange) onPriceFilterChanged;

  // معايير فلتر التاريخ
  final DateTime minDate;
  final DateTime maxDate;
  final RangeValues selectedDateRange;
  final Function(RangeValues newRange) onDateFilterChanged;

  // معايير فلتر أول حرف للاسماء
  final RangeValues selectedAlphabetRange;
  final Function(RangeValues newRange) onAlphabetFilterChanged;

  // معايير الفرز
  final SortOption selectedSortOption;
  final Function(SortOption newSort) onSortChanged;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  PanelType _currentPanel = PanelType.none;
  DrawerSide _currentPanelSide = DrawerSide.right;

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
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  /// فتح اللوحة (فلتر أو فرز) من الاتجاه المحدد
  void openPanel(PanelType type, DrawerSide side) {
    setState(() {
      _currentPanel = type;
      _currentPanelSide = side;
      _slideAnimation = Tween<Offset>(
        begin: side == DrawerSide.right ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
    });
    _animationController.forward();
  }

  /// إغلاق اللوحة
  void closePanel() {
    _animationController.reverse().then((_) {
      setState(() {
        _currentPanel = PanelType.none;
      });
    });
  }

  /// دالة مساعدة لتنسيق التاريخ
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  /// بناء محتوى الدرج (فلترة أو فرز)
  Widget _buildDrawerPanel(BuildContext context) {
    double calculatedDrawerWidth = widget.drawerWidth ??
        MediaQuery.of(context).size.width * 0.8;
    Widget content;
    if (_currentPanel == PanelType.filter) {
      content = SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // قسم فلتر السعر
              const Text("Price Range", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.minPrice.toStringAsFixed(2)),
                  Text(widget.maxPrice.toStringAsFixed(2)),
                ],
              ),
              RangeSlider(
                min: widget.minPrice,
                max: widget.maxPrice,
                values: widget.selectedPriceRange,
                onChanged: widget.onPriceFilterChanged,
                labels: RangeLabels(
                  widget.selectedPriceRange.start.toStringAsFixed(2),
                  widget.selectedPriceRange.end.toStringAsFixed(2),
                ),
                divisions: 100,
              ),
              Text("Selected: ${widget.selectedPriceRange.start.toStringAsFixed(2)} - ${widget.selectedPriceRange.end.toStringAsFixed(2)}"),
              const SizedBox(height: 16),
              // قسم فلتر التاريخ
              const Text("Date Range", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDate(widget.minDate)),
                  Text(_formatDate(widget.maxDate)),
                ],
              ),
              RangeSlider(
                min: widget.minDate.millisecondsSinceEpoch.toDouble(),
                max: widget.maxDate.millisecondsSinceEpoch.toDouble(),
                values: widget.selectedDateRange,
                onChanged: widget.onDateFilterChanged,
                labels: RangeLabels(
                  _formatDate(DateTime.fromMillisecondsSinceEpoch(widget.selectedDateRange.start.toInt())),
                  _formatDate(DateTime.fromMillisecondsSinceEpoch(widget.selectedDateRange.end.toInt())),
                ),
                divisions: 10,
              ),
              Text("Selected: ${_formatDate(DateTime.fromMillisecondsSinceEpoch(widget.selectedDateRange.start.toInt()))} - ${_formatDate(DateTime.fromMillisecondsSinceEpoch(widget.selectedDateRange.end.toInt()))}"),
              const SizedBox(height: 16),
              // قسم فلتر أول حرف للاسماء
              const Text("Name Initial Range", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(String.fromCharCode(widget.selectedAlphabetRange.start.toInt())),
                  Text(String.fromCharCode(widget.selectedAlphabetRange.end.toInt())),
                ],
              ),
              RangeSlider(
                min: 65,
                max: 90,
                values: widget.selectedAlphabetRange,
                onChanged: widget.onAlphabetFilterChanged,
                labels: RangeLabels(
                  String.fromCharCode(widget.selectedAlphabetRange.start.toInt()),
                  String.fromCharCode(widget.selectedAlphabetRange.end.toInt()),
                ),
                divisions: 25,
              ),
              Text("Selected: ${String.fromCharCode(widget.selectedAlphabetRange.start.toInt())} - ${String.fromCharCode(widget.selectedAlphabetRange.end.toInt())}"),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: closePanel,
                  child: const Text("Apply Filter"),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (_currentPanel == PanelType.sort) {
      content = Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sort Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            DropdownButton<SortOption>(
              value: widget.selectedSortOption,
              onChanged: (SortOption? newOption) {
                if (newOption != null) {
                  widget.onSortChanged(newOption);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: SortOption.none,
                  child: Text("None"),
                ),
                DropdownMenuItem(
                  value: SortOption.priceAsc,
                  child: Text("Price: Low to High"),
                ),
                DropdownMenuItem(
                  value: SortOption.priceDesc,
                  child: Text("Price: High to Low"),
                ),
                DropdownMenuItem(
                  value: SortOption.newest,
                  child: Text("Newest"),
                ),
                DropdownMenuItem(
                  value: SortOption.oldest,
                  child: Text("Oldest"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: closePanel,
              child: const Text("Apply Sort"),
            ),
          ],
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // شريط فرعي لعرض أيقونات الفلترة والفرز
            if (widget.rowSpaces != null ||
                widget.filterWidget != null ||
                widget.sortWidget != null) ...[
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
                    GestureDetector(
                      onTap: () => openPanel(PanelType.sort, widget.sortDrawerSide),
                      child: widget.sortWidget ?? const Icon(Icons.sort),
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
            // عرض شبكة المنتجات
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
        // تراكب الدرج عند فتحه
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
}
