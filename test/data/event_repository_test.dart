import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:papai_models/data/event_repository.dart';
import 'package:papai_models/models/drug_model.dart';
import 'package:papai_models/models/event_model.dart';
import 'package:papai_models/models/patient_record_model.dart';

void main() {
  final today = DateTime.now();
  final fakeEventRepositoryProvider =
      Provider<FirebaseCloudFireStoreEventRepository>((ref) {
    return FirebaseCloudFireStoreEventRepository(FakeFirebaseFirestore());
  });
  final container = ProviderContainer(overrides: []);
  final fakeEventRepository = container.read(fakeEventRepositoryProvider);

  final Event firstEvent = Event(
      id: 'firstfakeID',
      dateStart: today,
      dateEnd: today,
      status: EventStatus.pending,
      carerId: 'carerId1',
      elderId: 'elderId',
      location: 'location',
      earning: 300);
  final Event secondEvent = Event(
      id: 'secondfakeID',
      dateStart: today,
      dateEnd: today,
      status: EventStatus.free,
      carerId: 'carerId2',
      elderId: null,
      location: null,
      earning: null);
  final Event thirdEvent = Event(
      id: 'thirdfakeID',
      dateStart: today,
      dateEnd: today,
      status: EventStatus.booked,
      carerId: 'carerId1',
      elderId: 'elderId1',
      location: 'nowhere',
      earning: 3.5);
  test('event repository ...post new event', () async {
    await fakeEventRepository.postNewEvent(event: firstEvent);
    await fakeEventRepository.postNewEvent(event: secondEvent);
  });

  test('event repository ...get event', () async {
    final eventID = await fakeEventRepository.postNewEvent(event: thirdEvent);
    final newEvent = await fakeEventRepository.getEvent(eventID: eventID);
    final updatedThirdEvent = thirdEvent.copyWith(id: eventID);
    expect(newEvent.toString(), updatedThirdEvent.toString());
  });
  test('event repository ...getAllEventsFromCarerID', () async {
    final events =
        await fakeEventRepository.getAllEventsFromCarerID(carerID: 'carerId1');
    final updatedFirstEvent = firstEvent.copyWith(id: events.first.id);
    final updatedThirdEvent = thirdEvent.copyWith(id: events.last.id);
    expect(events.first.toString(), updatedFirstEvent.toString());
    expect(events.last.toString(), updatedThirdEvent.toString());
  });
  test('event repository ...getAllEventsFromEventIDs', () async {
    final events =
        await fakeEventRepository.getAllEventsFromCarerID(carerID: 'carerId1');
    final eventIDs = events.map((event) => event.id).toList();
    final newEvents =
        await fakeEventRepository.getAllEventsFromEventIDs(eventIDs: eventIDs);
    expect(events.toString(), newEvents.toString());
  });

  test('event repository ...editEvent', () async {
    final id = await fakeEventRepository.postNewEvent(
        event: thirdEvent.copyWith(carerId: 'carer3'));
    var event4 = await fakeEventRepository.getEvent(eventID: id);

    event4 = event4.copyWith(patientRecord: elderRecord1);
    await fakeEventRepository.editEvent(event: event4);
    final updatedEvent = await fakeEventRepository.getEvent(eventID: id);
    expect(event4.toString(), updatedEvent.toString());
  });

  test('event repository ...deleteEvent', () async {
    final events =
        await fakeEventRepository.getAllEventsFromCarerID(carerID: 'carerId1');
    await fakeEventRepository.deleteEvent(eventID: events.first.id);
    final updatedEvents =
        await fakeEventRepository.getAllEventsFromCarerID(carerID: 'carerId1');
    expect(events.length - 1, updatedEvents.length);
  });
}

const paraUsage = DrugUsage(
    drug: Drug(name: 'para', shape: DrugShape.tablet),
    dosage: 2.5,
    unit: DrugUnit.pill,
    usageTime: [DrugUsageTime.morning, DrugUsageTime.night],
    comment: 'this is a comment');
const drowsyLiquidUsage = DrugUsage(
    drug: Drug(name: 'drowsy', shape: DrugShape.liquid),
    dosage: 2.5,
    unit: DrugUnit.spoon,
    usageTime: [DrugUsageTime.night],
    comment: 'adult only');
const chronicConditions1 = ['Heart disease', 'diabetes'];
const chronicConditions2 = ['obese'];

const simplePatient =
    PatientRecord(height: 180.4, weight: 60.3, age: 65, bloodPressure: 200);
const patientWithDrugsUsage = PatientRecord(
    height: 180.4,
    weight: 60.3,
    age: 65,
    bloodPressure: 200,
    drugsUsage: [drowsyLiquidUsage]);
const patientWithHealthConditions = PatientRecord(
    height: 180.4,
    weight: 60.3,
    age: 65,
    bloodPressure: 200,
    chronicHealthConditions: chronicConditions1);
const elderRecord1 = PatientRecord(
    height: 180.4,
    weight: 60.3,
    age: 65,
    bloodPressure: 200,
    chronicHealthConditions: chronicConditions1,
    drugsUsage: [paraUsage]);
const elderRecord2 = PatientRecord(
  height: 150,
  weight: 60,
  age: 60,
  bloodPressure: 170,
  chronicHealthConditions: chronicConditions2,
  drugsUsage: [paraUsage, drowsyLiquidUsage],
);
