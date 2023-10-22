import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/AllproductsData.dart';

class AllproductController extends GetxController{
  RxBool isLoading = false.obs;
  List<Products> products = [];



  Future<List<Products>> fetchProductsByCategory(Name category) async {

    final String apiUrl = 'https://api.escuelajs.co/api/v1/products';
    final Uri uri = Uri.parse(apiUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body);

      // Filter products by category
      List<Products> products = productsJson
          .where((product) =>
      product['category']['name'] == category.toString().split('.').last)
          .map((product) => Products(
        id: product['id'],
        title: product['title'],
        price: product['price'],
        description: product['description'],
        images: List<String>.from(product['images']),
        creationAt: DateTime.parse(product['creationAt']),
        updatedAt: DateTime.parse(product['updatedAt']),
        category: Category(
          id: product['category']['id'],
          name: Name.values.firstWhere((e) =>
          e.toString().split('.').last == product['category']['name']),
          image: product['category']['image'],
          creationAt: DateTime.parse(product['category']['creationAt']),
          updatedAt: DateTime.parse(product['category']['updatedAt']),
        ),
      ))
          .toList();

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}