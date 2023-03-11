import 'package:papai_models/models/drug_model.dart';

class PatientRecord {
  const PatientRecord({
    required this.height,
    required this.weight,
    required this.age,
    required this.bloodPressure,
    this.chronicHealthConditions,
    this.drugsUsage,
  });

  final double height;
  final double weight;
  final int age;
  final double bloodPressure;
  final List<String>? chronicHealthConditions;
  final List<DrugUsage>? drugsUsage;

  factory PatientRecord.fromJson(Map<String, dynamic> json) {
    PatientRecordBuilder builder = PatientRecordBuilder(
      height: _doubleParser(json['height']),
      weight: _doubleParser(json['weight']),
      age: _intParser(json['age']),
      bloodPressure: _doubleParser(json['bloodPressure']),
    );
    if (json['chronicHealthConditions'] != null) {
      List<String> conditions = [];
      for (final condition in json['chronicHealthConditions']) {
        conditions.add(condition);
      }
      builder.chronicHealthConditions = conditions;
    }
    if (json['drugsUsage'] != null) {
      final List<DrugUsage> drugsUsage = [];
      for (final drugUsage in json['drugsUsage']) {
        drugsUsage.add(DrugUsage.fromJson(drugUsage));
      }
      builder.drugsUsage = drugsUsage;
    }
    return builder.build();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'height': height,
      'weight': weight,
      'age': age,
      'bloodPressure': bloodPressure,
    };
    if (chronicHealthConditions != null) {
      json['chronicHealthConditions'] = chronicHealthConditions;
    }
    if (drugsUsage != null) {
      json['drugsUsage'] =
          drugsUsage!.map((drugUsage) => drugUsage.toJson()).toList();
    }
    return json;
  }

  PatientRecord copyWith({
    double? height,
    double? weight,
    int? age,
    double? bloodPressure,
    List<String>? chronicHealthConditions,
    List<DrugUsage>? drugsUsage,
  }) =>
      PatientRecord(
          height: height ?? this.height,
          weight: weight ?? this.weight,
          age: age ?? this.age,
          bloodPressure: bloodPressure ?? this.bloodPressure,
          chronicHealthConditions:
              chronicHealthConditions ?? this.chronicHealthConditions,
          drugsUsage: drugsUsage ?? this.drugsUsage);

  @override
  String toString() => toJson().toString();
}

double _doubleParser(dynamic number) => double.parse(number.toString());
int _intParser(dynamic number) => int.parse(number.toString());

class PatientRecordBuilder {
  PatientRecordBuilder({
    required this.height,
    required this.weight,
    required this.age,
    required this.bloodPressure,
  });
  double height;
  double weight;
  int age;
  double bloodPressure;
  List<String>? chronicHealthConditions;
  List<DrugUsage>? drugsUsage;

  PatientRecord build() => PatientRecord(
      height: height,
      weight: weight,
      age: age,
      bloodPressure: bloodPressure,
      chronicHealthConditions: chronicHealthConditions,
      drugsUsage: drugsUsage);
}
