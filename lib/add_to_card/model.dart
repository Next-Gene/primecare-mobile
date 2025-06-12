class CartItem {
  final String name;
  final String image;
  final int price;
  int count;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.count = 1,
  });

  int get totalPrice => price * count;
}
