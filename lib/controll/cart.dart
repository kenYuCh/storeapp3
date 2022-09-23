import 'package:flutter/foundation.dart';

import 'package:storeappver3/models/product.dart';

class CartController with ChangeNotifier {
  List<ProductModel> _itemIds = [];

  CartController() {
    init();
  }

  List<ProductModel> get items => _itemIds;

  int get totalPrice =>
      items.fold(0, (total, current) => (total + current.price).toInt());

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
}
