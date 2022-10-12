import 'package:flutter/material.dart';
import 'package:gesplai/screens/login/widgets/custom_textfield.dart';

class IndividualUserSignUp extends StatefulWidget {
  final TextEditingController fullnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const IndividualUserSignUp({
    Key? key,
    required this.fullnameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<IndividualUserSignUp> createState() => _IndividualUserSignUpState();
}

class _IndividualUserSignUpState extends State<IndividualUserSignUp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfield(
          controller: widget.fullnameController,
          icon: const Icon(
            Icons.account_circle_outlined,
            size: 30,
            color: Colors.blue,
          ),
          type: 'text',
          labelText: 'Nom complet',
        ),
        CustomTextfield(
          controller: widget.usernameController,
          icon: const Icon(
            Icons.account_circle_outlined,
            size: 30,
            color: Colors.blue,
          ),
          type: 'text',
          labelText: 'Username',
        ),
        CustomTextfield(
          controller: widget.emailController,
          icon: const Icon(
            Icons.mail_outline,
            size: 30,
            color: Colors.blue,
          ),
          type: 'text',
          labelText: 'Email',
        ),
        CustomTextfield(
          controller: widget.passwordController,
          icon: const Icon(
            Icons.lock_outline,
            size: 30,
            color: Colors.blue,
          ),
          type: 'password',
          labelText: 'Contrasenya',
        ),
      ],
    );
  }
}
