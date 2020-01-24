import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvm_flutter_provider/models/user.dart';
import 'package:mvvm_flutter_provider/utils/constants.dart';
import 'package:mvvm_flutter_provider/utils/shared_preference_helper.dart';

import '../login_screen.dart';



class ProfileView extends StatefulWidget {
  @override
  _ProfieleViewState createState() => _ProfieleViewState();
}

class _ProfieleViewState extends State<ProfileView> {
  User userLoad = new User();

  Future funcThatMakesAsyncCall() async {
    var result =
        await SharedPreferenceHelper.getStringValue(Constants.USER_OBJECT);
    Map valueMap = json.decode(result);
    User user = User.fromJson(valueMap);
    print(result);
    setState(() {
      userLoad = user;
      print(userLoad.name);
    });
  }

  @override
  void initState() {
    super.initState();
    funcThatMakesAsyncCall();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    AssetImage _assetImage = AssetImage('images/ic_launcher.png');

    File _image;

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);

      setState(() {
        _image = image;
      });
    }

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://media-exp1.licdn.com/dms/image/C5603AQGk5fj-H2lZVw/profile-displayphoto-shrink_200_200/0?e=1585180800&v=beta&t=itI_5g2k_Ajs24CtqVUIe6ZRN6fDa6QimBi71SIjZVs'),
                ),
              ),
              SizedBox(height: 10),
              Text(
                userLoad?.name ?? '',
                style: TextStyle(
                    fontFamily: 'shui_text',
                    fontWeight: FontWeight.w700,
                    fontSize: 25.0),
              ),
              SizedBox(height: 10),
              Text(
                'I hav been working as an Android Engineer, now learning flutter for building cross platform Apps.',
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'shui_text',
                    fontWeight: FontWeight.w300,
                    fontSize: 20.0),
              ),
              Divider(
                height: _height / 30,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('343'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Posts')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('343233'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Folowers')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('34323'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Following')
                    ],
                  )
                ],
              ),
              Divider(
                height: _height / 30,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              ButtonTheme(
                minWidth: _width,
                child: RaisedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Log Out'),
                  onPressed: () => logout(_scaffoldKey),
                  elevation: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  logout(GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: new Text('Logging Out!'),
    ));
    SharedPreferenceHelper.clearPrefernces();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext ctx) => LoginScreen(title: 'Login UI')));
  }
}
