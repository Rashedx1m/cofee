/// One size row inside a cart item (e.g. "S  $4.20  qty 1").
class CartSizeEntry {
  final String label;
  final double price;
  int quantity;

  CartSizeEntry({required this.label, required this.price, this.quantity = 0});
}

/// One product card in the cart (image + name + one or more [entries]).
class CartItemModel {
  final String name;
  final String subtitle;
  final String image;
  final List<CartSizeEntry> entries;

  CartItemModel({
    required this.name,
    required this.subtitle,
    required this.image,
    required this.entries,
  });
}
