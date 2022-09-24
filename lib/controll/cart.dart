import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';

import 'package:storeappver3/models/product.dart';

class CartProvider with ChangeNotifier {
  List<ProductModel> _itemIds = [];
  List<Map<String, dynamic>> cartItems = [];
  int numberSingle = 0;
  int totalPrice = 0;
  CartProvider() {
    init();
  }

  List<ProductModel> get items => _itemIds;

  // int get totalPrice =>
  //     items.fold(0, (total, current) => (total + current.price).toInt());

  void init() {
    _itemIds = [];
  }

  add(ProductModel catalog) {
    _itemIds.add(catalog);
    notifyListeners();
  }

  remove(ProductModel catalog) {
    _itemIds.removeWhere((item) => item.id == catalog.id);
    notifyListeners();
  }

  clear() {
    _itemIds.clear();
    notifyListeners();
  }

  contains(id) {
    return _itemIds
        .map((item) {
          return item.id;
        })
        .toList()
        .contains(id);
  }

  //////////////////////////////
  void decrease() {
    if (numberSingle > 0) {
      numberSingle -= 1;
    }

    notifyListeners();
  }

  void increase() {
    if (numberSingle >= 0) {
      numberSingle += 1;
    }

    notifyListeners();
  }

  int index = 0;

  void buy(ProductModel product) {
    int itemTotalPrice = product.price.toInt() * numberSingle; // 計算單品總購買價格
    Map<String, dynamic> mapsTest = {
      "cartID": index += 1,
      "product": product.toJson(),
      "number": numberSingle,
      "itemTotalPrice": itemTotalPrice,
    };
    cartItems.add(mapsTest);
    totalPrice = totalPrice + itemTotalPrice;
    print("buy-totalPrice: ${totalPrice}");

    notifyListeners();
  }

  removeProduct(int cartID, int productID, int itemTotalPrice) {
    print(
        "removeProductID: ${productID} / cartID: ${cartID} /itemTotalPrice: ${itemTotalPrice}");
    cartItems.removeWhere((e) => e['cartID'] == cartID);
    totalPrice = totalPrice - itemTotalPrice;

    notifyListeners();
  }

  getTotalPrice() {}
}
