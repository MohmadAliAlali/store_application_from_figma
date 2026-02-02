import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_5/model/product_model.dart';
import 'package:task_5/server/backend_url.dart';

class ProductController {


  Future<List<Product>?> fetchProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        BackendURl.products,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> jsonData = json.decode(response.body)['data'];
        List<Product> products = jsonData.map((item) => Product.fromJson(item)).toList();
        return products;
      } else {
        // Handle error response
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}