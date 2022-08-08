import 'package:time_tracker_flutter_course/app/home/models/entry.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';

class EntryJob {
  EntryJob({required this.entry, required this.job});

  final Entry entry;
  final Job job;
}
