import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FiraAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;


  Future<User?> currentUser() async {
    await auth.currentUser!.reload();
    return auth.currentUser;
  }
  Stream<User?> retrieveCurrentUserStream() {
    return auth.authStateChanges().map((User? user) {
      if (user != null) {
        return user;
      } else {
        return null;
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
