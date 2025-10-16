import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce/core/models/saved_item_model.dart';

class SavedRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  SavedRepository({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> _savedRef() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw StateError('No authenticated user');
    return _firestore.collection('users').doc(uid).collection('saved');
  }

  Future<void> saveItem({
    required String id,
    required String name,
    required double price,
    String imageUrl = '',
  }) async {
    await _savedRef().doc(id).set({
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> removeSaved(String id) async {
    await _savedRef().doc(id).delete();
  }

  Stream<List<SavedItemModel>> savedStream() {
    return _savedRef().snapshots().map(
      (snap) =>
          snap.docs.map((d) => SavedItemModel.fromMap(d.data(), d.id)).toList(),
    );
  }

  Future<bool> isSaved(String id) async {
    final doc = await _savedRef().doc(id).get();
    return doc.exists;
  }
}
