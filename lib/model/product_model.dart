import 'package:task_5/model/category_model.dart';

class Product {
  final int id;
  final String name;
  final SubCategory subCategory;
  final String image;
  final double price;
  final double evaluation;
  final double discount;

  Product({
    required this.id,
    required this.name,
    required this.subCategory,
    required this.image,
    required this.price,
    required this.evaluation,
    required this.discount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      subCategory: SubCategory.fromJson(json['sub-category']),
      image: json['image'],
      price: json['price'].toDouble(),
      evaluation: json['evaluation'].toDouble(),
      discount: json['discount'].toDouble(),
    );
  }
}

class SubCategory {
  final int id;
  final String name;
  final CategoryModel category;

  SubCategory({
    required this.id,
    required this.name,
    required this.category,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      category: CategoryModel.fromJson(json['category']),
    );
  }
}