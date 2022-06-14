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
        'Really Long Text Really Long Text Really Long Text Really Long Text Really Long Text Really Long Text Really Long Text';
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
                    text: 'Carrer Sant Joan',
                    icon: Icons.location_on,
                  ),
                  addVerticalSpace(10),
                  const IconAndText(
                    text: '8/10/2022',
                    icon: Icons.calendar_today_outlined,
                  ),
                  addVerticalSpace(10),
                  const IconAndText(
                    text: '8a.m - 3a.m',
                    icon: Icons.schedule,
                  ),
                  addVerticalSpace(30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      longText,
                      maxLines: 3,
                      overflow: TextOverflow.fade,
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
      children: [
        imageExists
            ? Container(
                child: Image.asset(
                  'assets/images/esplai2.jpg',
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
        Positioned(
          child: Container(
            child: const Text(
              'Excursió a la Mola',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
