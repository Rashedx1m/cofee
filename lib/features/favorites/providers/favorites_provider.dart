import 'package:flutter/material.dart';
import '../../item_details/models/item_details_model.dart';

/// Shared favorites state. Registered once in main.dart via MultiProvider,
/// then read/watched from ItemDetailsScreen (toggle) and FavoritesScreen (list).
class FavoritesProvider extends ChangeNotifier {
  final List<ItemDetailsModel> _items = [];

  List<ItemDetailsModel> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  bool _sameItem(ItemDetailsModel a, ItemDetailsModel b) =>
      a.name == b.name && a.subtitle == b.subtitle && a.image == b.image;

  bool isFavorite(ItemDetailsModel item) =>
      _items.any((i) => _sameItem(i, item));

  void toggle(ItemDetailsModel item) {
    if (isFavorite(item)) {
      _items.removeWhere((i) => _sameItem(i, item));
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void remove(ItemDetailsModel item) {
    _items.removeWhere((i) => _sameItem(i, item));
    notifyListeners();
  }
}