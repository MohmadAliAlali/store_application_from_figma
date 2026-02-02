class BackendURl{
  static String rootUrl = 'https://task.focal-x.com';

  static Uri login = Uri.parse('$rootUrl/api/login');
  static Uri register = Uri.parse('$rootUrl/api/register');
  static Uri logout = Uri.parse('$rootUrl/api/logout');
  static Uri products = Uri.parse('$rootUrl/api/products');
  static Uri category = Uri.parse('$rootUrl/api/categories');
  static Uri orders = Uri.parse('$rootUrl/api/orders');
  static String ordersDelete = '$rootUrl/api/orders';


}