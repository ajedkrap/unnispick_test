import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({super.key, required this.icon, required this.onPressed});

  // variables
  final IconData icon;
  final Function onPressed;

  // events

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
            onTap: () => onPressed(),
            child: Card(
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        border: Border.all(color: const Color.fromARGB(255, 86, 86, 86))),
                    child: Center(
                      child: FaIcon(
                        icon,
                        color: Colors.white,
                      ),
                    )))));
  }
}
