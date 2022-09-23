import 'package:flutter/foundation.dart';
import 'package:storeappver3/models/product.dart';
import 'package:storeappver3/repository/product.dart';

class ProductProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final _repository = ProductRepository();
  List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  ProductProvider() {
    init();
  }
  init() async {
    _productList = await _repository.getProducts();
    print("init...ProductProvider.");
    notifyListeners();
  }

  Future getProduct() async {
    _productList = await _repository.getProducts();
    notifyListeners();
  }

  Future addCatalog() async {
    await _repository.addProducts();
    notifyListeners();
  }
}
