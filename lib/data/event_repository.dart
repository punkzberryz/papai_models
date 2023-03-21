import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:papai_models/api/cloud_firestore_api.dart';
import 'package:papai_models/models/event_model.dart';

abstract class EventRepository {
  Future<Event> getEvent({required String eventID});
  Future<List<Event>> getAllEventsFromCarerID({required String carerID});
  Stream<List<Event>> getAllEventsStreamFromCarerID({required String carerID});
  Stream<List<Event>> getAllEventsStreamFromEventIDs(
      {required List<String?> eventIDs});
  Future<List<Event>> getAllEventsFromEventIDs(
      {required List<String?> eventIDs});
  Future<String> postNewEvent({required Event event});
  Future<List<Event>> postManyEvents({required List<Event> events});
  Future<void> editEvent({required Event event});
  Future<void> deleteEvent({required String eventID});
}

class FirebaseCloudFireStoreEventRepository implements EventRepository {
  static String collection = 'Event';
  final FirebaseFirestore _firestore;

  //TODO: add async try-catch

  FirebaseCloudFireStoreEventRepository(this._firestore);

  @override
  Future<Event> getEvent({required String eventID}) async {
    try {
      final eventDocumentSnapshot =
          await _firestore.collection(collection).doc(eventID).get();
      final eventMap = eventDocumentSnapshot.data();
      return Event.fromJson(eventMap!);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Event>> getAllEventsFromCarerID({required String carerID}) async {
    List<Event> events = [];
    final snapshot = await _firestore
        .collection(collection)
        .where("carerId", isEqualTo: carerID)
        .get();

    for (final doc in snapshot.docs) {
      events.add(Event.fromJson(doc.data()));
    }
    return events;
  }

  @override
  Future<List<Event>> getAllEventsFromEventIDs(
      {required List<String?> eventIDs}) async {
    List<Event> events = [];
    if (eventIDs.isEmpty) {
      return events;
    }
    // final snapshot = await _firestore
    //     .collection(collection)
    //     .where('_id', whereIn: eventIDs)
    //     .get();
    // for (final doc in snapshot.docs) {
    //   final eventMap = doc.data();
    //   events.add(Event.fromJson(eventMap));
    // }

    for (final id in eventIDs) {
      final snapshot = await _firestore.collection(collection).doc(id).get();
      final eventMap = snapshot.data();
      events.add(Event.fromJson(eventMap!));
    }

    return events;
  }

  @override
  Future<String> postNewEvent({required Event event}) async {
    final newDoc = _firestore.collection(collection).doc();
    final newID = newDoc.id;
    final updatedEvent = event.copyWith(id: newID);

    await _firestore
        .collection(collection)
        .doc(newID)
        .set(updatedEvent.toJson());

    return newID;
  }

  @override
  Future<List<Event>> postManyEvents({required List<Event> events}) async {
    final batch = _firestore.batch();
    List<Event> newEvents = [];
    for (Event event in events) {
      final docRef = _firestore.collection(collection).doc();
      final newEvent = event.copyWith(id: docRef.id);
      batch.set(docRef, newEvent.toJson());
      newEvents.add(newEvent);
    }
    await batch.commit();
    return newEvents;
  }

  @override
  Future<void> editEvent({required Event event}) async {
    await _firestore
        .collection(collection)
        .doc(event.id)
        .update(event.toJson());
  }

  @override
  Future<void> deleteEvent({required String eventID}) async {
    await _firestore.collection(collection).doc(eventID).delete();
  }

  @override
  Stream<List<Event>> getAllEventsStreamFromCarerID(
          {required String carerID}) =>
      _firestore
          .collection(collection)
          .where('carerId', isEqualTo: carerID)
          .snapshots()
          .map((eventsQuery) => eventsQuery.docs
              .map((doc) => Event.fromJson(doc.data()))
              .toList());
  @override
  Stream<List<Event>> getAllEventsStreamFromEventIDs(
          {required List<String?> eventIDs}) =>
      _firestore
          .collection(collection)
          .where('_id', whereIn: eventIDs)
          .snapshots()
          .map((eventsQuery) => eventsQuery.docs
              .map((doc) => Event.fromJson(doc.data()))
              .toList());
}

final eventRepositoryProvider =
    Provider<FirebaseCloudFireStoreEventRepository>((ref) {
  return FirebaseCloudFireStoreEventRepository(
      FireBaseCloudFireStoreAPI().firebaseInstance);
});
