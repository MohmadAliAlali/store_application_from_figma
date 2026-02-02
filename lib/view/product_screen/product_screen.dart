import 'package:flutter/material.dart';
import 'package:task_5/controller/order_controler.dart';
import 'package:task_5/controller/product_controller.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/navigation.dart';
import 'package:task_5/core/responsiv/risponsive.dart';
import 'package:task_5/core/widget/custom_button.dart';
import 'package:task_5/core/widget/custom_card.dart';
import 'package:task_5/model/product_model.dart';
import 'package:task_5/view/detels_screen/detels_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  final OrderControler _orderController = OrderControler();

  bool _isLoading = true;
  List<Product>? _products;
  final ProductController _productController = ProductController();
  int _quantity = 1; // قيمة افتراضية للعدد
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _productController.fetchProducts();

    setState(() {
      _products = products;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: GlobalColor.backgroundPage,
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          width: ScreenUtil.getWidth(136),
          height: ScreenUtil.getHeight(46),
          alignment: Alignment.center,
          child: Text(
            'All Products',
            style: TextStyle(
              fontSize: ScreenUtil.getWidth(16),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: GlobalColor.backgroundPage,
        leading: Navigator.canPop(context)
            ? CustomIcon(
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: GlobalColor.iconColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _products == null || _products!.isEmpty
              ? const Center(child: Text('No products found.'))
              : GridView.builder(
                  padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 20), // Add space at the bottom
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: ScreenUtil.getWidth(5),
                    mainAxisSpacing: ScreenUtil.getHeight(10),
                    childAspectRatio: ScreenUtil.getWidth(0.82),
                  ),
                  itemCount: _products!.length,
                  itemBuilder: (context, index) {
                    final product = _products![index];

                    return GestureDetector(
                      onTap: () {},
                      child: ProductCard(
                        imageUrl: 'assets/image 2.png',
                        title: product.name,
                        price: product.price,
                        onAddPressed: () {},
                        description: product.subCategory.name,
                        onFavourite: () {},
                        favorites: const Icon(Icons.favorite_outline),
                        onclick: () {
                          Navigation.navigateTo(
                              context, ProductDetailsScreen(product: product));
                        },
                        widget: CustomAddIcon(
                          (() async {
                            _showAddProductDialog(_products![index].id);
                          }),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

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
              onPressed: () async {
                Future<bool> state =
                    _orderController.postOrder(_products![index].id, _quantity);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      await state ? 'success!' : 'error try again',
                    ),
                    backgroundColor: await state ? Colors.green : Colors.red,
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
}
