import 'dart:async';
import 'package:dro/model/cart.dart';
import 'package:dro/model/product.dart';
import 'cart_action.dart';
import 'cart_event.dart';

class CartBloc {
  double _cartTotal = 0;
  final List<Cart> _carts = [];

  final _cartTotalController = StreamController<double>.broadcast();
  StreamSink<double> get _cartTotalSink => _cartTotalController.sink;
  Stream<double> get cartTotalStream => _cartTotalController.stream;

  final _cartListController = StreamController<List<Cart>>.broadcast();
  StreamSink<List<Cart>> get _cartListSink => _cartListController.sink;
  Stream<List<Cart>> get cartListStream => _cartListController.stream;

  final _cartEventController = StreamController<CartAction>();
  Sink<CartAction> get cartEventSink => _cartEventController.sink;

  CartBloc() {
    _cartEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CartAction cartAction) {
    if (cartAction.event == CartEvent.updateQuantity) {
      int index = cartAction.data["cartIndex"];
      int newQuantity = cartAction.data["newQuantity"];

      //update cart quantity
      Cart cart = _carts[index];
      cart.quantity = newQuantity;
      _cartListSink.add(_carts);

      //compute cart total
      cartTotalPrice();
    }
    if (cartAction.event == CartEvent.getCartList) {
      _cartListSink.add(_carts);
      cartTotalPrice();
    }
    if (cartAction.event == CartEvent.deleteCartItem) {
      int index = cartAction.data["cartIndex"];
      _carts.removeAt(index);
      _cartListSink.add(_carts);

      //compute cart total
      cartTotalPrice();
    }
    if (cartAction.event == CartEvent.addToCart) {
      int quantity = cartAction.data["quantity"];
      Product product = cartAction.data["product"];

      Cart cart = Cart(
        quantity: quantity,
        product: product,
        cartPrice: product.price * quantity,
      );

      _carts.add(cart);
      _cartListSink.add(_carts);

      //compute cart total
      cartTotalPrice();
    }
    if (cartAction.event == CartEvent.checkOut) {
      _cartTotal = 0;
      _carts.clear();

      _cartListSink.add(_carts);

      //compute cart total
      cartTotalPrice();
    }
  }

  bool alreadyInCart(Product product) {
    for (Cart cart in _carts) {
      if (product == cart.product) {
        return true;
      }
    }
    return false;
  }

  void cartTotalPrice() {
    double cost = 0;

    if (_carts.isNotEmpty) {
      for (var cart in _carts) {
        cost += cart.quantity * cart.product.price;
      }
    }

    //compute cart total
    _cartTotal = cost;
    _cartTotalSink.add(_cartTotal);
  }

  void dispose() {
    _cartTotalController.close();
    _cartListController.close();
    _cartEventController.close();
  }
}
