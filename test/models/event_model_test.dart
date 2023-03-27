import 'package:flutter_test/flutter_test.dart';
import 'package:papai_models/models/drug_model.dart';
import 'package:papai_models/models/event_model.dart';
import 'package:papai_models/models/patient_record_model.dart';

void main() {
  final DateTime today = DateTime.now();
  final Map<String, dynamic> jsonEvent = {
    'id': 'firstID',
    'dateStart': today.toString(),
    'dateEnd':
        DateTime(today.year, today.month, today.day, today.hour + 3).toString(),
    'status': EventStatus.pending.name,
    'carerId': 'carerId',
    'elderId': 'elderId',
    'location': 'location',
    'earning': 500.4,
  };

  final event = Event.fromJson(jsonEvent);
  test('event model fromJson method ...', () {
    expect(event.id, jsonEvent['id']);
    expect(event.carerId, jsonEvent['carerId']);
    expect(event.elderId, jsonEvent['elderId']);
    expect(event.location, jsonEvent['location']);
    expect(event.dateStart.toString(), jsonEvent['dateStart']);
    expect(event.dateEnd.toString(), jsonEvent['dateEnd']);
    expect(event.status.name, jsonEvent['status']);
    final copyEvent = Event.fromJson(jsonEvent);
    expect(copyEvent == event, true);
  });
  test('event to Json', () {
    final Map<String, dynamic> newMap = event.toJson();

    expect(jsonEvent['dateStart'], newMap['dateStart'].toString());
    expect(jsonEvent['dateEnd'], newMap['dateEnd'].toString());
    expect(jsonEvent['carerId'], newMap['carerId']);
    expect(jsonEvent['elderId'], newMap['elderId']);
    expect(jsonEvent['location'], newMap['location']);
    expect(jsonEvent['status'], newMap['status'].toString());
  });
  test('event to String', () {
    expect(jsonEvent.toString(), event.toString());
  });
  test('event copyWith', () {
    final Event newEvent = event.copyWith(carerId: 'xxx');
    expect(newEvent.carerId == event.carerId, false);
    expect(newEvent.dateStart == event.dateStart, true);
  });
  test('event null eldery', () {
    final Event newEvent = Event(
        id: 'xxx',
        dateStart: today,
        dateEnd: today,
        status: EventStatus.free,
        carerId: 'carerId',
        elderId: null,
        location: null,
        earning: null);

    expect(newEvent.elderId, null);
    expect(newEvent.location, null);
    expect(newEvent.earning, null);
  });
  test('event to json and back to class', () {
    final eventMap = event.toJson();
    final newEvent = Event.fromJson(eventMap);
    expect(eventMap.toString(), newEvent.toString());
  });

  test('event with patientRecord copyWith', () {
    final newEvent = event.copyWith(patientRecord: patientWithHealthConditions);
    expect(newEvent.patientRecord.toString(),
        patientWithHealthConditions.toString());
  });
  test('event with patientRecord fromJson', () {
    final json = jsonEvent;
    json['patientRecord'] = elderRecord1.toJson();
    final newEvent = Event.fromJson(json);
    expect(newEvent.patientRecord.toString(), elderRecord1.toString());
    expect(newEvent.toString(), json.toString());
  });
  test('event with drugUsage toJson', () {
    final newEvent = event.copyWith(patientRecord: elderRecord2);
    final newJson = newEvent.toJson();
    expect(newJson['id'], jsonEvent['id']);
    expect(newJson['patientRecord'], elderRecord2.toJson());
  });
  test('event with drugUsage toJson and back fromJson', () {
    final newEvent = event.copyWith(patientRecord: elderRecord2);
    final newJson = newEvent.toJson();
    final fromJson = Event.fromJson(newJson);
    expect(fromJson.toString(), newEvent.toString());
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
