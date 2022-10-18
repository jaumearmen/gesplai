import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text('Recuperar contrasenya'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Reb un email per\nrecuperar la contrasenya',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && EmailValidator.validate(email)
                        ? 'Introdueix un email vàlid'
                        : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  resetPassword();
                },
                child: const Text(
                  'Recupera contrasenya',
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
          key: formKey,
        ),
      ),
    );
  }

  Future resetPassword() async {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text.trim())
        .then((value) => Navigator.pop(context));
  }
}
