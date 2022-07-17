import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({String? path, Map<String, dynamic>? data}) async {
    final refernce = FirebaseFirestore.instance.doc(path!);
    print('$path $data');
    await refernce.set(data!);
  }

  Stream<List<T>> collections<T>({
    required String path,
    required T Function(Map<String, dynamic>) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map(
          (snapshot) => builder(snapshot.data()),
        )
        .toList());
  }
}
