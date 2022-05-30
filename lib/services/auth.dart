import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login_web/flutter_facebook_login_web.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<User?> signInAnonymonusly();
  Future<User?> signInWithGoogle();
  Future<User?> signInWithFacebook();
  Future<User?> signInWithEmailAndPasswors(String email, String password);
  Future<User?> createWithEmailAndPasswors(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<User?> signInAnonymonusly() async {
    try {
      final userCredential = await _firebaseAuth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    try {
      final googleSignIn = GoogleSignIn();
      final facebookLogin = FacebookLoginWeb();
      await facebookLogin.logOut();
      await googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<User?> signInWithEmailAndPasswors(
      String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );

    return userCredential.user;
  }

  @override
  Future<User?> createWithEmailAndPasswors(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  }

  @override
  Future<User?> signInWithFacebook() async {
    final fb = FacebookLoginWeb();
    final response = await fb.logIn(['email']);
    switch (response.status) {
      case FacebookLoginStatus.loggedIn:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token));
        return userCredential.user;
      case FacebookLoginStatus.cancelledByUser:
        throw FirebaseException(
          plugin: '',
          code: 'ERROR_ABORTED_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseException(
            plugin: '',
            code: 'ERROR_FACEBOOK_LOGIN_FAILED',
            message: response.errorMessage);
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    final googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );

        return userCredential.user;
      } else {
        throw FirebaseException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google Id Token',
          plugin: '',
        );
      }
    } else {
      throw FirebaseException(
        code: 'ERROR_ABORTED_USER',
        message: 'Sign in aborted by user',
        plugin: '',
      );
    }
  }
}
