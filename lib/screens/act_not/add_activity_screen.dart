import 'package:flutter/material.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import 'package:gesplai/screens/login/widgets/custom_textfield.dart';
import 'package:gesplai/services/events_service.dart';
import 'package:gesplai/services/user_service.dart';

import '../../models/user.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({Key? key}) : super(key: key);

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late User _user;

  Future<void> getUser() async {
    _user = (await UserService.getUser())!;
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/esplai2.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    fit: BoxFit.cover,
                  ),
                ),
                TextButton(
                  child: const Text(
                    'Add a descriptive picture',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            addVerticalSpace(10),
            CustomTextfield(
              controller: _titleController,
              icon: const Icon(Icons.title),
              labelText: "Títol de l'activitat/notificació",
              type: 'text',
            ),
            addVerticalSpace(10),
            CustomTextfield(
              controller: _descriptionController,
              icon: const Icon(Icons.description),
              labelText: "Descriu l'activitat/notificació",
              type: 'multiline',
            ),
            addVerticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      EventsService.createEvent(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        idEsplai: _user.userId,
                      );
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.check),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
