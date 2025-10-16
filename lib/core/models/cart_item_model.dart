import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  final Timestamp? createdAt;

  CartItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.createdAt,
  });

  factory CartItemModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartItemModel(
      id: data['id'] ?? doc.id,
      name: data['name'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (data['quantity'] as int?) ?? 0,
      imageUrl: data['imageUrl'] ?? '',
      createdAt: data['createdAt'] as Timestamp?,
    );
  }
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'price': price,
    'quantity': quantity,
    'imageUrl': imageUrl,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  };
  CartItemModel copyWith({int? quantity}) => CartItemModel(
    id: id,
    name: name,
    price: price,
    quantity: quantity ?? this.quantity,
    imageUrl: imageUrl,
    createdAt: createdAt,
  );
}
