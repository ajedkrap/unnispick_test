import 'dart:ui';
import 'package:flutter/material.dart';

class Glassmorph extends StatelessWidget {
  const Glassmorph({super.key, required this.children});

  // variables
  final Widget children;

  // events

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Stack(children: [
          Stack(
            children: <Widget>[
              Positioned(
                  right: -12.0,
                  top: -8.0,
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(166, 196, 175, 255),
                        borderRadius: BorderRadius.circular(400.0)),
                  )),
              Positioned(
                  left: -90.0,
                  top: screenHeight / 4,
                  child: Container(
                    height: 450.0,
                    width: 180.0,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(148, 128, 203, 195),
                        borderRadius: BorderRadius.circular(400.0)),
                  )),
              Positioned(
                  left: 2.0,
                  bottom: -24.0,
                  child: Container(
                    height: 140.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.circular(400.0)),
                  ))
            ],
          ),
          ClipRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
                  child: children))
        ]);
  }
}
