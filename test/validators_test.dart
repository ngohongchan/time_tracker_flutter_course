// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';

void main() {
  test('none empty string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('test'), true);
  });

  test('empty string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(''), false);
  });

  test('null string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(null as dynamic), false);
  });
}
