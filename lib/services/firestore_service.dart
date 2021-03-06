import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({String? path, Map<String, dynamic>? data}) async {
    final refernce = FirebaseFirestore.instance.doc(path!);
    print('$path $data');
    await refernce.set(data!);
  }

  Future<void> deleteData({required String path}) async {
    final refernce = FirebaseFirestore.instance.doc(path);
    await refernce.delete();
  }

  Stream<List<T>> collections<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String? documentId) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map(
          (snapshot) => builder(snapshot.data(), snapshot.id),
        )
        .toList());
  }
}
