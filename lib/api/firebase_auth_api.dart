import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthAbstract {
  FirebaseAuth get firebaseInstance;
}

class FirebaseAuthAPI implements FirebaseAuthAbstract {
  final _firebaseInstance = FirebaseAuth.instance;
  @override
  FirebaseAuth get firebaseInstance => _firebaseInstance;
}

class FakeFirebaseAuthAPI implements FirebaseAuthAbstract {
  final _firebaseInstance = MockFirebaseAuth();
  @override
  FirebaseAuth get firebaseInstance => _firebaseInstance;
}
