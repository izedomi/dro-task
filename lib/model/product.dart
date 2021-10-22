class Product {
  String id;
  String name;
  String type;
  String image;
  String packSize;
  double price;
  bool requiresPrescription;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.type,
      required this.packSize,
      this.requiresPrescription = false});
}
