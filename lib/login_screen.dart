import 'package:flutter/material.dart';
import 'package:mvvm_flutter_provider/common_components/input_field.dart';
import 'package:mvvm_flutter_provider/common_components/input_password_feild.dart';
import 'package:mvvm_flutter_provider/models/user.dart';
import 'package:mvvm_flutter_provider/profile_view.dart';
import 'package:mvvm_flutter_provider/utils/constants.dart';
import 'package:mvvm_flutter_provider/utils/shared_preference_helper.dart';
import 'package:mvvm_flutter_provider/utils/utils_methods.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with UtilsMethods {
  AssetImage assetImage = AssetImage('images/ic_launcher.png');
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _fullName;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
                child: Form(
              key: formKey,
              child: Container(
                height: _height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      height: 150,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: assetImage)),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 50,
                      child: Text(
                        'Welcome To Amplifyd',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'sfui_text',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0),
                      ),
                    ),
                    InputField(
                      hint: 'Full Name',
                      onValueEntered: (String val) => _fullName = val,
                      validator: validateField,
                      textInputType: TextInputType.text,
                      fieldIcon: Icon(Icons.person),
                    ),
                    InputField(
                        hint: 'E-mail Here',
                        onValueEntered: (String val) => _email = val,
                        validator: validateEmail,
                        textInputType: TextInputType.emailAddress,
                        fieldIcon: Icon(
                          Icons.email,
                        )),
                    InputPasswordField(
                      onPasswordEntered: (String val) => _password = val,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                            onPressed: () {
                              final bool v = formKey.currentState.validate();
                              if (v) {
                                formKey.currentState.save();
                                User user = User();
                                user.name = _fullName;
                                user.email = _email;
                                user.password = _password;

                                SharedPreferenceHelper.setBooleanValue(
                                    Constants.USER_IS_LOOGED_IN, true);
                                SharedPreferenceHelper.setStringValue(
                                    Constants.USER_OBJECT, user);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileView()));
                              }
                            },
                            child:
                                Text('Done!', style: TextStyle(fontSize: 20)),
                            color: Colors.blue,
                            textColor: Colors.white,
                            elevation: 5,
                          ),
                        ))
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
