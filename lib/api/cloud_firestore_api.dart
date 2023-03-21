import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CloudFireStore {
  FirebaseFirestore get firebaseInstance;
}

class FireBaseCloudFireStoreAPI implements CloudFireStore {
  final _firebaseInstance = FirebaseFirestore.instance;
  @override
  FirebaseFirestore get firebaseInstance => _firebaseInstance;
}

class FakeFireBaseCloudFireStoreAPI implements CloudFireStore {
  final _firebaseInstance = FakeFirebaseFirestore();
  @override
  FirebaseFirestore get firebaseInstance => _firebaseInstance;
}
