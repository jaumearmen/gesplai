import 'package:flutter/material.dart';
import 'package:gesplai/screens/funcions_utils.dart';

class NoEsplaiScreen extends StatelessWidget {
  const NoEsplaiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.people_rounded,
              color: Colors.blue,
              size: 100,
            ),
            addVerticalSpace(20),
            const Text(
              'Regístrate en un esplai para poder tener esta información',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
