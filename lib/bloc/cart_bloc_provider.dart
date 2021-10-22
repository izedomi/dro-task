import 'package:dro/bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';

class CartBlocProvider extends InheritedWidget {
  final CartBloc cartBloc;

  const CartBlocProvider(
      {required this.cartBloc, required Widget child, Key? key})
      : super(key: key, child: child);

  static CartBlocProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartBlocProvider>();
  }

  // @override
  // bool updateShouldNotify(covariant InheritedWidget oldWidget) {
  //   return true;
  // }
  @override
  bool updateShouldNotify(covariant CartBlocProvider oldWidget) {
    return cartBloc != oldWidget.cartBloc;
  }
}
