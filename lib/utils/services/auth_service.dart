import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Fetch user data (if needed)
  Future<String?> fetchUserData(String uid) async {
    // You can fetch user data from Firestore or another source here
    // For example:
    if (uid.isNotEmpty) {
      // Simulate fetching user data
      return Future.value('User data for $uid');
    }
    return null;
  }
}
