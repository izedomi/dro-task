import 'package:dro/bloc/product/product_action.dart';
import 'package:dro/bloc/product/product_bloc.dart';
import 'package:dro/bloc/product/product_event.dart';
import 'package:dro/model/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when instance of ProductBloc is created, counter value is 1', () {
    ProductBloc _productBloc = ProductBloc();
    expect(_productBloc.getCounter(), 1);
  });

  test('when event is ProductEvent.increase, counter is incremented', () {
    ProductBloc _productBloc = ProductBloc();
    //initial counter value = 1

    _productBloc.productEventSink
        .add(ProductAction(event: ProductEvent.increase));

    expect(_productBloc.counterStream, emits(2));
  });

  test('when event is ProductEvent.decrease, counter is decremented', () {
    ProductBloc _productBloc = ProductBloc();

    //initial counter value = 1

    //counter increases to 2, after first increase event
    _productBloc.productEventSink
        .add(ProductAction(event: ProductEvent.increase));

    //counter increases to 3, after second increase event
    _productBloc.productEventSink
        .add(ProductAction(event: ProductEvent.increase));

    //counter decreases to 2, after decrease event
    _productBloc.productEventSink
        .add(ProductAction(event: ProductEvent.decrease));

    expect(_productBloc.counterStream, emits(2));
  });

  test(
      'when event is ProductEvent.decrease and counter is 1, counter remains 1',
      () {
    ProductBloc _productBloc = ProductBloc();
    //initial counter value = 1

    _productBloc.productEventSink
        .add(ProductAction(event: ProductEvent.decrease));

    expect(_productBloc.counterStream, emits(1));
  });

  test(
      'when event is ProductEvent.search and product is found, return filtered list of products containing query string',
      () async {
    ProductBloc _productBloc = ProductBloc();
    //initial counter value = 1

    _productBloc.productEventSink.add(
        ProductAction(event: ProductEvent.search, data: {"query": "parace"}));

    expect(_productBloc.filteredProductStream,
        emits(const TypeMatcher<List<Product>>()));
    expect((await _productBloc.filteredProductStream.first).length, 2);
  });

  test(
      'when event is ProductEvent.search and product does not exist, return empty list',
      () async {
    ProductBloc _productBloc = ProductBloc();

    _productBloc.productEventSink.add(
        ProductAction(event: ProductEvent.search, data: {"query": "zzzz"}));

    expect(_productBloc.filteredProductStream,
        emits(const TypeMatcher<List<Product>>()));
    expect((await _productBloc.filteredProductStream.first).length, 0);
  });
}
