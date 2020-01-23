import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  @override
  _InputFieldState createState() => _InputFieldState();

  final Function(String) onValueEntered;
  final String hint;
  final String Function(String) validator;
  final TextInputType textInputType;
  final Icon fieldIcon;

  InputField(
      {@required this.hint,
      @required this.onValueEntered,
      @required this.validator,
      @required this.textInputType,
      @required this.fieldIcon});
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: widget.fieldIcon,
        hintText: widget.hint,
      ),
      style: TextStyle(
          fontSize: 17.0, fontFamily: 'sfui_text', fontWeight: FontWeight.w300),
      keyboardType: widget.textInputType,
      textInputAction: TextInputAction.done,
      validator: widget.validator,
      onChanged: (String val) => widget.onValueEntered(val),
    );
  }
}
