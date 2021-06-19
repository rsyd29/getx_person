part of 'controllers.dart';

class PersonController extends GetxController {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final _personModel = PersonModel().obs;

  set personModel(value) => _personModel.value = value;

  get personModel => _personModel.value;

  createNewUser(PersonModel personModel) async {
    try {
      if (await PersonService.createNewPerson(personModel)) {
        clear();
        Get.offAll(HomePage());
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error create person', '$e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  clear() {
    fullnameController.clear();
    emailController.clear();
    phoneController.clear();
  }
}
