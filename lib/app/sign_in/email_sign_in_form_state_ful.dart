import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_model.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';
import 'package:time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exeption_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/auth_provider.dart';

class EmailSignInFormStateful extends StatefulWidget
    with EmailAndPasswordValidators {
  // EmailSignInForm({Key? key, required this.auth}) : super(key: key);
  // final AuthBase auth;

  @override
  _EmailSignInFormStatefulState createState() =>
      _EmailSignInFormStatefulState();
}

class _EmailSignInFormStatefulState extends State<EmailSignInFormStateful> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  bool _submitted = false;
  bool _isLoading = false;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  _updateState() {
    setState(() {});
  }

  Future<void> _submit() async {
    print('submit called');
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await Future.delayed(Duration(seconds: 3));
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPasswors(_email, _password);
      } else {
        await auth.createWithEmailAndPasswors(_email, _password);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);

    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        enabled: _isLoading == false,
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
      ),
      autocorrect: false,
      onChanged: (password) => _updateState(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
    );
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);

    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        enabled: _isLoading == false,
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
      ),
      obscureText: true,
      onChanged: (email) => _updateState(),
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
    );
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'create an account';
    final secondaryText = _formType == EmailSignInFormType.register
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 15.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(
        height: 15.0,
      ),
      FlatButton(
        onPressed: !_isLoading ? _toggleFormType : null,
        child: Text(secondaryText),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }
}
