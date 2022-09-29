import 'package:datagrid/screen1_func/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Product>> generateProductList() async {
  var response = await http.get(Uri.parse(
      'https://ej2services.syncfusion.com/production/web-services/api/Orders'));
  var decodedProducts =
  json.decode(response.body).cast<Map<String, dynamic>>();
  List<Product> productList = await decodedProducts
      .map<Product>((json) => Product.fromJson(json))
      .toList();
  return productList;
}
