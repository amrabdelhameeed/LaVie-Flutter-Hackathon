class DetailedProduct {
  DetailedProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.waterCapacity,
    required this.sunLight,
    required this.temperature,
  });
  late final String id;
  late final String name;
  late final String description;
  late final int waterCapacity;
  late final int sunLight;
  late final int temperature;

  DetailedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    waterCapacity = json['waterCapacity'];
    sunLight = json['sunLight'];
    temperature = json['temperature'];
  }
}
