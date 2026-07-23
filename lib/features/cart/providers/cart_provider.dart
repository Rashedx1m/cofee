import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';

/// Shared cart state. Registered once in main.dart via MultiProvider,
/// then read/watched from ItemDetailsScreen (add) and CartScreen (display).
class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  double get totalPrice {
    double total = 0;
    for (final item in _items) {
      for (final entry in item.entries) {
        total += entry.price * entry.quantity;
      }
    }
    return total;
  }

  /// Adds one unit of [sizeLabel] for the product. If the same product +
  /// size already exists in the cart, its quantity is incremented instead
  /// of creating a duplicate row.
  void addItem({
    required String name,
    required String subtitle,
    required String image,
    required String sizeLabel,
    required double price,
  }) {
    final itemIndex = _items.indexWhere(
          (i) => i.name == name && i.subtitle == subtitle && i.image == image,
    );

    if (itemIndex == -1) {
      _items.add(
        CartItemModel(
          name: name,
          subtitle: subtitle,
          image: image,
          entries: [CartSizeEntry(label: sizeLabel, price: price)],
        ),
      );
    } else {
      final entries = _items[itemIndex].entries;
      final entryIndex = entries.indexWhere((e) => e.label == sizeLabel);
      if (entryIndex == -1) {
        entries.add(CartSizeEntry(label: sizeLabel, price: price));
      } else {
        entries[entryIndex].quantity += 1;
      }
    }
    notifyListeners();
  }

  void changeQuantity(CartSizeEntry entry, int delta) {
    final newQty = entry.quantity + delta;
    entry.quantity = newQty < 1 ? 1 : newQty;
    notifyListeners();
  }

  void removeEntry(CartItemModel item, CartSizeEntry entry) {
    item.entries.remove(entry);
    if (item.entries.isEmpty) _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
  /// Removes an entire product card (all its sizes), unlike [clear] which
  /// empties the whole cart.
  void removeItem(CartItemModel item) {
    _items.remove(item);
    notifyListeners();
  }
}