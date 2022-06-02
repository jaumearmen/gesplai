import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final Icon icon;
  final String labelText;
  final String type;

  const CustomTextfield(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.labelText,
      required this.type})
      : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: widget.controller,
          onChanged: (text) {
            setState(() {});
          },
          obscureText: widget.type == "password" ? isObscure : false,
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
            labelText: widget.labelText,
            prefixIcon: widget.icon,
            suffixIcon: widget.type != "password"
                ? widget.controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            widget.controller.clear();
                          });
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null
                : IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: isObscure
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
          ),
        ),
      ),
    );
  }
}
