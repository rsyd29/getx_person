part of 'services.dart';

class PersonService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference _personCollection =
      firestore.collection('persons');
  static DocumentReference documentReference = _personCollection.doc();

  static Future<bool> createNewPerson(PersonModel personModel) async {
    try {
      await _personCollection.doc(personModel.id).set(
        {
          'id': personModel.id,
          'fullname': personModel.fullname,
          'email': personModel.email,
          'phone': personModel.phone,
        },
      );
      print('Person added & updated');
      Get.snackbar('Successfully', 'Successfully added or updated Person data');
      return true;
    } catch (e) {
      print("Failed to add person: $e");
      return false;
    }
  }

  static Future<PersonModel> getPerson(String id) async {
    DocumentSnapshot snapshot = await _personCollection.doc(id).get();

    return PersonModel(
      fullname: snapshot.get('fullname'),
      email: snapshot.get('email'),
      phone: snapshot.get('phone'),
    );
  }
}
