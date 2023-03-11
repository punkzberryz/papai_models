import 'package:flutter_test/flutter_test.dart';
import 'package:papai_models/models/drug_model.dart';
import 'package:papai_models/models/patient_record_model.dart';

void main() {
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

  test('patient record model ...copyWith', () {
    final newRecord = simplePatient.copyWith(drugsUsage: [paraUsage]);
    expect(newRecord.drugsUsage!.first.toString(), paraUsage.toString());
  });
  test('patient record model ...toJson', () {
    final json = elderRecord1.toJson();
    expect(json.toString(), elderRecord1.toString());
  });

  test('patient record model ...fromJson', () {
    final fromSimplePatient = PatientRecord.fromJson(simplePatient.toJson());
    expect(fromSimplePatient.age, 65);
    expect(fromSimplePatient.drugsUsage, null);
    final fromPatientWithDrugsUsage =
        PatientRecord.fromJson(patientWithDrugsUsage.toJson());
    expect(fromPatientWithDrugsUsage.drugsUsage != null, true);
    expect(fromPatientWithDrugsUsage.chronicHealthConditions == null, true);
    expect(fromPatientWithDrugsUsage.drugsUsage!.first.toString(),
        patientWithDrugsUsage.drugsUsage!.first.toString());

    final fromPatientWithHealthConditions =
        PatientRecord.fromJson(patientWithHealthConditions.toJson());
    expect(fromPatientWithHealthConditions.drugsUsage == null, true);
    expect(
        fromPatientWithHealthConditions.chronicHealthConditions != null, true);
    expect(fromPatientWithHealthConditions.chronicHealthConditions!.toString(),
        patientWithHealthConditions.chronicHealthConditions!.toString());

    final fromElderRecord2 = PatientRecord.fromJson(elderRecord2.toJson());
    expect(fromElderRecord2.toString(), elderRecord2.toString());
  });

  // test('patient record model ...', () {});
  // test('patient record model ...', () {});
  // test('patient record model ...', () {});
  // test('patient record model ...', () {});
  // test('patient record model ...', () {});
  // test('patient record model ...', () {});
}
