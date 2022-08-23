import 'package:equatable/equatable.dart';
import 'package:la_vie/core/app_strings.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  late final String name;
  late final String description;
  late final String type;
  late final num price;
  late final String id;
  late final String imageUrl;
  int? quantity;
  Product(
      {required this.name,
      required this.description,
      required this.type,
      required this.price,
      required this.id,
      required this.imageUrl,
      this.quantity = 1});
  Product.fromJson(Map<String, dynamic> map) {
    type = map['type'];
    price = map['price'];
    quantity = 1;
    imageUrl = '${ApiStrings.baseUrlForImage}${map['imageUrl']}';
    description = map['description'];
    if (type == 'PLANT') {
      _itemSetter('plant', map);
    }
    if (type == 'SEED') {
      _itemSetter('seed', map);
    }
    if (type == 'TOOL') {
      _itemSetter('tool', map);
    }
  }
  _itemSetter(String type, Map<String, dynamic> map) {
    id = map[type]['${type}Id'];
    name = map[type]['name'];
    // description = map[name]['description'] ?? '';
  }

  void addOrRemoveFromQuantity(bool isAdding) {
    if (isAdding) {
      quantity = quantity! + 1;
    } else {
      // avoid 0 or negative quantity
      if (quantity! > 1) {
        quantity = quantity! - 1;
      }
    }
  }

  @override
  List<Object?> get props =>
      [id, quantity, imageUrl, name, description, type, price];
}
