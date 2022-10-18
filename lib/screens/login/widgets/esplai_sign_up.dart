import 'package:flutter/material.dart';
import 'package:gesplai/screens/login/widgets/custom_textfield.dart';
import 'package:date_time_picker/date_time_picker.dart';

class EsplaiSignUp extends StatefulWidget {
  final TextEditingController fullnameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController localizationController;
  String day;
  String startHour;
  String endHour;

  EsplaiSignUp(
      {Key? key,
      required this.fullnameController,
      required this.usernameController,
      required this.emailController,
      required this.passwordController,
      required this.localizationController,
      required this.day,
      required this.startHour,
      required this.endHour})
      : super(key: key);

  @override
  State<EsplaiSignUp> createState() => _EsplaiSignUpState();
}

class _EsplaiSignUpState extends State<EsplaiSignUp> {
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
          labelText: "Nom de l'esplai",
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
        CustomTextfield(
          controller: widget.localizationController,
          icon: const Icon(
            Icons.place,
            size: 30,
            color: Colors.blue,
          ),
          type: 'text',
          labelText: 'Localització',
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onChanged: (val) {
              setState(() {
                widget.day = val;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                ),
              ),
              labelText: 'Quin dia comença esplai?',
              prefixIcon: const Icon(Icons.event, color: Colors.blue),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: DateTimePicker(
            type: DateTimePickerType.time,
            onChanged: (val) {
              setState(() {
                widget.startHour = val;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                ),
              ),
              labelText: 'A quina hora comença esplai?',
              prefixIcon: const Icon(
                Icons.timer,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: DateTimePicker(
            type: DateTimePickerType.time,
            onChanged: (val) {
              setState(() {
                widget.endHour = val;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                ),
              ),
              labelText: 'A quina hora acaba esplai?',
              prefixIcon: const Icon(
                Icons.lock_clock,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
