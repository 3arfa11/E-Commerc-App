class SavedItemModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;

  SavedItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory SavedItemModel.fromMap(Map<String, dynamic> data, String id) {
    return SavedItemModel(
      id: data['id'] ?? id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'price': price,
  };
}
