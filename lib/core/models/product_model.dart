class ProductModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final double price;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num).toDouble(), // ensures price is double
      imageUrl: json['image'] ?? '',
    );
  }
}
