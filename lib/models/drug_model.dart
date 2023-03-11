class Drug {
  const Drug({
    required this.name,
    required this.shape,
  });

  final String name;
  final DrugShape shape;

  factory Drug.fromJson(Map<String, dynamic> json) => Drug(
        name: json['name'] as String,
        shape: _stringToDrugShape(json['shape']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'shape': shape.name,
      };

  Drug copyWith({String? name, DrugShape? shape}) =>
      Drug(name: name ?? this.name, shape: shape ?? this.shape);

  @override
  String toString() => toJson().toString();
}

class DrugUsage {
  const DrugUsage({
    required this.drug,
    required this.dosage,
    required this.unit,
    required this.usageTime,
    required this.comment,
  });

  final Drug drug;
  final double dosage;
  final DrugUnit unit;
  final List<DrugUsageTime> usageTime;
  final String comment;

  factory DrugUsage.build(Drug drug, String dosage, DrugUnit drugUit,
          List<DrugUsageTime> usageTime, String comment) =>
      DrugUsage(
          drug: drug,
          dosage: _doubleParser(dosage),
          unit: drugUit,
          usageTime: usageTime,
          comment: comment);

  factory DrugUsage.fromJson(Map<String, dynamic> json) {
    final List<DrugUsageTime> usageTime = [];
    for (final time in json['usageTime']) {
      usageTime.add(_stringToDrugUsageTime(time));
    }
    return DrugUsage(
      drug: Drug.fromJson(json['drug']),
      dosage: _doubleParser(json['dosage']),
      unit: _stringToDrugUnit(json['unit']),
      usageTime: usageTime,
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() => {
        'drug': drug.toJson(),
        'dosage': dosage,
        'unit': unit.name,
        'usageTime': usageTime.map((time) => time.name).toList(),
        'comment': comment
      };

  @override
  String toString() => toJson().toString();
}

double _doubleParser(dynamic number) => double.parse(number.toString());

enum DrugShape { capsule, tablet, liquid }

DrugShape _stringToDrugShape(String shape) =>
    DrugShape.values.firstWhere((element) => element.name == shape);

enum DrugUnit { pill, spoon }

DrugUnit _stringToDrugUnit(String unit) =>
    DrugUnit.values.firstWhere((element) => element.name == unit);

enum DrugUsageTime { morning, afternoon, evening, night }

DrugUsageTime _stringToDrugUsageTime(String time) =>
    DrugUsageTime.values.firstWhere((element) => element.name == time);
