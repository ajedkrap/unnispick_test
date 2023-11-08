import 'package:flutter/material.dart';
import 'package:unnispick_test/constans.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      required this.label,
      required this.onChanged,
      this.textInputType = TextInputType.text,
      this.placeholder = 'enter...',
      this.isPassword = false});

  // variables
  final String label;
  final String placeholder;
  final Function onChanged;
  final TextInputType textInputType;
  final bool isPassword;

  // events

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(label, style: kLabelTextStyle)),
        TextField(
          style: const TextStyle(
            color: Colors.white,
          ),
          onChanged: (value) => onChanged(value),
          obscureText: isPassword,
          keyboardType: textInputType,
          decoration: kTextFieldDecoration.copyWith(hintText: placeholder),
        ),
      ]),
    );
  }
}
