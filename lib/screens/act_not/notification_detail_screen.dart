import 'package:flutter/material.dart';
import 'package:gesplai/globals.dart' as globals;
import 'package:gesplai/screens/funcions_utils.dart';

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen(String s, {Key? key}) : super(key: key);

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
                  'name',
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
              'Notification',
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
