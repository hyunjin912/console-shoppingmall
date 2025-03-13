class Product {
  String name;
  int price;

  Product({required this.name, required this.price});

  @override
  String toString() {
    return 'Product {name: $name, price: $price}';
  }
}
