import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import 'package:gesplai/screens/login/widgets/custom_textfield.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({Key? key}) : super(key: key);

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  var _day;

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
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.clear),
                    Icon(Icons.verified),
                  ],
                ),*/
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
              controller: _locationController,
              icon: const Icon(Icons.location_on_outlined),
              labelText: 'Location',
              type: 'text',
            ),
            addVerticalSpace(10),
            Container(
              padding: const EdgeInsets.all(10),
              child: DateTimePicker(
                type: DateTimePickerType.date,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onChanged: (val) => print(val),
                onSaved: (val) {
                  _day = val!;
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
                  labelText: "Dia de l'activitat",
                  prefixIcon: const Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
              ),
            ),
            addVerticalSpace(10),
            Container(
              padding: const EdgeInsets.all(10),
              child: DateTimePicker(
                type: DateTimePickerType.time,
                onChanged: (val) => print(val),
                onSaved: (val) {
                  _day = val!;
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
                  labelText: 'Hora començament activitat',
                  prefixIcon: const Icon(
                    Icons.schedule,
                  ),
                ),
              ),
            ),
            addVerticalSpace(10),
            CustomTextfield(
              controller: _descriptionController,
              icon: const Icon(Icons.description),
              labelText: "Descriu l'activitat",
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
