import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/home/job_entries/format.dart';

void main() {
  group('hours', () {
    test('positive', () {
      expect(Format.hours(10), '10h');
    });

    test('zezo', () {
      expect(Format.hours(0), '0h');
    });

    test('negative', () {
      expect(Format.hours(-5), '0h');
    });

    test('decimal', () {
      expect(Format.hours(4.5), '4.5h');
    });
  });

  group('date', () {
    test('2022-08-8', () {
      expect(Format.date(DateTime(2022, 8, 8)), 'Aug 8, 2022');
    });
  });
}
