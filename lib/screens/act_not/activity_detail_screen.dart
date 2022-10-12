import 'package:flutter/material.dart';
import 'package:gesplai/globals.dart' as globals;
import 'package:gesplai/screens/widgets/icon_and_text.dart';
import 'package:gesplai/screens/funcions_utils.dart';

class ActivityDetailScreen extends StatelessWidget {
  const ActivityDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool imageExists = true;
    String longText =
        "Farem un petit recorregut per l'esglesia de Sant Joan de Matadepera i veurem totes les capelles i el santíssim. Al final farem un petit berenar a les afores de la plaça Cal Baldiró i ja haureu fet.";
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            ImageStack(imageExists, context),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const IconAndText(
                    text: 'Carrer Àngel Guimerà, 8',
                    icon: Icons.location_on,
                  ),
                  addVerticalSpace(10),
                  const IconAndText(
                    text: '18/12/2022',
                    icon: Icons.calendar_today_outlined,
                  ),
                  addVerticalSpace(10),
                  const IconAndText(
                    text: '18:00 - 20:00',
                    icon: Icons.schedule,
                  ),
                  addVerticalSpace(30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      longText,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ImageStack(bool imageExists, BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        imageExists
            ? Container(
                child: Image.asset(
                  'assets/images/esplai3.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.20,
                color: globals.COLOR_LIGHT_GREY,
              ),
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            "Sortida a l'esglesia de Sant Joan",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        const Positioned(
          right: 15,
          top: 15,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 35,
          ),
        ),
        Positioned(
          left: 15,
          top: 15,
          child: InkWell(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 35,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
