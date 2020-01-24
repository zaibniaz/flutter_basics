import 'package:flutter/cupertino.dart';

class UtilsMethods {
  String validateEmail(String value) {
    return !value.contains('@') ? 'invalid email' : null;
  }

  String validatePassword(String value) {
    return value.length < 8 ? 'invalid Password' : null;
  }

  String validateField(String value) {
    return value.isEmpty ? 'Field cannot be empty' : null;
  }

  Widget getBoldText(String value) {
    return Text(
      value,
      style: TextStyle(
          fontSize: 15.0, fontFamily: 'sfui_text', fontWeight: FontWeight.w700),
    );
  }
}
