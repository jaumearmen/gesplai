import 'package:flutter/material.dart';
import 'package:gesplai/services/user_service.dart';

import '../../models/user.dart';

class EditProfileUser extends StatefulWidget {
  final User user;
  const EditProfileUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileUser> createState() => _EditProfileUserState();
}

class _EditProfileUserState extends State<EditProfileUser> {
  bool trobatFirebase = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController.text = widget.user.name;
      _usernameController.text = widget.user.username;
      _emailController.text = widget.user.email;
      _descriptionController.text = widget.user.description!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            imageProfile(),
            titlePreEditText('Nom'),
            editTextProfile(_nameController, false),
            titlePreEditText("Nom d'usuari"),
            editTextProfile(_usernameController, false),
            titlePreEditText('Email'),
            editTextProfile(_emailController, false),
            titlePreEditText('Descripció'),
            editTextProfile(_descriptionController, true),
            buttonEditProfile(),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
              radius: 80,
              backgroundImage: !trobatFirebase
                  ? const AssetImage('assets/images/No_pic.png')
                  : const AssetImage('assets/images/esplai6.jpg') //user.img
              ),
          Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  /*showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );*/
                },
                child: const Icon(
                  Icons.edit,
                  size: 30,
                ),
              )),
        ],
      ),
    );
  }

  Widget titlePreEditText(String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget editTextProfile(TextEditingController controller, bool moreLines) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        onChanged: (text) {
          setState(() {});
        },
        maxLines: moreLines ? null : 1,
        keyboardType: moreLines ? TextInputType.multiline : TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                controller.clear();
              });
            },
            icon: const Icon(Icons.clear),
          ),
        ),
      ),
    );
  }

  Widget buttonEditProfile() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      padding: const EdgeInsets.all(10),
      height: 60,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () async {
          await UserService.updateUser(
            name: _nameController.text,
            username: _usernameController.text,
            email: _emailController.text,
            description: _descriptionController.text,
            localization: '',
            day: '',
            startHour: '',
            endHour: '',
            userId: widget.user.userId,
          );
          Navigator.pop(context);
        },
        child: const Text(
          'Acceptar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
