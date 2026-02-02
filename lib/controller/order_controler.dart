import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_5/model/order_mode.dart';
import 'package:task_5/server/backend_url.dart';

class OrderControler {

  Future<bool> deleteOrder(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.delete(
        Uri.parse('${BackendURl.orders}/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  Future<bool> updateOrder(int productId, int quantity) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.put(
        Uri.parse('https://task.focal-x.com/api/orders/179'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json', // Add Content-Type header here
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
        body: jsonEncode({
          'quantity':quantity
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {

      return false;
    }
  }

  Future<bool> postOrder(int productId, int quantity) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        BackendURl.orders,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
        body: jsonEncode({
          'product_id': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {

        return false;
      }
    } catch (e) {
      return false;
    }
  }
  Future<List<Order>?> fetchOrder() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        BackendURl.orders,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body)['data'];
        List<Order> order = jsonData.map((item) => Order.fromJson(item)).toList();

        return order;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}