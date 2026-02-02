
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_5/controller/order_controler.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/global_text_style.dart';
import 'package:task_5/core/responsiv/risponsive.dart';
import 'package:task_5/core/widget/custom_button.dart';
import 'package:task_5/core/widget/custom_text.dart';
import 'package:task_5/model/order_mode.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  double subtotal = 0;
  final OrderControler _orderController = OrderControler();

  List<Order> _orders = [];
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }
  Future<void> _loadProducts() async {
    var order = await _orderController.fetchOrder();
    setState(() {
      _orders = order ?? []; // Assign an empty list if order is null
    });
    calculate();
  }
  double calculate() {
    for (int i = 0; i <_orders.length; i++) {

      subtotal = subtotal + (_orders[i].product.price*_orders[i].quantity);
    }
    return subtotal;
  }
  int _quantity = 1;

  void _showAddProductDialog(int index) {
    int initialQuantity = _orders[index].quantity;
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
                Future<bool> state = _orderController.updateOrder(_orders[index].id, _quantity);
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
        title: Container(
          width: ScreenUtil.getWidth(136),
          height: ScreenUtil.getHeight(46),
          alignment: Alignment.center,
          child: Text(
            'My Cart',
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
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(left: 12),child: Text('${_orders.length} Item',
                style: GlobalTextStyle.body.copyWith(color: GlobalColor.black)),),
            const SizedBox(height: 16),
             SizedBox(
              height: 435,
              child: ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      extentRatio: 0.3,
                      children: [
                        CustomSlidableAction(
                          onPressed: null, // Disable the action
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showAddProductDialog(index);
                                  },
                                  child: const Icon(Icons.add, color: Colors.white),
                                ),
                                Text(
                                  '${_orders[index].quantity}',
                                  style: const TextStyle(color: Colors.white, fontSize: 11),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showAddProductDialog(index);
                                  },
                                  child: const Icon(Icons.remove, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),


                    endActionPane: ActionPane(
                      motion: const StretchMotion(),

                      extentRatio: 0.3,
                      children: [
                        CustomSlidableAction(
                          onPressed: (context) async{
                            Future<bool> success = _orderController.deleteOrder(_orders[index].id);
                            _loadProducts();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  await success ? 'delete success!' : 'delete have error',
                                ),
                                backgroundColor:await success ? Colors.green : Colors.red,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            height: 104,
                            width: 58,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.delete_outline_outlined,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Prevent the item from sliding back when tapping on the tile
                      },
                      child: Container(
                        width: 335,
                        height: 108,
                        margin:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/logo.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            _orders[index].product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${_orders[index].product.price *_orders[index].quantity}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 34),
                  CustomText(
                    text1: 'Subtotal',
                    text2: subtotal,
                    style1:
                        GlobalTextStyle.clickText.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                      text1: 'Delivery',
                      text2: subtotal * 0.15,
                      style1: GlobalTextStyle.clickText
                          .copyWith(color: Colors.grey)),
                  const SizedBox(height: 8),
                  const Text('---------------------------------------------------'),
                  CustomText(
                    text1: 'Total Cost',
                    text2: subtotal +(subtotal*0.15),
                    style2:
                        GlobalTextStyle.clickText.copyWith(color: Colors.green),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {
                    },
                    child: const Text('Checkout',style: TextStyle(color: Colors.white),),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
