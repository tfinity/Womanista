import 'package:flutter/cupertino.dart';

class Product {
  String? id;
  String? name;
  double? price;
  String? img;
  String? description;
  Product({this.id, this.name, this.price, this.img, this.description});
}

class ProductProvider with ChangeNotifier {
  List<Product> products = [];

  add(Product p) {
    if (!products.any((element) => element.id == p.id)) {
      products.add(p);
    }

    notifyListeners();
  }

  remove(Product p) {
    products.removeWhere((element) => element.id == p.id);
    notifyListeners();
  }
}
