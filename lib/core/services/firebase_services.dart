import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  String printCurrentUserEmail() {
    final User? user = _auth.currentUser;
    if (user != null) {
      return user.email ?? 'No Email';
    } else {
      return 'No user is logged in';
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String username,
    String phoneNumber,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'phoneNumber': phoneNumber,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      print("❌ Error: ${e.message}");
    }
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data() as Map<String, dynamic>;
        return data;
        print('=====================');
        print(data['username']);
        print('=====================');
      } else {
        print("No user data found");
        return null;
      }
    } else {
      print("No user is logged in");
      return null;
    }
  }

  Future<String> getUsername() async {
    String username = await getUserInfo().then(
      (data) => data?['username'] ?? 'No Username',
    );
    print(username);
    return username;
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return "An unknown error occurred";
    }
  }
}
