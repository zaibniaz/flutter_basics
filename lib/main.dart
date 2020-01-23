import 'package:flutter/material.dart';
import 'package:mvvm_flutter_provider/profile_view.dart';
import 'package:mvvm_flutter_provider/utils/constants.dart';
import 'package:mvvm_flutter_provider/utils/shared_preference_helper.dart';

import 'login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: SharedPreferenceHelper.getBooleanValue(
            Constants.USER_IS_LOOGED_IN,
          ),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data
                  ? ProfileView()
                  : LoginScreen(title: 'Login UI');
            }
            return Container(); // noop, this builder is called again when the future completes
          },
        ));
    //home: LoginScreen(title: 'Login UI'),
  }
}
