part of 'pages.dart';

class EditPersonPage extends StatelessWidget {
  final personController = Get.put(PersonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Person Page')),
      body: ListView(
        children: [
          Column(
            children: [
              ReusableTextWithNameField(
                controller: personController.fullnameController,
                text: "Full Name",
                hintText: "Enter your full name",
              ),
              ReusableTextWithNameField(
                controller: personController.emailController,
                text: "Email Address",
                hintText: "Enter your email address",
              ),
              ReusableTextWithNameField(
                controller: personController.phoneController,
                text: "Phone Number",
                hintText: "Enter your phone number",
                keyboardType: TextInputType.phone,
              ),
              ReusableElevatedButton(
                onPressed: () {
                  String fullName = personController.fullnameController.text;
                  String email = personController.emailController.text;
                  String phone = personController.phoneController.text;

                  PersonModel personModel = new PersonModel(
                    fullname: fullName,
                    email: email,
                    phone: phone,
                  );

                  personController.createNewUser(personModel);
                },
                text: 'Create a Person',
                colorButton: Colors.lightBlueAccent,
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ],
      ),
    );
  }
}
