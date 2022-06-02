import 'package:flutter/material.dart';
import 'package:gesplai/screens/login/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                constraints:
                    const BoxConstraints(maxHeight: 100, maxWidth: 100),
                child: Image.asset('assets/images/logoTemporal.png'),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 5),
                child: const Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 25)),
              CustomTextfield(
                  controller: _usernameController,
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    size: 30,
                    color: Colors.blue,
                  ),
                  type: 'text',
                  labelText: 'Username'),
              CustomTextfield(
                  controller: _emailController,
                  icon: const Icon(
                    Icons.mail_outline,
                    size: 30,
                    color: Colors.blue,
                  ),
                  type: 'text',
                  labelText: 'Email'),
              CustomTextfield(
                  controller: _passwordController,
                  icon: const Icon(
                    Icons.lock_outline,
                    size: 30,
                    color: Colors.blue,
                  ),
                  type: 'password',
                  labelText: 'Password'),
              Container(
                margin: const EdgeInsets.only(top: 25),
                padding: const EdgeInsets.all(10),
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () async {
                    await authService.createUserWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: Colors.black,
                    ),
                    Container(
                      child: const Text('Or sign up with'),
                    ),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width * 0.25,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(maxHeight: 60, maxWidth: 60),
                margin: const EdgeInsets.only(top: 30),
                child: GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/images/google.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
