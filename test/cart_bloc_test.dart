import 'package:dro/bloc/cart/cart_action.dart';
import 'package:dro/bloc/cart/cart_bloc.dart';
import 'package:dro/bloc/cart/cart_event.dart';
import 'package:dro/model/cart.dart';
import 'package:dro/model/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Cart Event - ", () {
    late CartBloc cartBloc;
    late Product product1;
    late Product product2;
    late Product product3;
    late List<Cart> cartList = [];
    setUp(() {
      cartBloc = CartBloc();

      product1 = Product(
          id: "1",
          name: "Paracetamol",
          price: 350.00,
          type: "Tablet",
          image: "assets/images/paracetamol.png",
          packSize: "500mg");
      product2 = Product(
          id: "2",
          name: "Doliprane",
          price: 350.00,
          type: "Capsule",
          image: "assets/images/doliprane.png",
          packSize: "1000mg",
          requiresPrescription: true);
      product3 = Product(
          id: "4",
          name: "Not existing",
          price: 350.00,
          type: "Capsule",
          image: "assets/images/doliprane.png",
          packSize: "1000mg",
          requiresPrescription: true);

      Cart cart1 = Cart(
        quantity: 1,
        product: product1,
        cartPrice: product1.price * 1,
      );
      Cart cart2 = Cart(
        quantity: 1,
        product: product2,
        cartPrice: product1.price * 2,
      );

      cartList.add(cart1);
      cartList.add(cart2);
    });

    tearDown(() {
      cartBloc.dispose();
    });
    test("when item is added to cart, increase cartlist, compute cart total",
        () async {
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product1, "quantity": 1}));
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product2, "quantity": 2}));

      expect(cartBloc.cartTotalStream, emitsInOrder([350, 1050]));
      expect((await cartBloc.cartTotalStream.first), 350);
      expect(cartBloc.cartListStream, emits(const TypeMatcher<List<Cart>>()));
      expect((await cartBloc.cartListStream.first).length, 2);
    });

    test(
        "when the quantity of an item in cart is updated, re-compute the new cart total",
        () async {
      //add to cart
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product1, "quantity": 1}));
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product2, "quantity": 2}));

      //update quantity of first item
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.updateQuantity,
          data: {"cartIndex": 0, "newQuantity": 2}));

      expect(cartBloc.cartTotalStream, emitsInOrder([350, 1050, 1400]));
    });

    test(
        "when 'CartEvent.getCartList' is triggered, get current list of cart items and re-compute the new cart total",
        () async {
      //add to cart
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product1, "quantity": 1}));
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product2, "quantity": 2}));

      //call getCartList
      cartBloc.cartEventSink.add(CartAction(event: CartEvent.getCartList));

      expect(cartBloc.cartListStream, emits(const TypeMatcher<List<Cart>>()));
      expect((await cartBloc.cartListStream.first).length, 1);
      expect(cartBloc.cartTotalStream, emits(1050));
    });

    test(
        "when 'CartEvent.deleteCartItem' is triggered, remove item from cart and re-compute the new cart total",
        () async {
      //add to cart
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product1, "quantity": 1}));
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product2, "quantity": 2}));

      //delete second item
      cartBloc.cartEventSink.add(
          CartAction(event: CartEvent.deleteCartItem, data: {"cartIndex": 1}));

      expect(cartBloc.cartListStream, emits(const TypeMatcher<List<Cart>>()));
      expect((await cartBloc.cartListStream.first).length, 1);
      expect(cartBloc.cartTotalStream, emitsInOrder([1050, 350]));
    });

    test(
        "when 'CartEvent.checkOut' is triggered, clear the cart list and re-compute the new cart total",
        () async {
      //add to cart
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product1, "quantity": 1}));
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product2, "quantity": 2}));

      //delete second item
      cartBloc.cartEventSink.add(CartAction(event: CartEvent.checkOut));

      expect(cartBloc.cartListStream, emits(const TypeMatcher<List<Cart>>()));
      expect((await cartBloc.cartListStream.first).length, 1);
      expect(cartBloc.cartTotalStream, emitsInOrder([1050, 0]));
    });

    test("when method 'cartTotalPrice' is called, return cart total", () async {
      //add to cart
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product1, "quantity": 1}));
      cartBloc.cartEventSink.add(CartAction(
          event: CartEvent.addToCart,
          data: {"product": product2, "quantity": 2}));

      cartBloc.cartTotalPrice();

      expect(cartBloc.cartTotalStream, emitsInOrder([350, 1050]));
    });

    // test("when product is already in cart, return true", () async {
    //   //add to cart
    //   cartBloc.cartEventSink.add(CartAction(
    //       event: CartEvent.addToCart,
    //       data: {"product": product1, "quantity": 1}));
    //   cartBloc.cartEventSink.add(CartAction(
    //       event: CartEvent.addToCart,
    //       data: {"product": product2, "quantity": 2}));
    //   bool t = cartBloc.alreadyInCart(product1);
    //   expect(t, true);
    // });

    // test("when product is not in cart, return false", () async {
    //   //add to cart
    //   cartBloc.cartEventSink.add(CartAction(
    //       event: CartEvent.addToCart,
    //       data: {"product": product1, "quantity": 1}));
    //   cartBloc.cartEventSink.add(CartAction(
    //       event: CartEvent.addToCart,
    //       data: {"product": product2, "quantity": 2}));

    //   expect(cartBloc.alreadyInCart(product3), true);
    // });
  });
}
