import 'package:flutter/material.dart';
import 'package:gesplai/screens/login/sign_up.dart';
import 'package:gesplai/screens/login/widgets/custom_textfield.dart';
import 'package:gesplai/globals.dart' as globals;
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gesplai/screens/funcions_utils.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var colorPrimary = MaterialStateProperty.all<Color>(globals.COLOR_BLUE);
  var colorSecondary =
      MaterialStateProperty.all<Color>(globals.COLOR_LIGHT_BLUE);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  'Log to your account',
                  style: GoogleFonts.leagueSpartan(fontSize: 15),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 25)),
              CustomTextfield(
                  controller: _emailController,
                  icon: const Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Colors.blue,
                  ),
                  type: 'text',
                  labelText: 'Email'),
              CustomTextfield(
                  controller: _passwordController,
                  icon: const Icon(
                    Icons.lock,
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
                    await authService.signInWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                  child: const Text(
                    'Sign In',
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
                      child: const Text('Or sign in with'),
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
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Don't have an account yet?"),
                    ),
                    addVerticalSpace(15),
                    Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                          );
                        },
                        child: const Text(
                          'Sign Up here',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
