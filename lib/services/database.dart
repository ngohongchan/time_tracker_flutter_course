import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
  void readJobs();
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({required this.uid}) : assert(uid != null);
  final String uid;
  final String jobId = 'job_abc';

  @override
  Future<void> createJob(Job job) => _setData(
        path: APIPath.job(uid, jobId),
        data: job.toMap(),
      );

  Future<void> _setData({String? path, Map<String, dynamic>? data}) async {
    final refernce = FirebaseFirestore.instance.doc(path!);
    print('$path $data');
    await refernce.set(data!);
  }

  @override
  void readJobs() {
    final path = APIPath.jobs(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    snapshots.listen((snapshot) {
      snapshot.docs.forEach((snapshot) => print(snapshot.data()));
    });
  }
}
