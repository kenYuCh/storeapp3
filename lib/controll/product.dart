import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:storeappver3/models/product.dart';
import 'package:storeappver3/repository/product.dart';

class ProductProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final _repository = ProductRepository();
  List<ProductModel> _productList = [];
  int numberSingle = 0;
  List<Map<String, dynamic>> cartProductID = [];

  ProductProvider() {
    init();
  }
  init() async {
    _productList = await _repository.getProducts();
    print("init...ProductProvider.");
    notifyListeners();
  }

  List<ProductModel> get productItems {
    return _productList;
  }

  // isFavourite
  var isFavoriteTapped = false;
  List<ProductModel> get itemsTest {
    if (isFavoriteTapped)
      return _productList.where((product) => product.isFavourite).toList();
    return [..._productList];
  }

  // category select
  List catagoryType = [
    ["electronics", true],
    ["jewelery", false],
    ["men's clothing", false],
    ["women's clothing", false]
  ];
  void selectedCatagory(int index) {
    catagoryType.map((category) {
      return category[1] = false;
    }).toList();
    catagoryType[index][1] = true;
    notifyListeners();
  }
}
