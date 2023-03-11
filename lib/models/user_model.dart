import 'dart:collection';

abstract class User {
  User(
      {required this.uid,
      required this.displayName,
      required this.email,
      required this.eventIDs}) {
    _initEventIDs();
  }
  final String displayName;
  final String email;
  final String uid;
  final List<String> eventIDs;

  Map<String, dynamic> toJson();

  void _initEventIDs();

  User copyWith({
    String? displayName,
    String? email,
    String? uid,
    List<String>? eventIDs,
  });
}

class Carer extends User {
  Carer(
      {required super.uid,
      required super.displayName,
      required super.email,
      required super.eventIDs}) {
    _initEventIDs();
  }

  List<String> _eventIDs = [];

  @override
  //this is to make eventIDs 'sort of' immutable,
  //preventing client from modifying the eventIDs.
  UnmodifiableListView<String> get eventIDs => UnmodifiableListView(_eventIDs);

  @override
  void _initEventIDs() {
    _eventIDs = super.eventIDs;
  }

  factory Carer.fromJson(Map<String, dynamic> json) => Carer(
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      uid: json['uid'] as String,
      eventIDs: json['eventIDs'] as List<String>);

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'displayName': displayName,
        'uid': uid,
        'eventIDs': eventIDs,
      };
  @override
  String toString() => toJson().toString();

  @override
  Carer copyWith({
    String? displayName,
    String? email,
    String? uid,
    List<String>? eventIDs,
  }) =>
      Carer(
          displayName: displayName ?? this.displayName,
          email: email ?? this.email,
          uid: uid ?? this.uid,
          eventIDs: eventIDs ?? this.eventIDs);
}

class Elder extends User {
  Elder({
    required super.uid,
    required super.displayName,
    required super.email,
    required super.eventIDs,
    required this.phoneNumber,
  }) {
    _initEventIDs();
  }

  final String? phoneNumber;

  List<String> _eventIDs = [];

  @override
  UnmodifiableListView<String> get eventIDs => UnmodifiableListView(_eventIDs);

  @override
  void _initEventIDs() {
    _eventIDs = super.eventIDs;
  }

  factory Elder.fromJson(Map<String, dynamic> json) => Elder(
        email: json['email'] as String,
        displayName: json['displayName'] as String,
        uid: json['uid'] as String,
        eventIDs: json['eventIDs'] as List<String>,
        phoneNumber: json['userPhone'] as String?,
      );

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  @override
  Elder copyWith(
      {String? displayName,
      String? email,
      String? uid,
      List<String>? eventIDs}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
