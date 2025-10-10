import 'dart:convert';
import 'package:http/http.dart';

import '../helpers/api_helper.dart';
import '../models/product_model.dart';

class ProductServices {
  // Method to fetch data from the API
  Future<List<ProductModel>> getAllProducts() async {
    Response response = await API().get(
      url: 'https://fakestoreapi.com/products',
    );
    List<dynamic> data = jsonDecode(response.body);
    List<ProductModel> products = [];
    for (int i = 0; i < data.length; i++) {
      products.add(ProductModel.fromJson(data[i]));
    }
    return products;
  }

  Future<List<String>> getAllCategories() async {
    Response response = await API().get(
      url: 'https://fakestoreapi.com/products/categories',
    );
    List<dynamic> data = jsonDecode(response.body);
    List<String> categories = [];
    for (int i = 0; i < data.length; i++) {
      categories.add(data[i].toString());
    }
    return categories;
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    Response response = await API().get(
      url: 'https://fakestoreapi.com/products/category/$category',
    );
    List<dynamic> data = jsonDecode(response.body);
    List<ProductModel> products = [];
    for (int i = 0; i < data.length; i++) {
      products.add(ProductModel.fromJson(data[i]));
    }
    return products;
  }

  //ADD PRODUCT
  Future<ProductModel> addProduct({
    required String title,
    required String description,
    required String category,
    required double price,
    required String imageUrl,
  }) async {
    Map<String, dynamic> data = await API().post(
      url: 'https://fakestoreapi.com/products',
      body: {
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'image': imageUrl,
      },
    );
    return ProductModel.fromJson(data);
  }
}
