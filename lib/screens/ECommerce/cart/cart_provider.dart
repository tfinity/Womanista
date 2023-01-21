import 'package:flutter/cupertino.dart';
import 'package:womanista/screens/ECommerce/ProductClass.dart';

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
    products.add(p);
    notifyListeners();
  }

  remove(Product p) {
    products.removeWhere((element) => element == p);

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
  CartItem({name, img, des, price, this.count = 0})
      : super(name: name, description: des, img: img, price: price);
  int count;
}
