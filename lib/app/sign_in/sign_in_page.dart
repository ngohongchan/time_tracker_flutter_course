import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter_course/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth, required this.onSignIn})
      : super(key: key);
  final AuthBase auth;
  final void Function(User? user) onSignIn;

  Future<void> _signInAnonymonusly() async {
    try {
      final user = await auth.signInAnonymonusly();
      onSignIn(user);
      print('flutter: ${user?.uid}');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
      ),
      body: _buildContent(_signInAnonymonusly),
      backgroundColor: Colors.grey[200],
    );
  }
}

Widget _buildContent(signInAnonymonusly) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Sign In',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        SocialSignInButton(
          assetsName: 'images/google-logo.png',
          color: Colors.white,
          text: 'Sign in with Google',
          textColor: Colors.black87,
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        SocialSignInButton(
          assetsName: 'images/facebook-logo.png',
          color: Color(0xFF334D92),
          text: 'Sign in with Facebook',
          textColor: Colors.white,
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        SignInButton(
          text: 'Sign in with Email',
          textColor: Colors.white,
          color: Colors.teal[700],
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          'or',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8.0,
        ),
        SignInButton(
          text: 'Go anonymous',
          textColor: Colors.black,
          color: Colors.lime[300],
          onPressed: signInAnonymonusly,
        ),
      ],
    ),
  );
}
