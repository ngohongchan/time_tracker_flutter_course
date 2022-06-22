import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter_course/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exeption_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
// import 'package:time_tracker_flutter_course/services/auth_provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(
        auth: auth,
      ),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (_, bloc, __) => SignInPage(
          bloc: bloc,
        ),
      ),
    );
  }

  // const SignInPage({Key? key, required this.auth}) : super(key: key);
  // final AuthBase auth;

  // bool _isLoading = false;

  void _signInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == "ERROR_ABORTED_BY_USER") {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void>? _signInAnonymonusly(BuildContext context) async {
    try {
      // final auth = Provider.of<AuthBase>(context, listen: false);
      final user = await bloc.signInAnonymonusly();
      print('flutter: ${user?.uid}');
    } on Exception catch (e) {
      print(e.toString());
      _signInError(context, e);
    }
  }

  Future<void>? _signInWithGoogle(BuildContext context) async {
    try {
      // final auth = Provider.of<AuthBase>(context, listen: false);
      await bloc.signInWithGoogle();
    } on Exception catch (e) {
      print(e.toString());
      _signInError(context, e);
    }
  }

  Future<void>? _signInWithFacebook(BuildContext context) async {
    try {
      // final auth = Provider.of<AuthBase>(context, listen: false);
      await bloc.signInWithFacebook();
    } on Exception catch (e) {
      print(e.toString());
      _signInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    // final auth = AuthProvider.of(context);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EmailSignInPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 10.0,
      ),
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) {
          return _buildContent(context, snapshot.data!);
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: _buildHeader(isLoading),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetsName: 'images/google-logo.png',
            color: Colors.white,
            text: 'Sign in with Google',
            textColor: Colors.black87,
            onPressed:
                isLoading ? null as dynamic : () => _signInWithGoogle(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetsName: 'images/facebook-logo.png',
            color: Color(0xFF334D92),
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            onPressed: isLoading
                ? null as dynamic
                : () => _signInWithFacebook(context),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign in with Email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed:
                isLoading ? null as dynamic : () => _signInWithEmail(context),
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
            onPressed: () => _signInAnonymonusly(context),
          ),
        ],
      ),
    );
  }
}
