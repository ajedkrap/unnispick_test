import 'package:flutter/material.dart';

const kBorderColor = Color.fromARGB(255, 86, 86, 86);

const kLabelTextStyle = TextStyle(
    color: Colors.white60, decorationColor: Colors.white60, fontSize: 12.0);
const kPrimaryTextStyle =
    TextStyle(color: Colors.white, decorationColor: Colors.white);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color.fromARGB(255, 38, 50, 56),
  hintStyle: TextStyle(color: Colors.white38),
  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kBorderColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kBorderColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);
