import 'package:dro/bloc/product/product_event.dart';

class ProductAction {
  ProductEvent event;
  Map<String, dynamic>? data;

  ProductAction({required this.event, this.data});
}
