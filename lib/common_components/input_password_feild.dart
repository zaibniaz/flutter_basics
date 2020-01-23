import 'package:flutter/material.dart';
import 'package:mvvm_flutter_provider/utils/utils_methods.dart';

class InputPasswordField extends StatefulWidget {
  @override
  _InputPasswordFieldState createState() => _InputPasswordFieldState();

  final Function(String) onPasswordEntered;

  InputPasswordField({@required this.onPasswordEntered});
}

class _InputPasswordFieldState extends State<InputPasswordField>
    with UtilsMethods {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: _toggle,
        ),
      ),
      obscureText: _obscureText,
      style: TextStyle(
          fontSize: 17.0, fontFamily: 'sfui_text', fontWeight: FontWeight.w300),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      validator: validatePassword,
      onChanged: (String val) => widget.onPasswordEntered(val),
    );
  }
}
