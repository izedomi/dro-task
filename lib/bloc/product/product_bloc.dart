import 'dart:async';
import 'package:dro/bloc/product/product_action.dart';
import 'package:dro/bloc/product/product_event.dart';
import 'package:dro/model/product.dart';
import 'package:dro/utility/data/prouct_list.dart';

class ProductBloc {
  int _counter = 1;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  final _filteredProductController =
      StreamController<List<Product>>.broadcast();

  StreamSink<List<Product>> get _filteredProductSink =>
      _filteredProductController.sink;
  Stream<List<Product>> get filteredProductStream =>
      _filteredProductController.stream;

  final _counterController = StreamController<int>.broadcast();

  StreamSink<int> get _counterSink => _counterController.sink;
  Stream<int> get counterStream => _counterController.stream;

  final _productEventController = StreamController<ProductAction>();
  Sink<ProductAction> get productEventSink => _productEventController.sink;

  ProductBloc() {
    _products = List.from(products);
    _productEventController.stream.listen(_mapEventToState);
  }

  int getCounter() {
    return _counter;
  }

  void _mapEventToState(ProductAction productAction) {
    if (productAction.event == ProductEvent.search) {
      if (productAction.data != null &&
          productAction.data!.containsKey("query")) {
        String query = productAction.data!["query"];

        _filteredProducts = [];

        for (var product in _products) {
          if (product.name.toLowerCase().contains(query.toLowerCase())) {
            _filteredProducts.add(product);
          }
        }

        _filteredProductSink.add(_filteredProducts);
      }
    }
    if (productAction.event == ProductEvent.increase) {
      _counter++;
      _counterSink.add(_counter);
    }
    if (productAction.event == ProductEvent.decrease) {
      if (_counter > 1) {
        _counter--;
      }
      _counterSink.add(_counter);
    }
  }

  void disclose() {
    _filteredProductController.close();
    _counterController.close();
    _productEventController.close();
  }
}
