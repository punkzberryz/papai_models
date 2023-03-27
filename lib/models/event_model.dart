import 'package:papai_models/models/patient_record_model.dart';
import 'package:papai_models/models/user_model.dart';

class Event {
  const Event({
    required this.id,
    required this.dateStart,
    required this.dateEnd,
    required this.status,
    required this.carerId,
    required this.elderId,
    this.elder,
    required this.location,
    required this.earning,
    this.patientRecord,
  });
  //TODO: replace elderId with elder model, but still maintain elderId in json database

  final String id;
  final DateTime dateStart;
  final DateTime dateEnd;
  final EventStatus status;
  final String carerId;
  final String? elderId;
  final Elder? elder;
  final String? location;
  final double? earning;
  final PatientRecord? patientRecord;

  factory Event.fromJson(Map<String, dynamic> json) {
    final event = Event(
        id: json['id'] as String,
        dateStart: DateTime.parse(json['dateStart']),
        dateEnd: DateTime.parse(json['dateEnd']),
        status: _stringToEventStatus(json['status']),
        carerId: json['carerId'] as String,
        elderId: json['elderId'] as String?,
        location: json['location'] as String?,
        earning: _doubleParser(json['earning']));
    if (json['patientRecord'] != null) {
      return event.copyWith(
          patientRecord: PatientRecord.fromJson(json['patientRecord']));
    }
    return event;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'dateStart': dateStart.toString(),
      'dateEnd': dateEnd.toString(),
      'status': status.name,
      'carerId': carerId,
      'elderId': elderId,
      'location': location,
      'earning': earning,
    };
    if (patientRecord != null) {
      json['patientRecord'] = patientRecord!.toJson();
    }
    return json;
  }

  Event copyWith({
    String? id,
    DateTime? dateStart,
    DateTime? dateEnd,
    EventStatus? status,
    String? carerId,
    String? elderId,
    String? location,
    double? earning,
    PatientRecord? patientRecord,
    Elder? elder,
  }) =>
      Event(
        id: id ?? this.id,
        dateStart: dateStart ?? this.dateStart,
        dateEnd: dateEnd ?? this.dateEnd,
        status: status ?? this.status,
        carerId: carerId ?? this.carerId,
        elderId: elderId ?? this.elderId,
        location: location ?? this.location,
        earning: earning ?? this.earning,
        patientRecord: patientRecord ?? this.patientRecord,
        elder: elder ?? this.elder,
      );

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Event &&
        other.id == id &&
        other.dateStart == dateStart &&
        other.dateEnd == dateEnd &&
        other.status == status &&
        other.carerId == carerId &&
        other.elderId == elderId &&
        other.location == location &&
        other.earning == earning;
  }

  @override
  int get hashCode => id.hashCode ^ carerId.hashCode;
}

enum EventStatus {
  free,
  pending,
  booked,
  declined,
  retired,
}

EventStatus _stringToEventStatus(String statusString) =>
    EventStatus.values.firstWhere((element) => element.name == statusString);

double? _doubleParser(dynamic number) {
  if (number == null) return null;
  return double.parse(number.toString());
}
