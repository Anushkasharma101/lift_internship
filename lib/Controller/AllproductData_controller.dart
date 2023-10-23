import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/AllproductsData.dart';

class AllProductDataController extends GetxController {
  // Observables
  var categories = <String>[].obs;
  var products = <Product>[].obs;

  // Fetch categories and products
  Future<void> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/categories'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonDataList = json.decode(response.body);

        final List<String> categoryNames = jsonDataList
            .map((json) => json['name'].toString())
            .toList();
        categories.assignAll(categoryNames);
        if(categories.isNotEmpty){
          fetchProductsByCategory(categoryNames[0]);
        }
        // Fetch products for the first category
      } else {
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }


  Future<List<Product>> fetchProductsByCategory(String category) async {
    const String apiUrl = 'https://api.escuelajs.co/api/v1/products'; // API endpoint
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonDataList = json.decode(response.body);
      List<Product> productList = jsonDataList
          .map((json) => Product.fromJson(json))
          .where((product) => product.category.name == category)
          .toList();
      products.assignAll(productList);
      return productList;// Update the products list
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  // Fetch product details by ID
  Future<Product> fetchProductDetails(int productId) async {
    final apiUrl = 'https://api.escuelajs.co/api/v1/products/$productId';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> productData = json.decode(response.body);
        final product = Product.fromJson(productData);
        print('propropro ${product.title}');
        return product;
      } else {
        throw Exception('Failed to fetch product details');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}
