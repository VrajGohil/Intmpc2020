import 'package:firebase/firebase.dart' as fb;
import 'package:meta/meta.dart';

@immutable
class MyFirebaseAuth {
  MyFirebaseAuth({fb.Auth firebaseAuth, fb.GoogleAuthProvider googleSignin})
      : _firebaseAuth = firebaseAuth ?? fb.auth(),
        _googleSignIn = googleSignin ?? fb.GoogleAuthProvider();

  final fb.Auth _firebaseAuth;
  final fb.GoogleAuthProvider _googleSignIn;

  Future<fb.UserCredential> signInWithGoogle() async {
    try {
      return await _firebaseAuth.signInWithPopup(_googleSignIn);
    } catch (e) {
      print('Error in sign in with google: $e');
      throw '$e';
    }
  }

  Future<fb.UserCredential> signInWithCredentials(
      String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email, password);
    } catch (e) {
      print('Error in sign in with credentials: $e');
      // return e;
      throw '$e';
    }
  }

  Future<fb.UserCredential> signUp({String email, String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email,
        password,
      );
    } catch (e) {
      print('Error siging in with credentials: $e');
      throw '$e';
      // throw Error('Error signing up with credentials: $e');
      // return e;
    }
  }

  Future<dynamic> signOut() async {
    try {
      return Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (e) {
      print ('Error signin out: $e');
      // return e;
      throw '$e';
    }
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (_firebaseAuth.currentUser).email;
  }
}