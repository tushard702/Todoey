import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:todoeyflutter/widgets/roundButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'task_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class LandingScreen extends StatefulWidget {
  static String id = 'LandingScreen';

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _auth = FirebaseAuth.instance;
  bool show = true;

  void getCurrentUser() async {
    final user = await _auth.currentUser();
    if (user != null) {
      setState(() {
        show = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  totalRepeatCount: 1,
                  speed: Duration(milliseconds: 500),
                  text: ['Todoey'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            if (show)
              RoundButton(
                buttonText: 'Log In',
                onButtonTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                buttonColor: Colors.lightBlueAccent,
              ),
            if (show)
              RoundButton(
                buttonText: 'Register',
                onButtonTap: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                buttonColor: Colors.blueAccent,
              ),
            if (!show)
              RoundButton(
                buttonText: 'get in!',
                onButtonTap: () {
                  Navigator.pushNamed(context, TaskScreen.id);
                },
                buttonColor: Colors.blueAccent,
              ),
          ],
        ),
      ),
    );
  }
}
