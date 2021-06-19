part of 'pages.dart';

class HomePage extends StatelessWidget {
  final personController = Get.put(PersonController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'), backgroundColor: Colors.lightBlueAccent,),
      floatingActionButton: Container(
        height: 40,
        width: size.width - (24 * 2),
        child: FloatingActionButton(
          onPressed: () {
            personController.clear();
            Get.to(AddPersonPage());
          },
          elevation: 0,
          backgroundColor: Colors.lightBlueAccent,
          child: Text(
            "Add Person",
            style: TextStyle(fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('persons')
              .orderBy('fullname')
              .snapshots(),
          builder: (context, querySnapshot) {
            if (querySnapshot.hasError) {
              return Text('something error');
            }
            if (querySnapshot.connectionState == ConnectionState.waiting) {
              return Loading(
                  color: Colors.lightBlueAccent, colorBg: Colors.white);
            } else {
              final list = querySnapshot.data!.docs;

              return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (context, _) => Divider(),
                  itemBuilder: (context, index) {
                    String id = list[index]['id'];
                    return Dismissible(
                      background: Container(
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      key: UniqueKey(),
                      onDismissed: (_) {
                        FirebaseFirestore.instance
                            .collection('persons')
                            .doc(id)
                            .delete();
                        Get.snackbar(
                            'Removed', 'Person was successfully deleted!',
                            snackPosition: SnackPosition.BOTTOM);
                      },
                      child: ListTile(
                        title: Text(list[index]['fullname']),
                        subtitle: Text(list[index]['email']),
                        onTap: () async {
                          personController.fullnameController.text =
                              list[index]['fullname'];
                          personController.emailController.text =
                              list[index]['email'];
                          personController.phoneController.text =
                              list[index]['phone'];

                          Get.bottomSheet(
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 30),
                                color: Colors.white,
                                child: Center(
                                  child: ListView(
                                    children: [
                                      Center(
                                        child: Text(
                                          "Edit Data Person",
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      ReusableTextWithNameField(
                                        controller:
                                            personController.fullnameController,
                                        text: "Full Name",
                                        hintText: "Enter your full name",
                                      ),
                                      ReusableTextWithNameField(
                                        controller:
                                            personController.emailController,
                                        text: "Email Address",
                                        hintText: "Enter your email address",
                                      ),
                                      ReusableTextWithNameField(
                                        controller:
                                            personController.phoneController,
                                        text: "Phone Number",
                                        hintText: "Enter your phone number",
                                        keyboardType: TextInputType.phone,
                                      ),
                                      SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: ReusableElevatedButton(
                                          onPressed: () {
                                            String id = list[index]['id'];
                                            String fullName = personController
                                                .fullnameController.text;
                                            String email = personController
                                                .emailController.text;
                                            String phone = personController
                                                .phoneController.text;

                                            PersonModel personModel =
                                                new PersonModel(
                                              id: id,
                                              fullname: fullName,
                                              email: email,
                                              phone: phone,
                                            );

                                            personController
                                                .createNewUser(personModel);
                                          },
                                          text: 'Edit This Person',
                                          colorButton: Colors.blue,
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
