//employees class
import 'package:firebase_database/firebase_database.dart';
import 'DB.dart';

class Employee {
  String name = "";
  String checked = "true";
  int wage = 30;
  int hours = 0;
  int clocked = 0;
  DateTime lastclocked = DateTime.now();
  late DatabaseReference _id;

  //get _id
  DatabaseReference get id => _id;
  //set _id
  set id(DatabaseReference id) => _id = id;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'wage': wage,
      'hours': hours,
      'checked': checked,
      'clocked': clocked,
      'lastclocked': lastclocked.toString(),
    };
  }

  void setId(DatabaseReference id) {
    _id = id;
  }

  void setId1(String key) {
    setId(databaseReference.child('Users/${key.replaceAll(" ", "")}'));
  }
}
