import 'package:dro/model/product.dart';

class Cart {
  int quantity;
  double cartPrice;
  Product product;

  Cart({this.quantity = 1, required this.cartPrice, required this.product});
}
