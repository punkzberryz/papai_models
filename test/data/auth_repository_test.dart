import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papai_models/data/auth_repository.dart';

void main() async {
  final bob = MockUser(
    isAnonymous: false,
    uid: userUID,
    email: userEmail,
    displayName: userDisplayName,
  );

  final authRepositoryProvider = Provider<FirebaseAuthRepository>((ref) {
    final auth = FirebaseAuthRepository(MockFirebaseAuth(
      mockUser: bob,
    ));
    ref.onDispose(() => auth.dispose());
    return auth;
  });

  final container = ProviderContainer(overrides: []);
  final authRepository = container.read(authRepositoryProvider);

  test('FirebaseAuthRepository ... signInWithEmailAndPassword', () async {
    final id = await authRepository.signInWithEmailAndPassword(
        email: userEmail, password: 'password');
    expect(userUID, id);
  });
  test('FirebaseAuthRepository ... signUpWithEmailAndPassword', () async {
    final id = await authRepository.signUpWithEmailAndPassword(
        email: 'bob2@gmail.com', displayName: 'bob2', password: 'password');
    final id2 = await authRepository.signInWithEmailAndPassword(
        email: 'bob2@gmail.com', password: 'password');
    expect(id, id2);
  });

  test('FirebaseAuthRepository ... signOut', () async {
    await authRepository.signOut();
  });
  // test('FirebaseAuthRepository ... setUserState', () async {
  //   final id = await authRepository.signUpWithEmailAndPassword(
  //       email: 'bob2@gmail.com', displayName: 'bob2', password: 'password');
  //   final id2 = await authRepository.signInWithEmailAndPassword(
  //       email: 'bob2@gmail.com', password: 'password');
  //   expect(id, id2);
  //   final bob = Carer(
  //     uid: userUID,
  //     displayName: userDisplayName,
  //     email: userEmail,
  //     eventIDs: [],
  //   );
  // });
}

const String userEmail = 'bob@somedomain.com';
const String userDisplayName = 'Bob';
final String userUID = (userEmail + userDisplayName).hashCode.toString();
