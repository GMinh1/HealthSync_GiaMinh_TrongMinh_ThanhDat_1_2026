import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'db_service.dart'; // Đã import để gọi tầng cơ sở dữ liệu

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser =
          await googleSignIn.signIn();

      if (googleUser == null) {
        print("User cancel login");
        return null;
      }

      print("Google User: ${googleUser.email}");

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result =
          await _auth.signInWithCredential(credential);

      print("Firebase User: ${result.user?.email}");

      // TỰ ĐỘNG ĐỒNG BỘ/LƯU THÔNG TIN CƠ BẢN VÀO FIRESTORE KHI ĐĂNG NHẬP THÀNH CÔNG
      final user = result.user;
      if (user != null) {
        await DatabaseService().saveUserProfile({
          'email': user.email,
          'name': user.displayName ?? 'Người dùng HealthSync',
          'photoUrl': user.photoURL ?? '',
        });
      }

      return result;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}