import 'dart:collection';

import 'package:papai_models/models/user_address_model.dart';
import 'package:papai_models/models/user_contact_info_model.dart';
import 'package:papai_models/models/user_profile_model.dart';

abstract class User {
  const User({required this.uid, required this.email, required this.eventIDs});

  final String email;
  final String uid;
  final List<String> eventIDs;

  Map<String, dynamic> toJson();

  User copyWith({
    String? email,
    String? uid,
    List<String>? eventIDs,
  });
}

class Carer extends User {
  const Carer({
    required super.uid,
    required super.email,
    required super.eventIDs,
    required this.profile,
    this.contactInfo,
    this.address,
  });

  final UserProfile profile;
  final UserContactInfo? contactInfo;
  final UserAddress? address;

  factory Carer.fromJson(Map<String, dynamic> json) {
    List<String> eventIDs = [];
    if (json['eventIDs'] != null) {
      for (final id in json['eventIDs']) {
        eventIDs.add(id as String);
      }
    }
    return Carer(
        email: json['email'] as String,
        profile: UserProfile.fromJson(json['profile']),
        uid: json['uid'] as String,
        eventIDs: eventIDs,
        contactInfo: json['contactInfo'] != null
            ? UserContactInfo.fromJson(json['contactInfo'])
            : null,
        address: json['address'] != null
            ? UserAddress.fromJson(json['address'])
            : null);
  }

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'eventIDs': eventIDs,
        'profile': profile.toJson(),
        if (contactInfo != null) 'contactInfo': contactInfo!.toJson(),
        if (address != null) 'address': address!.toJson(),
      };
  @override
  String toString() => toJson().toString();

  @override
  Carer copyWith({
    String? uid,
    String? email,
    List<String>? eventIDs,
    UserProfile? profile,
    UserContactInfo? contactInfo,
    UserAddress? address,
  }) =>
      Carer(
        profile: profile ?? this.profile,
        email: email ?? this.email,
        uid: uid ?? this.uid,
        eventIDs: eventIDs ?? this.eventIDs,
        contactInfo: contactInfo ?? this.contactInfo,
        address: address ?? this.address,
      );
}

class Elder extends User {
  const Elder({
    required super.uid,
    required super.email,
    required super.eventIDs,
    required this.profile,
    this.contactInfo,
    this.address,
  });

  final UserProfile profile;
  final UserContactInfo? contactInfo;
  final UserAddress? address;

  factory Elder.fromJson(Map<String, dynamic> json) {
    List<String> eventIDs = [];
    if (json['eventIDs'] != null) {
      for (final id in json['eventIDs']) {
        eventIDs.add(id as String);
      }
    }
    return Elder(
        email: json['email'] as String,
        uid: json['uid'] as String,
        profile: UserProfile.fromJson(json['profile']),
        eventIDs: eventIDs,
        contactInfo: json['contactInfo'] != null
            ? UserContactInfo.fromJson(json['contactInfo'])
            : null,
        address: json['address'] != null
            ? UserAddress.fromJson(json['address'])
            : null);
  }

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'eventIDs': eventIDs,
        'profile': profile.toJson(),
        if (contactInfo != null) 'contactInfo': contactInfo!.toJson(),
        if (address != null) 'address': address!.toJson(),
      };

  @override
  Elder copyWith({
    String? displayName,
    String? email,
    String? uid,
    List<String>? eventIDs,
    UserProfile? profile,
    UserContactInfo? contactInfo,
    UserAddress? address,
  }) =>
      Elder(
        profile: profile ?? this.profile,
        email: email ?? this.email,
        uid: uid ?? this.uid,
        eventIDs: eventIDs ?? this.eventIDs,
        contactInfo: contactInfo ?? this.contactInfo,
        address: address ?? this.address,
      );

  @override
  String toString() => toJson().toString();
}
