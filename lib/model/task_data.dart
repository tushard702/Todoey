import 'task.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskData extends ChangeNotifier {
  Firestore _fireStore = Firestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentReference userReference;
  var uid;
  var task = [];
  List<Task> tasks = [];
  bool first = false;

  TaskData() {
    _populateTasks();
  }

  _populateTasks() async {
    await _setUID();

    if (uid == null) {
      first = true;
    } else {
      _setTasks();
    }
  }

  _setTasks() {
    userReference = _fireStore.collection('users').document(uid);

    userReference.get()
      ..then((value) {
        if (value.data['tasks'] == null) {
          userReference.setData({'tasks': task});
        } else {
          for (var data in value.data['tasks']) {
            tasks.add(Task(name: data));
            task.add(data);
          }
        }
      });

    notifyListeners();
  }

  _setUID() async {
    FirebaseUser user = await _getCurrentUser();
    uid = user.uid;
  }

  _getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  void addTasks(String taskName) async {
    tasks.add(Task(name: taskName));
    task.add('$taskName');

    //app run for first time
    if (first) {
      //init firebase
      _fireStore = Firestore.instance;
      _auth = FirebaseAuth.instance;
      await _setUID();

      //init document reference
      _setTasks();

      //add data
      //userReference.setData({'tasks': task});

      //update first
      first = false;
    } else {
      //update data
      userReference.updateData({
        'tasks': FieldValue.arrayUnion([taskName])
      });
    }

    notifyListeners();
  }

  int get taskCount {
    return tasks.length;
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    userReference.updateData({
      'tasks': FieldValue.arrayRemove([task[index]])
    });
    task.removeAt(index);
    notifyListeners();
  }
}
