import 'package:news_wave/all_imports.dart';

class GoogleServices {
  final auth = FirebaseAuth.instance;
  final googleLogin = GoogleSignIn();

  googleAuth() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleLogin.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential authCre = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await auth.signInWithCredential(authCre);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  logOut() async {
    await auth.signOut();
    await googleLogin.signOut();
  }
}