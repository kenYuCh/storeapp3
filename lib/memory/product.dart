import 'package:storeappver3/controll/product.dart';
import 'package:storeappver3/models/product.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

Dio dio = Dio();

class ProductMemo {
  List<ProductModel> result = [];
  ProductMemo() {
    initCatalogs();
  }
  Future initCatalogs() async {
    result.clear();
  }

  Future<List<ProductModel>> getAllProducts() async {
    final response = await dio.get("https://fakestoreapi.com/products");
    final jsonString = jsonEncode(response.data);
    final jsonArray = jsonDecode(jsonString) as List;
    result = jsonArray.map((e) => ProductModel.fromJson(e)).toList();
    // print(jsonEncode(result[0]));
    return result;
  }

  Future getSigleProducts(int id) async {
    final response = await dio.get("https://fakestoreapi.com/products/${id}");
    final jsonString = jsonEncode(response.data);
    final jsonArray = jsonDecode(jsonString);
    // print(jsonEncode(jsonArray)); // {"id":1}
    return jsonArray;
  }

  Future<List<ProductModel>> getLimitProducts(int limit) async {
    final response =
        await dio.get("https://fakestoreapi.com/products?limit=${limit}");
    final jsonString = jsonEncode(response.data);
    final jsonArray = jsonDecode(jsonString) as List;
    result = jsonArray.map((e) => ProductModel.fromJson(e)).toList();
    // print(result);
    return result;
  }

  Future<List<ProductModel>> getProductsSort(String sort) async {
    final response =
        await dio.get("https://fakestoreapi.com/products?sort=${sort}");
    final jsonString = jsonEncode(response.data);
    final jsonArray = jsonDecode(jsonString) as List;
    result = jsonArray.map((e) => ProductModel.fromJson(e)).toList();
    // print(result);
    return result;
  }

  Future<List<ProductModel>> getCategory() async {
    final response =
        await dio.get("https://fakestoreapi.com/products/categories");
    final jsonString = jsonEncode(response.data);
    final jsonArray = jsonDecode(jsonString) as List;
    result = jsonArray.map((e) => ProductModel.fromJson(e)).toList();
    // print(result);
    return result;
  }

  Future<List<ProductModel>> getSpecificCategory(String category) async {
    final response =
        await dio.get("https://fakestoreapi.com/products/category/${category}");
    final jsonString = jsonEncode(response.data);
    final jsonArray = jsonDecode(jsonString) as List;
    result = jsonArray.map((e) => ProductModel.fromJson(e)).toList();
    // print(jsonEncode(result));
    return result;
  }

//

  addNewProduct() async {
    final response = await dio.post(
      "https://fakestoreapi.com/products",
      queryParameters: {
        'title': 'test product',
        'price': 13.5,
        'description': 'lorem ipsum set',
        'image': 'https://i.pravatar.cc',
        'category': 'electronic'
      },
    );
    final resultData = await getAllProducts();
    return resultData.length; // 回傳資料筆數
  }

  void updateProduct(int id) async {
    final response = await dio.put(
      "https://fakestoreapi.com/products/${id}",
      queryParameters: {
        'title': 'test product',
        'price': 13.5,
        'description': 'lorem ipsum set',
        'image': 'https://i.pravatar.cc',
        'category': 'electronic'
      },
    );
  }

  void deleteProduct(int id) async {
    final response = await dio.delete(
      "https://fakestoreapi.com/products/${id}",
    );
  }
}
