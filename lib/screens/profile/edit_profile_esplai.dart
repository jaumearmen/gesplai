import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gesplai/services/user_service.dart';

import '../../models/user.dart';

class EditProfileEsplai extends StatefulWidget {
  final User user;
  const EditProfileEsplai({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileEsplai> createState() => _EditProfileEsplaiState();
}

class _EditProfileEsplaiState extends State<EditProfileEsplai> {
  bool trobatFirebase = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _localizationController = TextEditingController();
  String day = DateTime.now().toString();
  bool dayChanged = false;
  String timeStart = '';
  String timeEnd = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            imageProfile(),
            titlePreEditText('Nom'),
            editTextProfile(_nameController, false, widget.user.name),
            titlePreEditText("Nom d'usuari"),
            editTextProfile(_usernameController, false, widget.user.username),
            titlePreEditText('Email'),
            editTextProfile(_emailController, false, widget.user.username),
            titlePreEditText('Descripció'),
            editTextProfile(
                _descriptionController, true, widget.user.description!),
            titlePreEditText('Localització'),
            editTextProfile(
                _localizationController, false, widget.user.localization!),
            Container(
              padding: const EdgeInsets.all(10),
              child: DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(), //USER DATE
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onChanged: (val) => print(val),
                onSaved: (val) {
                  day = val!;
                },
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
                  labelText: 'Quin dia comença esplai?',
                  prefixIcon: const Icon(Icons.event, color: Colors.blue),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: DateTimePicker(
                type: DateTimePickerType.time,
                onChanged: (val) => print(val),
                onSaved: (val) {
                  timeStart = val!;
                },
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
                  labelText: 'A quina hora comença esplai?',
                  prefixIcon: const Icon(
                    Icons.timer,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: DateTimePicker(
                type: DateTimePickerType.time,
                onChanged: (val) => print(val),
                onSaved: (val) {
                  timeEnd = val!;
                },
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
                  labelText: 'A quina hora acaba esplai?',
                  prefixIcon: const Icon(
                    Icons.lock_clock,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
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

  Widget editTextProfile(
      TextEditingController controller, bool moreLines, String text) {
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
          prefixText: text,
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
          if (!dayChanged) day = widget.user.day!;
          if (timeStart == '') timeStart = widget.user.startHour!;
          if (timeEnd == '') timeEnd = widget.user.endHour!;
          UserService.updateUser(
            name: _nameController.text,
            username: _usernameController.text,
            email: _emailController.text,
            description: _descriptionController.text,
            localization: _localizationController.text,
            day: day,
            startHour: timeStart,
            endHour: timeEnd,
            userId: widget.user.userId,
          );
        },
        child: const Text(
          'Acceptar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
