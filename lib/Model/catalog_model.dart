class CatalogModel {
  final int id;
  final String name, title, description;
  final List<String> type, image;
  final int minSi, maxSi;
  final num price;
  final DateTime eventStartDate, eventEndDate;
  final bool isAvailable;
  int quantity;

  CatalogModel({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.type,
    required this.image,
    required this.minSi,
    required this.maxSi,
    required this.price,
    required this.eventStartDate,
    required this.eventEndDate,
    this.isAvailable = true,
    this.quantity = 1,
  });

  factory CatalogModel.fromMap(Map<String, dynamic> map) {
    return CatalogModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      type: List<String>.from(map['type'] ?? []),
      image: List<String>.from(map['image'] ?? []),
      minSi: map['minSi'] ?? 0,
      maxSi: map['maxSi'] ?? 0,
      price: map['price'] ?? 0,
      eventStartDate: DateTime.parse(map['eventStartDate'] ?? DateTime.now().toString()),
      eventEndDate: DateTime.parse(map['eventEndDate'] ?? DateTime.now().toString()),
      isAvailable: map['isAvailable'] ?? true,
    );
  }
}
