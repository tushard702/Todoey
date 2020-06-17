import 'package:flutter/material.dart';
import 'package:todoeyflutter/model/task_data.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';

import 'package:todoeyflutter/screen/landing_screen.dart';

class AddTaskScreen extends StatelessWidget {
  static String newTaskName;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21),
            topRight: Radius.circular(21),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Add Task',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    onChanged: (newVal) {
                      newTaskName = newVal;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (newTaskName != null) {
                        Provider.of<TaskData>(context, listen: false)
                            .addTasks(newTaskName);
                      }

                      Navigator.pop(context);
                    },
                    color: Colors.lightBlueAccent,
                    textColor: Colors.white,
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              child: GestureDetector(
                onLongPress: () {
                  _auth.signOut();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, LandingScreen.id);
                  _auth.signOut();
                },
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
