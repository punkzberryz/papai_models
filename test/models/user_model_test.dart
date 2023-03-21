import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:papai_models/models/user_address_model.dart';
import 'package:papai_models/models/user_contact_info_model.dart';
import 'package:papai_models/models/user_model.dart';
import 'package:papai_models/models/user_profile_model.dart';

void main() {
  test('carer model ...', () async {
    const carer = Carer(
        email: 'carer1@gmail.com',
        uid: 'carer101_xxx2',
        eventIDs: ['sdsafg3123'],
        profile: profile1);

    final carerJson = carer.toJson();
    expect(carer.profile.displayName, 'carer1');
    expect(carerJson['profile']['displayName'], 'carer1');
    expect(carer.eventIDs, carerJson['eventIDs']);
  });
  test('carer model ... empty event', () async {
    const carer = Carer(
        email: 'carer1@gmail.com',
        uid: 'carer101_xxx2',
        eventIDs: [],
        profile: profile1);

    final carerJson = carer.toJson();
    expect(carer.profile.displayName, 'carer1');
    expect(carerJson['profile']['displayName'], 'carer1');
    expect(carer.eventIDs.isEmpty, true);
    expect(carer.eventIDs, []);
  });

  test('carer model ... add event', () async {
    final carer = Carer(
        email: 'carer1@gmail.com',
        uid: 'carer101_xxx2',
        eventIDs: ['1'],
        profile: profile1.copyWith(bio: 'bio111'));
    final List<String> newEvets = [...carer.eventIDs, '2'];
    newEvets.add('xxx');
    final newCarer = carer.copyWith(eventIDs: newEvets);
    expect(newCarer.eventIDs, ['1', '2', 'xxx']);
  });
  test('carer model ... remove event', () async {
    const carer = Carer(
        email: 'carer1@gmail.com',
        uid: 'carer101_xxx2',
        eventIDs: ['1'],
        profile: profile1);
    List<String> newEvets = [...carer.eventIDs];
    newEvets.remove('1');
    final newCarer = carer.copyWith(eventIDs: newEvets);
    expect(newCarer.eventIDs, []);
  });

  test('elder model ... toJson', () {
    const elder = Elder(
        uid: 'elder1',
        profile: elderProfile1,
        email: 'elder@gmail.com',
        eventIDs: []);
    final json = elder.toJson();
    expect(elder.uid, json['uid']);
    expect(elder.profile.displayName, json['profile']['displayName']);
    expect(elder.email, json['email']);
  });
  test('elder model ... toJson and back fromJson', () {
    const elder1 = Elder(
      uid: 'elder1',
      profile: elderProfile1,
      email: 'elder@gmail.com',
      eventIDs: ['xxx1'],
      contactInfo: null,
    );

    final elder2 = elder1.copyWith(
        contactInfo: UserContactInfo.fromJson(contactMap3),
        address: UserAddress.fromJson(addressMap2));
    final elder3 = elder1.copyWith(
      contactInfo: UserContactInfo.fromJson(contactMap3),
    );
    final json1 = elder1.toJson();
    final json2 = elder2.toJson();
    final json3 = elder3.toJson();
    final fromJson1 = Elder.fromJson(json1);
    final fromJson2 = Elder.fromJson(json2);
    final fromJson3 = Elder.fromJson(json3);
    expect(fromJson1.toString(), elder1.toString());
    expect(fromJson2.toString(), elder2.toString());
    expect(fromJson3.toString(), elder3.toString());
  });
}

const profile1 = UserProfile(displayName: 'carer1');
const elderProfile1 = UserProfile(displayName: 'elder1', bio: 'i am olddddd');

const contactMap1 = {
  'phoneNumber': '09846348',
};

const contactMap2 = {
  'lineID': 'lineIDxxx1234',
  'facebook': 'face123213',
};

const addressMap1 = {'province': 'BKK', 'city': null};
const addressMap2 = {'city': 'HYD', 'province': null};
const addressMap3 = {'city': 'HYD', 'province': 'Songkhla'};

const contactMap3 = {
  'lineID': 'lineIDxxx1234',
  'facebook': 'face123213',
  'address': addressMap1
};
