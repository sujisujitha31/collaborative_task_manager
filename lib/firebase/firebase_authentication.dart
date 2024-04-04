import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  Future createNewUser(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e;
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
