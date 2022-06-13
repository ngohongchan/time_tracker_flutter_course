abstract class StringValidtor {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidtor {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

mixin EmailAndPasswordValidators {
  final StringValidtor emailValidator = NonEmptyStringValidator();
  final StringValidtor passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = "Email can't be empty";
  final String invalidPasswordErrorText = "Password can't be empty";
}
