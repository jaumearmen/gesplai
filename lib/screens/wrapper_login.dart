import 'package:flutter/material.dart';
import 'package:gesplai/screens/bottom_nav_menu.dart';
import 'package:gesplai/screens/login/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:gesplai/services/auth_service.dart';
import '../models/user.dart';

class WrapperLogin extends StatelessWidget {
  const WrapperLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            print(user?.getEmail());
            return user == null ? const SignIn() : const BottomNavMenu();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
