/// Generic model for any "details" screen (coffee beans, cappuccino, ...).
/// One screen + one model = no duplicated UI per product type.
class ItemDetailsModel {
  final String name;
  final String subtitle; // e.g. "From Africa" or "With Steamed Milk"
  final String image;
  final double rating;
  final int ratingCount;
  final String description;
  final List<String> sizeLabels; // e.g. ["250gm","500gm","1000gm"] or ["S","M","L"]
  final Map<String, double> pricesBySize;
  final String roastLevel; // e.g. "Medium Roasted"

  const ItemDetailsModel({
    required this.name,
    required this.subtitle,
    required this.image,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.sizeLabels,
    required this.pricesBySize,
    this.roastLevel = 'Medium Roasted',
  });
}