import 'package:flutter/material.dart';
import 'package:gesplai/screens/funcions_utils.dart';
import 'package:gesplai/screens/login/widgets/esplai_sign_up.dart';
import 'package:gesplai/screens/login/widgets/individual_user_sign_up.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../services/user_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _localizationController = TextEditingController();
  var day;
  var endHour;
  var startHour;
  int? _value = 1;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userService = Provider.of<UserService>(context);
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
              Column(
                children: [
                  Row(
                    children: [
                      Radio(
                          value: 1,
                          groupValue: _value,
                          onChanged: (int? value) {
                            setState(() {
                              _value = value;
                            });
                          }),
                      addHorizontalSpace(10),
                      const Text('Individual user'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: 2,
                          groupValue: _value,
                          onChanged: (int? value) {
                            setState(() {
                              _value = value;
                            });
                          }),
                      addHorizontalSpace(10),
                      const Text('Esplai'),
                    ],
                  ),
                ],
              ),
              addVerticalSpace(10),
              _value == 1
                  ? IndividualUserSignUp(
                      fullnameController: _fullnameController,
                      usernameController: _usernameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                    )
                  : EsplaiSignUp(
                      fullnameController: _fullnameController,
                      usernameController: _usernameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      localizationController: _localizationController,
                      day: day,
                      startHour: startHour,
                      endHour: endHour),
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
                    if (_value == 1) {
                      await authService.createUserWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                        _fullnameController.text,
                        _usernameController.text,
                        'description',
                        '',
                        '',
                        '',
                        '',
                        '',
                        false,
                      );
                    } else {
                      await authService.createUserWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                        _fullnameController.text,
                        _usernameController.text,
                        'description',
                        '',
                        day.toString(),
                        startHour.toString(),
                        endHour.toString(),
                        _localizationController.text,
                        true,
                      );
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
