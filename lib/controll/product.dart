import 'package:flutter/foundation.dart';
import 'package:storeappver3/models/product.dart';
import 'package:storeappver3/repository/product.dart';

class ProductProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final _repository = ProductRepository();
  List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;
  List<ProductModel> _cart = [];
  int numberSingle = 0;
  List catagoryType = [
    ["electronics", true],
    ["jewelery", false],
    ["men's clothing", false],
    ["women's clothing", false]
  ];
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

  selectedCatagory(int index) {
    print("select");
    for (int i = 0; i < catagoryType.length; i++) {
      catagoryType[i][1] = false;
    }
    catagoryType[index][1] = true;
    notifyListeners();
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

  void buy(ProductModel product) {
    for (int i = 0; i < numberSingle; i++) {
      _cart.add(product);
    }
    print(_cart.length);
    notifyListeners();
  }
}
