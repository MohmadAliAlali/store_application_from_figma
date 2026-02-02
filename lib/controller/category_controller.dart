
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_5/model/category_model.dart';
import 'package:task_5/server/backend_url.dart';
class CategoryController {


  Future<List<CategoryModel>?> fetchCategory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
        BackendURl.category,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body)['data'];
        List<CategoryModel> category = jsonData.map((item) => CategoryModel.fromJson(item)).toList();

        return category;
      } else {

        return null;
      }
    } catch (e) {
      return null;
    }
  }
}