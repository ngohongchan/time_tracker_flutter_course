import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }
}

Widget _buildContent() {
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
        SignInButton(
          text: 'Sign in with Google',
          textColor: Colors.black87,
          color: Colors.white,
          onPressed: () {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        SignInButton(
          text: 'Sign in with Facebook',
          textColor: Colors.white,
          color: Color(0xFF334D92),
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
          onPressed: () {},
        ),
      ],
    ),
  );
}
