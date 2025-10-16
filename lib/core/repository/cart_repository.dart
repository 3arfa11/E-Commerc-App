import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/models/cart_item_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CartRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> _cartRef() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('No authenticated user');
    return _firestore.collection('users').doc(uid).collection('cart');
  }

  // Add item (or increase quantity) atomically
  Future<void> addToCart({
    required String productId,
    required String name,
    required double price,
    String imageUrl = '',
    int quantity = 1,
  }) async {
    final docRef = _cartRef().doc(productId);

    await _firestore.runTransaction((tx) async {
      final snapshot = await tx.get(docRef);
      if (snapshot.exists) {
        // If exists, increment the quantity
        final currentQty = (snapshot.data()?['quantity'] as num?)?.toInt() ?? 0;
        final newQty = currentQty + quantity;
        tx.update(docRef, {
          'quantity': newQty,
          'updatedAt': FieldValue.serverTimestamp(),
          // optionally update price if you want to refresh price snapshot:
          // 'price': price,
        });
      } else {
        // create a new cart item document
        tx.set(docRef, {
          'id': productId,
          'name': name,
          'price': price,
          'quantity': quantity,
          'imageUrl': imageUrl,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  Future<void> removeFromCart(String productId) async {
    final docRef = _cartRef().doc(productId);
    await docRef.delete();
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final docRef = _cartRef().doc(productId);
    if (quantity <= 0) {
      await docRef.delete();
      return;
    }
    await docRef.update({
      'quantity': quantity,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Stream for listening in Cubit
  Stream<List<CartItemModel>> cartStream() {
    return _cartRef().snapshots().map(
      (snap) => snap.docs.map((d) => CartItemModel.fromDoc(d)).toList(),
    );
  }

  // Clear cart (batched delete)
  Future<void> clearCart() async {
    final batch = _firestore.batch();
    final snapshot = await _cartRef().get();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
