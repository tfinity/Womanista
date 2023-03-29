import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:womanista/screens/modules/ECommerce/ProductClass.dart';

class Cart with ChangeNotifier {
  List<CartItem> products = [];
  List<CartItem> get cartProducts => products;
  int get count => products.length;
  int cartPageIndex = 0;

  double get totalPrice {
    double totalPrice = 0;
    for (var element in products) {
      totalPrice += element.price! * element.count;
    }
    return totalPrice;
  }

  add(CartItem p) {
    if (products.any((element) => element.id == p.id)) {
      log("true part");
      products.firstWhere((element) => element.id == p.id).count++;
    } else {
      log("else part");
      products.add(p);
    }

    notifyListeners();
  }

  remove(Product p) {
    products.removeWhere((element) => element.id == p.id);

    notifyListeners();
  }

  incrementPage() {
    cartPageIndex++;
    notifyListeners();
  }

  decrementPage() {
    cartPageIndex--;
    notifyListeners();
  }

  resetPage() {
    cartPageIndex = 0;
    notifyListeners();
  }

  incrementQuantity(CartItem item) {
    products.firstWhere((element) => element == item).count++;
    notifyListeners();
  }

  decrementQuantity(CartItem item) {
    CartItem found = products.firstWhere((element) => element == item);
    if (found.count > 0) {
      found.count--;
    }

    notifyListeners();
  }
}

class CartItem extends Product {
  CartItem({id, name, img, des, price, this.count = 0})
      : super(id: id, name: name, description: des, img: img, price: price);
  int count;

  Map toJsonIdCount() => {
        'id': id,
        'count': count,
      };
}
