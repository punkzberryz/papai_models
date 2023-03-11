import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:papai_models/models/user_model.dart';

void main() {
  test('user model ...', () async {
    final carer = Carer(
      displayName: 'carer1',
      email: 'carer1@gmail.com',
      uid: 'carer101_xxx2',
      eventIDs: ['sdsafg3123'],
    );

    final carerJson = carer.toJson();
    expect(carer.displayName, 'carer1');
    expect(carerJson['displayName'], 'carer1');
    expect(carer.eventIDs, carerJson['eventIDs']);
  });
  test('user model ... empty event', () async {
    final carer = Carer(
      displayName: 'carer1',
      email: 'carer1@gmail.com',
      uid: 'carer101_xxx2',
      eventIDs: [],
    );

    final carerJson = carer.toJson();
    expect(carer.displayName, 'carer1');
    expect(carerJson['displayName'], 'carer1');
    expect(carer.eventIDs.isEmpty, true);
    expect(carer.eventIDs, []);
  });

  test('user model ... add event', () async {
    final carer = Carer(
      displayName: 'carer1',
      email: 'carer1@gmail.com',
      uid: 'carer101_xxx2',
      eventIDs: ['1'],
    );
    final List<String> newEvets = [...carer.eventIDs, '2'];
    newEvets.add('xxx');
    final newCarer = carer.copyWith(eventIDs: newEvets);
    expect(newCarer.eventIDs, ['1', '2', 'xxx']);
  });
  test('user model ... remove event', () async {
    final carer = Carer(
      displayName: 'carer1',
      email: 'carer1@gmail.com',
      uid: 'carer101_xxx2',
      eventIDs: ['1'],
    );
    List<String> newEvets = [...carer.eventIDs];
    newEvets.remove('1');
    final newCarer = carer.copyWith(eventIDs: newEvets);
    expect(newCarer.eventIDs, []);
  });
}
