import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoeyflutter/model/task_data.dart';
import 'package:todoeyflutter/screen/landing_screen.dart';
import 'screen/task_screen.dart';
import 'package:todoeyflutter/screen/login_screen.dart';
import 'package:todoeyflutter/screen/registration_screen.dart';
import 'package:todoeyflutter/screen/task_screen.dart';

void main() {
  runApp(TodoeyApp());
}

class TodoeyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        initialRoute: LandingScreen.id,
        routes: {
          LandingScreen.id: (context) => LandingScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          TaskScreen.id: (context) => TaskScreen()
        },
      ),
    );
  }
}
