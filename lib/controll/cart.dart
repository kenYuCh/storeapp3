import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';

import 'package:storeappver3/models/product.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final int price;
  final String image;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.image,
  });
}

class CartProvider with ChangeNotifier {
  List<ProductModel> _itemIds = [];
  List<Map<String, dynamic>> cartItems = [];
  Map<String, CartItem> _itemsA = {};
  Map<String, CartItem> get itemsA => _itemsA;
  int quantity = 0;
  int totalPrice = 0;
  CartProvider() {
    init();
  }
  void init() {
    _itemIds = [];
  }

  // Map<String, CartItem> get itemsA {
  //   return {..._itemsA};
  // }

  int get itemCount {
    return _itemsA.length;
  }

  List<ProductModel> get items => _itemIds;

  int get totalAmount {
    var total = 0;
    _itemsA.forEach((key, cartItem) {
      total = total + cartItem.price * cartItem.quantity.toInt();
    });
    return total;
  }

  void addItem(String id, double price, String title, String image) {
    if (quantity > 0) {
      if (_itemsA.containsKey(id)) {
        _itemsA.update(id, (existing) {
          return CartItem(
              id: id,
              title: title,
              quantity: existing.quantity + quantity,
              price: price.toInt(),
              image: image);
        });
        print("$title is added to cart multiple");
      } else {
        // 查找 [key] 的值，如果不存在，則添加新條目。如果有一個，則返回與 [key] 關聯的值。
        _itemsA.putIfAbsent(
          id,
          () => CartItem(
            id: id,
            title: title,
            quantity: quantity,
            price: price.toInt(),
            image: image,
          ),
        );
        print("$title is added to cart");
      }
    }
    print(_itemsA['1']!.price); // 109

    notifyListeners();
  }

  void removeItem(String id) {
    print(id);
    _itemsA.remove(id);
    notifyListeners();
  }

  void remove(ProductModel catalog) {
    _itemIds.removeWhere((item) => item.id == catalog.id);
    notifyListeners();
  }

  void decrease() {
    if (quantity > 0) {
      quantity -= 1;
      print("decrease");
    }

    notifyListeners();
  }

  void increase() {
    if (quantity >= 0) {
      quantity += 1;
      print("increase");
    }

    notifyListeners();
  }

  int index = 0;
}


/*


cart.dart

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

order.dart
class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> orderedProducts;
  final DateTime datetime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.orderedProducts,
    @required this.datetime,
  });
}







*/