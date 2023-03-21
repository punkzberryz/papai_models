import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:papai_models/data/user_repository.dart';
import 'package:papai_models/models/user_contact_info_model.dart';
import 'package:papai_models/models/user_model.dart';
import 'package:papai_models/models/user_profile_model.dart';

void main() async {
  final fakeUserRepositoryProvider =
      Provider<FirebaseCloudFireStoreUserRepository>((ref) {
    return FirebaseCloudFireStoreUserRepository(FakeFirebaseFirestore());
  });
  final container = ProviderContainer(overrides: []);
  final fakeUserRepository = container.read(fakeUserRepositoryProvider);
  const String firstID = 'thisIsAnID';

  const Carer firstCarer = Carer(
      email: 'kang@gmail.com',
      uid: firstID,
      eventIDs: [],
      profile: UserProfile(displayName: 'kang nakub'));

  test('user repository ...addCarer', () async {
    await fakeUserRepository.addCarer(firstCarer);
  });
  test('user repository ...getCarer', () async {
    final carer = await fakeUserRepository.getCarer(carerID: firstID);
    expect(carer.toString(), firstCarer.toString());
  });

  test('user repository ...editCarer', () async {
    final carer = await fakeUserRepository.getCarer(carerID: firstID);
    final carer2 = carer.copyWith(contactInfo: contactInfo);
    await fakeUserRepository.editCarer(carer2);
    final getCarer2 = await fakeUserRepository.getCarer(carerID: carer2.uid);
    expect(carer2.contactInfo!.toString(), getCarer2.contactInfo!.toString());
    expect(carer2.contactInfo!.facebook, 'facebook123');
  });
  test('user repository ...addEventToCarer', () async {
    const String eventID = 'eventID001';
    final carer = await fakeUserRepository.getCarer(carerID: firstID);
    final newEventIDs = [...carer.eventIDs, eventID];
    await fakeUserRepository
        .addEventToCarer(carer.copyWith(eventIDs: newEventIDs));
    final updatedCarer = await fakeUserRepository.getCarer(carerID: firstID);
    expect(newEventIDs, updatedCarer.eventIDs);
  });
  test('user repository ...addManyEventsToCarer', () async {
    final carer = await fakeUserRepository.getCarer(carerID: firstID);
    List<String> newEventIDs = [];
    for (int i = 0; i < 5; i++) {
      newEventIDs.add('eventID0$i');
    }
    await fakeUserRepository.addManyEventsToCarer(carer, newEventIDs);
    final updatedCarer = await fakeUserRepository.getCarer(carerID: firstID);
    expect(updatedCarer.eventIDs, [...carer.eventIDs, ...newEventIDs]);
  });
  test('user repository ...deleteEventFromCarer', () async {
    const String eventID = 'eventID001';
    final carer = await fakeUserRepository.getCarer(carerID: firstID);
    await fakeUserRepository.deleteEventFromCarer(carer, eventID);
    final updatedCarer = await fakeUserRepository.getCarer(carerID: firstID);
    expect(updatedCarer.eventIDs.contains(eventID), false);
  });
}

const contactInfo =
    UserContactInfo(phoneNumber: '098765431', facebook: 'facebook123');
