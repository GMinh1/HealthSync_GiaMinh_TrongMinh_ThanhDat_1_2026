import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
          await FirebaseAuth.instance.signInWithCredential(credential);

      print("Firebase User: ${result.user?.email}");

      return result;
    } catch (e) {
      print("LOGIN ERROR: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}