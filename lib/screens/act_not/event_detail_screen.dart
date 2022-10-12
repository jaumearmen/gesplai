import 'package:flutter/material.dart';
import 'package:gesplai/globals.dart' as globals;
import 'package:gesplai/screens/funcions_utils.dart';

class EventDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  const EventDetailScreen(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool imageExists = true;
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
                      description,
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
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
