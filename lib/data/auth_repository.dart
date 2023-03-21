import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:papai_models/api/firebase_auth_api.dart';
import 'package:papai_models/models/user_model.dart';

abstract class AuthRepository {
  Stream<Carer?> authStateChanges();
  Future<String> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<String> signUpWithEmailAndPassword(
      {required String email,
      required String displayName,
      required String password});
  void setUserState(Carer? user);
  Future<void> signOut();
  void dispose();
}

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth) {
    _authStateController.add(null);
  }
  final FirebaseAuth _auth;

  final _authStateController = StreamController<Carer?>();

  @override
  Stream<Carer?> authStateChanges() => _authStateController.stream;

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String displayName,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void setUserState(Carer? user) {
    _authStateController.add(user);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  void dispose() => _authStateController.close();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = FirebaseAuthRepository(FirebaseAuthAPI().firebaseInstance);
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangesProvider = StreamProvider<Carer?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
