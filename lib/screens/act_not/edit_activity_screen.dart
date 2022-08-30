import 'package:flutter/material.dart';
import 'package:gesplai/screens/widgets/icon_and_text.dart';

class EditActivitySceren extends StatefulWidget {
  const EditActivitySceren({Key? key}) : super(key: key);

  @override
  State<EditActivitySceren> createState() => _EditActivityScerenState();
}

class _EditActivityScerenState extends State<EditActivitySceren> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/esplai2.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.clear),
                    Icon(Icons.verified),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    child: const Text('Add a descriptive picture'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const IconAndText(
              text: 'location',
              icon: Icons.location_on_outlined,
            ),
            const TextField(),
            const IconAndText(
              text: 'location',
              icon: Icons.calendar_today_outlined,
            ),
            const IconAndText(
              text: 'location',
              icon: Icons.schedule,
            ),
            const IconAndText(
              text: 'location',
              icon: Icons.description,
            ),
          ],
        ),
      ),
    );
  }
}
