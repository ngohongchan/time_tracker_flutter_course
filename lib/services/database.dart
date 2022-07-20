import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';
import 'package:time_tracker_flutter_course/services/firestore_service.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Stream<List<Job?>> jobsStream();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FireStoreDatabase implements Database {
  FireStoreDatabase({required this.uid}) : assert(uid != null);
  final String uid;
  final String jobId = 'job_abc';

  final _service = FirestoreService.instance;

  @override
  Future<void> setJob(Job job) => _service.setData(
        path: APIPath.job(uid, documentIdFromCurrentDate()),
        data: job.toMap(),
      );

  @override
  Stream<List<Job?>> jobsStream() => _service.collections(
      path: APIPath.jobs(uid),
      builder: (data, documentId) => Job.fromMap(data, documentId!));
}

  //  @override
  // Stream<List<Job>> jobsStream() {
  //   final path = APIPath.jobs(uid);
  //   final reference = FirebaseFirestore.instance.collection(path);
  //   final snapshots = reference.snapshots();
  //   return snapshots.map((snapshot) => snapshot.docs.map((snapshot) {
  //         Map<String, dynamic> data = snapshot.data();
  //         return Job(
  //           name: data['name'],
  //           ratePerHour: data['ratePerHour'],
  //         );
  //       }).toList());

