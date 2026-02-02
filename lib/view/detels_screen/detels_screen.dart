import 'package:flutter/material.dart';
import 'package:task_5/controller/order_controler.dart';
import 'package:task_5/core/global_color.dart';
import 'package:task_5/core/global_style_text.dart';
import 'package:task_5/core/global_text_style.dart';
import 'package:task_5/core/responsiv/risponsive.dart';
import 'package:task_5/core/widget/custom_button.dart';
import 'package:task_5/model/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _DetelsScreenState();
}

class _DetelsScreenState extends State<ProductDetailsScreen> {
  bool isExpanded = false;
  final OrderControler _orderController = OrderControler();
  int _quantity = 1;

  String text =
      'Young women who appreciate their bodies and consider them physical objects are more likely to select, edit, and post selfies to social media, suggests this study in Psychology of Popular Media (Vol. 9, No. 1). Researchers surveyed 179 women, ages 18 to 25, on how often they took selfies, how they selected selfies to post, how often they used filters and editing techniques, and how carefully they planned their selfie postings. They also assessed participants’ levels of body appreciation and dissatisfaction, self-objectification, and self-esteem. Higher levels of self-objectification were linked to more time spent on all selfie behaviors, while body appreciation was related to more time spent selecting selfies to post, but not frequency of taking or editing selfies. Body dissatisfaction and self-esteem were not associated with selfie behaviors.';
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
              'Favourite',
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
              : CustomIcon(
                  color: Colors.white,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: GlobalColor.iconColor,
                  ),
                  onPressed: () {},
                ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil.getWidth(20)),
              child: SizedBox(
                child: CustomIconAction(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_outline_outlined,
                    size: ScreenUtil.getWidth(24),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.product.name,
                      style: GlobalTextStyle.heading
                          .copyWith(color: GlobalColor.black, fontSize: 26),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      widget.product.subCategory.name,
                      style:
                          GlobalTextStyle.body.copyWith(color: Colors.black26),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '\$ ${widget.product.price}',
                      style: GlobalTextStyle.heading
                          .copyWith(color: GlobalColor.black, fontSize: 24),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/image 5.png',
                        image: widget.product.image,
                        width: 217,
                        height: 220,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/image 5.png',
                              height: 220, width: 217);
                        },
                      ),
                    ),
                    Image.asset('assets/Slider.png', height: 65, width: 340),
                    Image.asset('assets/Group 1000000751.png',
                        height: 65, width: 340),
                    const SizedBox(height: 27),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: Text(
                        text,
                        maxLines: isExpanded ? null : 3,
                        overflow: isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? "lese" : "more",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.topCenter,
          height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 1,),

          CustomIconAction(
            height: ScreenUtil.getHeight(52),
            width: ScreenUtil.getWidth(52),
            color:const  Color(0x66D9D966),
            onPressed: () {},
            icon: Image.asset(
              'assets/icons/Path.png',
              width: ScreenUtil.getWidth(24),
              height: ScreenUtil.getHeight(24),
              color: GlobalColor.black,
            ),
          ),
          const SizedBox(width: 1,),

          CustomButton(
            width: 208,
            onPressed: _showAddProductDialog,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/bag-2.png',width: 24,height: 24,color: Colors.white,),
                const SizedBox(width: 24,),
                Text(
                  'Add to Cart',
                  style: GlobalText.text18.copyWith(color: Colors.white,fontSize: 12),
                ),

              ],
            )
          ),
        ],
      ),
    ),
    );
  }

  void _showAddProductDialog() {
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
                    _orderController.postOrder(widget.product.id, _quantity);
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
