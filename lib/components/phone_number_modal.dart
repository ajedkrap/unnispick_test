import 'package:flutter/material.dart';
import 'package:unnispick_test/components/auth_text_field.dart';
import 'package:unnispick_test/components/rounded_button.dart';

class PhoneNumberModal extends StatefulWidget {
  const PhoneNumberModal(
      {super.key, required this.buttonTitle, required this.onPressed});

  // final variables
  final String buttonTitle;
  final Function onPressed;

  @override
  State<PhoneNumberModal> createState() => _PhoneNumberModalState();
}

class _PhoneNumberModalState extends State<PhoneNumberModal> {
  // states
  String phoneNumber = '';

  // events

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 36.0,
              vertical: 30.0,
            ),
            decoration: BoxDecoration(
                color: Colors.blueGrey[700],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
            child: Column(
              children: [
                AuthTextField(
                  label: 'Phone Number',
                  onChanged: (val) => {phoneNumber = val},
                  placeholder: 'example: +6281234567890',
                ),
                RoundedButton(
                    title: widget.buttonTitle,
                    onPressed: () => widget.onPressed(phoneNumber))
              ],
            )));
  }
}
