import 'package:task_5/model/product_model.dart';
import 'package:task_5/model/category_model.dart';

class Order {
  final int id;
  final Product product;
  late final int quantity;

  Order({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      product: Product(
        id: json['peoduct']['id'],
        name: json['peoduct']['name'],
        subCategory: SubCategory(
          id: json['peoduct']['sub-category']['id'],
          name: json['peoduct']['sub-category']['name'],
          category: CategoryModel(
            id: json['peoduct']['sub-category']['category']['id'],
            name: json['peoduct']['sub-category']['category']['name'],
          ),
        ),
        image: json['peoduct']['image'],
        price: json['peoduct']['price'].toDouble(),
        evaluation: json['peoduct']['evaluation'].toDouble(),
        discount: json['peoduct']['discount'].toDouble(),
      ),
      quantity: json['quantity'],
    );
  }
}