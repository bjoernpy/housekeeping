import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServiceAbstract {
  Future<User> signInWithEmail(String email, String password);
  Future<User> singInWithGoogle();
  Future<void> registerWithEmail(String email, String password);
  Future<void> registerWithGoogle();
  Future<void> createUser(String firstName, String lastName);
  Future<void> signOut();
}

class AuthService extends AuthServiceAbstract {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  Future<User> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("User signed in as: ${userCredential.user.displayName}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ("user-not-found");
      }
      if (e.code == 'wrong-password') {
        throw ("wrong-password");
      }
    } catch (error) {
      print(error);
      return null;
    }

    return null;
  }

  @override
  Future<User> singInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("User signed in as: ${userCredential.user.displayName}");
      return userCredential.user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Future<void> registerWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw e;
          break;
        case 'weak-password':
          throw e;
          break;
        default:
          print(e);
      }
    }
  }

  @override
  Future<void> registerWithGoogle() async {
    try {
      await this.singInWithGoogle();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> createUser(String firstName, String lastName) async {
    User user = _auth.currentUser;
    try {
      await users.doc(user.uid).set({
        "firstName": firstName,
        "lastName": lastName,
        "email": user.email,
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final AuthService authService = AuthService();
