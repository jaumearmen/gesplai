import 'package:flutter/material.dart';
import 'package:gesplai/models/user_login.dart';
import 'package:gesplai/screens/bottom_nav_menu.dart';
import 'package:gesplai/screens/login/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:gesplai/services/auth_service.dart';

class WrapperLogin extends StatelessWidget {
  const WrapperLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<UserLogin?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<UserLogin?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final UserLogin? user = snapshot.data;
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
