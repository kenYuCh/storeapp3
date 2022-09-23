import 'package:storeappver3/memory/product.dart';

const String source = 'memo';

class ProductRepository {
  final _productMemo = ProductMemo();

  Future getProducts() {
    switch (source) {
      case 'memo':
        return _productMemo.getAllProducts();
        break;
      case 'test':
        return _productMemo.getAllProducts();
        break;
      default:
        return _productMemo.getAllProducts();
    }
  }

  Future addProducts({String? query}) {
    switch (source) {
      case 'memo':
        return _productMemo.addNewProduct();
        break;
      case 'test':
        return _productMemo.getAllProducts();
        break;
      default:
        return _productMemo.getAllProducts();
    }
  }
}
