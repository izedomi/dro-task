import 'package:dro/model/product.dart';

List<Product> products = [
  Product(
      id: "1",
      name: "Paracetamol",
      price: 350.00,
      type: "Tablet",
      image: "assets/images/paracetamol.png",
      packSize: "500mg"),
  Product(
      id: "2",
      name: "Doliprane",
      price: 350.00,
      type: "Capsule",
      image: "assets/images/doliprane.png",
      packSize: "1000mg",
      requiresPrescription: true),
  Product(
      id: "3",
      name: "Paracetamol",
      price: 350.00,
      type: "Tablet",
      image: "assets/images/paracetamol_1.png",
      packSize: "500mg",
      requiresPrescription: true),
  Product(
      id: "4",
      name: "Ibuprofen",
      price: 350.00,
      type: "Tablet",
      image: "assets/images/ibuprofen.png",
      packSize: "500mg"),
  Product(
    id: "5",
    name: "Panadol",
    price: 500.00,
    type: "Tablet",
    image: "assets/images/panadol.png",
    packSize: "500mg",
  ),
  Product(
    id: "6",
    name: "Ibuprofen",
    price: 500.00,
    type: "Tablet",
    image: "assets/images/ibuprofen_1.png",
    packSize: "400mg",
  ),
];
