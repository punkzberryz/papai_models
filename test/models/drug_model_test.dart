import 'package:flutter_test/flutter_test.dart';
import 'package:papai_models/models/drug_model.dart';

void main() {
  final paraMap = {'name': 'para', 'shape': 'tablet'};

  test('test drug fromJson', () {
    final para = Drug.fromJson(paraMap);
    expect(para.name, paraMap['name']);
    expect(para.shape.name, paraMap['shape']);
    expect(para.toString(), paraMap.toString());
  });

  test('test drug toJson', () {
    final para = Drug.fromJson(paraMap);
    final paraJson = para.toJson();
    expect(para.name, paraJson['name']);
    expect(para.shape.name, paraJson['shape']);
    expect(para.toString(), paraJson.toString());
  });

  test('test drug toJson and back fromJson', () {
    final para = Drug.fromJson(paraMap);
    final paraJson = para.toJson();
    final newPara = Drug.fromJson(paraJson);
    expect(para.toString(), newPara.toString());
  });

  test('test drugUsage build', () {
    final para = Drug.fromJson(paraMap);
    final paraUsage = DrugUsage.build(
        para,
        '1',
        DrugUnit.pill,
        [DrugUsageTime.morning, DrugUsageTime.afternoon],
        'take every 4 hours per day');
    expect(para.toString(), paraUsage.drug.toString());
  });

  test('test drugUsage fromJson', () {
    Map<String, dynamic> paraUsageMap = {'dosage': 2.5};
    paraUsageMap['unit'] = 'pill';
    paraUsageMap['usageTime'] = ['evening'];
    paraUsageMap['comment'] = '';
    paraUsageMap['drug'] = paraMap;

    final paraUsage = DrugUsage.fromJson(paraUsageMap);
    expect(paraUsage.drug.toString(), paraMap.toString());
    expect(paraUsage.dosage, 2.5);
    expect(paraUsage.unit, DrugUnit.pill);
    expect(paraUsage.usageTime, [DrugUsageTime.evening]);
  });

  test('test drugUsage toJson', () {
    final paraUsage = DrugUsage(
        drug: Drug.fromJson(paraMap),
        dosage: 2.5,
        unit: DrugUnit.pill,
        usageTime: [DrugUsageTime.morning, DrugUsageTime.night],
        comment: 'this is a comment');
    final json = paraUsage.toJson();
    expect(json['drug'], paraUsage.drug.toJson());
    expect(json['dosage'], paraUsage.dosage);
    expect(json['unit'], paraUsage.unit.name);
    expect(json['usageTime'],
        paraUsage.usageTime.map((time) => time.name).toList());
    expect(json['comment'].runtimeType, String);
  });
  test('test drugUsage toJson and back fromJson', () {
    final paraUsage = DrugUsage(
        drug: Drug.fromJson(paraMap),
        dosage: 2.5,
        unit: DrugUnit.pill,
        usageTime: [DrugUsageTime.morning, DrugUsageTime.night],
        comment: 'this is a comment');
    final json = paraUsage.toJson();
    final newDrugUsage = DrugUsage.fromJson(json);
    expect(paraUsage.toString(), newDrugUsage.toString());
  });
}
