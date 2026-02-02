import 'package:flutter/material.dart';
import 'package:task_5/controller/category_controller.dart';
import 'package:task_5/controller/order_controler.dart';
import 'package:task_5/controller/product_controller.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/global_text_style.dart';
import 'package:task_5/core/navigation.dart';
import 'package:task_5/core/responsiv/risponsive.dart';
import 'package:task_5/core/widget/custom_button.dart';
import 'package:task_5/core/widget/custom_card.dart';
import 'package:task_5/core/widget/custom_click_text.dart';
import 'package:task_5/core/widget/custom_text_field.dart';
import 'package:task_5/model/category_model.dart';
import 'package:task_5/model/product_model.dart';
import 'package:task_5/view/detels_screen/detels_screen.dart';
import 'package:task_5/view/product_screen/product_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onDrawerIconPressed;

  const HomeScreen({super.key, required this.onDrawerIconPressed});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _emailController = TextEditingController();
  List<int> selectedItems = [];
  final ProductController _productController = ProductController();
  final OrderControler _orderController = OrderControler();

  final CategoryController _categoryController = CategoryController();

  List<Product>? _products;
  List<CategoryModel>? _category;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCategory();
  }

  Future<void> _loadCategory() async {
    final products = await _categoryController.fetchCategory();

    setState(() {
      _category = products;
      _isLoading = false;
    });
  }

  Future<void> _loadProducts() async {
    final products = await _productController.fetchProducts();

    setState(() {
      _products = products;
      _isLoading = false;
    });
  }

  void toggleSelection(int index) {
    setState(() {
      if (selectedItems.contains(index)) {
        selectedItems.remove(index); // إلغاء التحديد
      } else {
        selectedItems.add(index); // تحديد العنصر
      }
    });
  }

  int _quantity = 1;

  void _showAddProductDialog(int index) {
    int initialQuantity = 1; // الكمية الابتدائية
    _quantity = initialQuantity;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Product"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Choose quantity:"),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) {
                              _quantity--;
                            }
                          });
                        },
                      ),
                      Text(
                        '$_quantity',
                        style: const TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async{
                Future<bool> state = _orderController.postOrder(_products![index].id, _quantity);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      await state ? 'success!' : 'error try again',
                    ),
                    backgroundColor:await state ? Colors.green : Colors.red,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: GlobalColor.backgroundPage,
      appBar: AppBar(
        centerTitle: true,
        title: Stack(
          children: [
            Container(
              width: ScreenUtil.getWidth(136),
              height: ScreenUtil.getHeight(46),
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/icons/Highlight_05.png',
                width: ScreenUtil.getWidth(25),
                height: ScreenUtil.getHeight(25),
              ),
            ),
            Container(
              width: ScreenUtil.getWidth(136),
              height: ScreenUtil.getHeight(46),
              alignment: Alignment.center,
              child: Text(
                'Explore',
                style: TextStyle(
                  fontSize: ScreenUtil.getWidth(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: GlobalColor.backgroundPage,
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: widget.onDrawerIconPressed,
              child: Image.asset(
                'assets/icons/Hamburger (1).png', // Replace with your icon's path
                width: ScreenUtil.getWidth(25),
                height: ScreenUtil.getHeight(25),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil.getWidth(20)),
            child: SizedBox(
              child: CustomIconAction(
                onPressed: () {
                  Navigation.navigateTo(context, const ProductsScreen());
                },
                icon: Image.asset('assets/icons/bag-2 (1).png'),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil.getHeight(10)),
            Row(
              children: [
                CustomTextFieldSearch(
                  controller: _emailController,
                  text: '',
                  hintText: 'search',
                  prefixIcon: Icons.search,
                  paddingLeft: 20,
                  paddingRight: 14,
                  width: ScreenUtil.getWidth(270),
                  height: ScreenUtil.getHeight(52),
                ),
                CustomIconAction(
                  height: ScreenUtil.getHeight(52),
                  width: ScreenUtil.getWidth(52),
                  color: GlobalColor.greenButton,
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/icons/sliders.png',
                    width: ScreenUtil.getWidth(24),
                    height: ScreenUtil.getHeight(24),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenUtil.getWidth(24),
                  ScreenUtil.getHeight(40),
                  ScreenUtil.getWidth(24),
                  ScreenUtil.getHeight(16)),
              child: const Text(
                'Select Category',
                style: GlobalTextStyle.subheading,
              ),
            ),
            SizedBox(
              height: ScreenUtil.getHeight(40), // ارتفاع القائمة الأفقية
              child: _category != null && _category!.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _category?.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedItems.contains(index);
                        return GestureDetector(
                          onTap: () => toggleSelection(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: ScreenUtil.getWidth(
                                108),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                _category?[index].name ?? 'Unnamed Category',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox
                      .shrink(), // إذا لم تكن هناك أي فئات، اعرض SizedBox فارغ
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil.getHeight(28),
                  left: ScreenUtil.getWidth(20),
                  right: ScreenUtil.getWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // لتوزيع العناصر بين الجانبين
                children: [
                  const Text(
                    'Popular T-shirt',
                    style: GlobalTextStyle.subheading,
                  ),
                  CustomClickText(
                    text: 'see more',
                    onPressed: () {
                      Navigation.navigateTo(context, const ProductsScreen());
                    },
                    textStyle: GlobalTextStyle.clickText,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil.getHeight(20),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil.getWidth(15),
                  right: ScreenUtil.getWidth(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isLoading
                      ? Container(
                          width: ScreenUtil.getWidth(157),
                          alignment: Alignment.center,
                          height: ScreenUtil.getHeight(199),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil.getWidth(16)),
                              color: Colors.white),
                          child: const CircularProgressIndicator())
                      : _products == null || _products!.isEmpty
                          ? Container(
                              width: ScreenUtil.getWidth(157),
                              alignment: Alignment.center,
                              height: ScreenUtil.getHeight(199),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil.getWidth(16)),
                                  color: Colors.white),
                              child: const Text('No products found.'))
                          : ProductCard(
                              imageUrl: 'assets/image 2.png',
                              title: _products![0].name,
                              price: _products![0].price,
                              onAddPressed: () {},
                              description: _products![0].subCategory.name,
                              onFavourite: () {},
                              favorites: const Icon(Icons.favorite_outline),
                              onclick: () {
                                Navigation.navigateTo(
                                    context,
                                    ProductDetailsScreen(
                                        product: _products![0]));
                              },
                              widget: CustomAddIcon(((){
                                _showAddProductDialog(0);
                              }),),
                            ),
                  SizedBox(
                    width: ScreenUtil.getWidth(20),
                  ),
                  _isLoading
                      ? Container(
                          width: ScreenUtil.getWidth(157),
                          alignment: Alignment.center,
                          height: ScreenUtil.getHeight(199),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil.getWidth(16)),
                              color: Colors.white),
                          child: const CircularProgressIndicator())
                      : _products == null || _products!.isEmpty
                          ? Container(
                              width: ScreenUtil.getWidth(157),
                              alignment: Alignment.center,
                              height: ScreenUtil.getHeight(199),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil.getWidth(16)),
                                  color: Colors.white),
                              child: const Text('No products found.'))
                          : ProductCard(
                              imageUrl: 'assets/image 2.png',
                              title: _products![1].name,
                              price: _products![1].price,
                              onAddPressed: (){},
                              description: _products![1].subCategory.name,
                              onFavourite: () {},
                              favorites: const Icon(Icons.favorite_outline),
                              onclick: () {
                                Navigation.navigateTo(
                                    context,
                                    ProductDetailsScreen(
                                        product: _products![1]));
                              },
                              widget: CustomAddIcon((){
                                _showAddProductDialog(1);
                              }),
                            ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil.getHeight(26),
                  left: ScreenUtil.getWidth(20),
                  right: ScreenUtil.getWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // لتوزيع العناصر بين الجانبين
                children: [
                  const Text(
                    'New Arrivals',
                    style: GlobalTextStyle.subheading,
                  ),
                  CustomClickText(
                    text: 'see more',
                    onPressed: () {},
                    textStyle: GlobalTextStyle.clickText,
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil.getHeight(20),
                      left: ScreenUtil.getWidth(21),
                      right: ScreenUtil.getWidth(20)),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: ScreenUtil.getHeight(20),
                      bottom: ScreenUtil.getHeight(20),
                      left: ScreenUtil.getWidth(22),
                    ),
                    width: ScreenUtil.getWidth(335),
                    height: ScreenUtil.getHeight(95),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image:
                            AssetImage('assets/test.png'), // تحديد مسار الصورة
                        fit: BoxFit
                            .cover, // لضبط حجم الصورة لتغطية الـ Container بالكامل
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summer Sale',
                          style: GlobalTextStyle.body.copyWith(
                              color: GlobalColor.black,
                              fontSize: ScreenUtil.getWidth(12),
                              height: ScreenUtil.getHeight(1.1)),
                        ),
                        Text(
                          '15% OFF',
                          style: TextStyle(
                              color: const Color(0xff674DC5),
                              fontSize: ScreenUtil.getWidth(30),
                              height: ScreenUtil.getHeight(1),
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: ScreenUtil.getWidth(36),
                  bottom: ScreenUtil.getHeight(-4),
                  child: Image.asset('assets/image 4.png'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
