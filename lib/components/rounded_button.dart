import 'package:flutter/material.dart';
import 'package:unnispick_test/constans.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key, this.color, required this.onPressed, this.title});

  // variables
  final void Function() onPressed;
  final Color? color;
  final String? title;
  // events

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color ?? Colors.purpleAccent,
        borderRadius: BorderRadius.circular(12.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: double.infinity,
          height: 54.0,
          child: Text(
            title ?? '',
            style: kPrimaryTextStyle.copyWith(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
