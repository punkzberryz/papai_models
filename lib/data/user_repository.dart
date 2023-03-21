import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:papai_models/api/cloud_firestore_api.dart';
import 'package:papai_models/models/user_model.dart';

abstract class UserRepository {
  Future<Carer> getCarer({required String carerID});
  Future<void> addCarer(Carer carer);

  Future<void> editCarer(Carer carer);
  Future<void> addEventToCarer(Carer carer);
  Future<void> addManyEventsToCarer(Carer carer, List<String> eventIDs);
  Future<void> deleteEventFromCarer(Carer carer, String eventID);
  Future<Elder> getElder({required String elderID});
  Future<Elder> editElder(Elder elder);
}

class FirebaseCloudFireStoreUserRepository implements UserRepository {
  static String collectionCarer = 'Carer';
  static String collectionElder = 'Elder';
  final FirebaseFirestore _firestore;

  FirebaseCloudFireStoreUserRepository(this._firestore);

  @override
  Future<Carer> getCarer({required String carerID}) async {
    final snapshot =
        await _firestore.collection(collectionCarer).doc(carerID).get();
    final user = snapshot.data();
    return Carer.fromJson(user!);
  }

  @override
  Future<void> addCarer(Carer carer) async {
    await _firestore
        .collection(collectionCarer)
        .doc(carer.uid)
        .set(carer.toJson());
  }

  @override
  Future<void> editCarer(Carer carer) async {
    await _firestore
        .collection(collectionCarer)
        .doc(carer.uid)
        .update(carer.toJson());
  }

  @override
  Future<void> addEventToCarer(Carer carer) async {
    final newEventID = carer.eventIDs.last;
    await _firestore.collection(collectionCarer).doc(carer.uid).update({
      'eventIDs': FieldValue.arrayUnion([newEventID]),
    });
  }

  @override
  Future<void> addManyEventsToCarer(Carer carer, List<String> eventIDs) async {
    await _firestore.collection(collectionCarer).doc(carer.uid).update({
      'eventIDs': FieldValue.arrayUnion([...eventIDs]),
    });
  }

  @override
  Future<void> deleteEventFromCarer(Carer carer, String eventID) async {
    await _firestore.collection(collectionCarer).doc(carer.uid).update({
      'eventIDs': FieldValue.arrayRemove([eventID]),
    });
  }

  @override
  Future<Elder> getElder({required String elderID}) async {
    final snapshot =
        await _firestore.collection(collectionElder).doc(elderID).get();
    final user = snapshot.data();
    return Elder.fromJson(user!);
  }

  @override
  Future<Elder> editElder(Elder elder) {
    // TODO: implement editElder
    throw UnimplementedError();
  }
}

final userRepositoryProvider =
    Provider<FirebaseCloudFireStoreUserRepository>((ref) {
  return FirebaseCloudFireStoreUserRepository(
      FireBaseCloudFireStoreAPI().firebaseInstance);
});
