// ignore_for_file: deprecated_member_use
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'Employee.dart';
//import 'package:firebase_storage/firebase_storage.dart';

final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference saveUser(Employee profile) {
  //databaseReference.child('Users/${profile.key}').push();
  var id = databaseReference.child('Users/${profile.name.replaceAll(" ", "")}');
  id.set(profile.toJson());
  return id;
}

void addEvent(Employee user, String title, DateTime date, int times) {
  if (title == "start") {
    databaseReference
        .child(
            'hourtracker/${user.name}/${date.day.toString() + date.month.toString() + date.year.toString()}/${"start" + times.toString()}/${date.hour.toString() + date.minute.toString()}')
        .set(title);
  } else {
    databaseReference
        .child(
            'hourtracker/${user.name}/${date.day.toString() + date.month.toString() + date.year.toString()}/${"end" + times.toString()}/${date.hour.toString() + date.minute.toString()}')
        .set(title);
  }
}

// ignore: slash_for_doc_comments
/**void createCalender(Employee user) {
  String s = '';
  String ID = '';
  databaseReference
      .child('Users/${user.name}/IsBuisness')
      .onValue
      .listen((event) {
    s = event.snapshot.value.toString();
  });
  databaseReference.child('Users/${user.name}/key').onValue.listen((event) {
    ID = event.snapshot.value.toString();
  });
  print(user.name);
  if (s == 'true') {
    databaseReference.child('Calenders/Calender$ID').push();
  }
}*/

void newProfile(Employee profile) {
  profile.setId(saveUser(profile));
}

bool isUserexist(String check) {
  String s = "none";
  databaseReference.child('Users/$check').onValue.listen((event) {
    s = event.snapshot.value.toString();
  });
  if (s == "" || s == "null") {
    print('false');
    return false;
  } else {
    print('true');
    return true;
  }
}

String getdata(DatabaseReference id, String spcthing) {
  String helperpath = id.path;
  String desc = "";
  if (spcthing != "") {
    spcthing.replaceAll(" ", "");
    helperpath += "/";
    helperpath += spcthing;
  }
  // ignore: avoid_types_as_parameter_names
  databaseReference.child(helperpath).onValue.listen((event) {
    desc = event.snapshot.value.toString();
  });
  print(desc);
  return desc;
}

updateuser(String username, String toupdate, String field) {
  databaseReference.child('Users/$username').update({field: toupdate});
}

ValueNotifier<List<String>> getEventsForDay(DateTime day, Employee user) {
  String desc = "";
  List<String> temp;
  String temp2;
  List<String> _value = [];
  String temp1;
  databaseReference
      .child(
          'hourtracker/${user.name}/${day.day.toString() + day.month.toString() + day.year.toString()}')
      .onValue
      .listen((event) {
    desc = event.snapshot.value.toString();
    print(desc);
  });
  temp = desc.split(":");
  for (var i = 0; i < temp.length; i++) {
    temp1 = temp[i].replaceAll(RegExp("\\d"), "");
    temp2 = temp1.replaceAll(',', "");
    if (temp2 != "{" && temp2 != " ") {
      _value.add(temp2.replaceAll('}', ""));
    }
  }
  var levents = ValueNotifier(_value);

  return levents;
}

/**bool istimeexist(DateTime time, Employee user) {
  String s = "";
  databaseReference
      .child(
          'Calenders/${user.calenderId}/${time.day.toString() + time.month.toString() + time.year.toString()}/${time.hour.toString() + time.minute.toString()}')
      .onValue
      .listen((event) {
    s = event.snapshot.value.toString();
  });
  if (s != "null") {
    return true;
  }
  return false;
}*/
