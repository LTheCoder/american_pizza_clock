// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:american_pizza_clock/Helper/Employee.dart';
import 'package:american_pizza_clock/windows/Login_Screen.dart';
import 'package:american_pizza_clock/windows/detailview.dart';
import "package:flutter/material.dart";
import '../Helper/DB.dart';

class Clock extends StatefulWidget {
  final String name;
  const Clock({Key? key, required this.name}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Clock> createState() => _Clock(name);
}

class _Clock extends State<Clock> {
  // ignore: no_leading_underscores_for_local_identifiers
  _Clock(String _name) {
    name = _name;
  }
  Employee user = Employee();
  DateTime _dateTime = DateTime.now();
  String _timeString = "";
  bool pressed = false;
  String name = "";
  String stringtointhours = "";
  String stringtointclocked = "";
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user.name = name;
    if (isUserexist(user.name)) {
      user.setId1(user.name);
      user.checked = getdata(user.id, 'checked');
      stringtointhours = getdata(user.id, 'hours');
      //user.hours = int.parse(stringtointhours);
      stringtointclocked = getdata(user.id, 'clocked');
      //user.clocked = int.parse(stringtointclocked);
      //print(user.checked.toString());
      //print("${user.clocked.toString()} , ${user.hours} , ${user.checked.toString()}");
    } else {
      user.id = saveUser(user);
    }
    return Scaffold(
      drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Calander'),
            // onTap: () async {
            //   await Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => First_Screen(email: user.email)));
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Calendar(user: user)));
            },
          ),
        ],
      )),
      appBar: AppBar(
        title: const Text('Clock'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Login_Screen()));
              },
              child: const Text("Logout")),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_timeString, style: const TextStyle(fontSize: 30)),
            //just space
            const SizedBox(height: 20),
            //text field
            Text('Welcome to American Pizza $name'),
            const SizedBox(height: 20),
            //clock in button
            ElevatedButton(
              child: const Text('Clock In'),
              onPressed: () {
                if (user.checked == 'false') {
                  pressed = true;
                  _dateTime = DateTime.now();
                  user.name = name;
                  user.checked = 'true';
                  addEvent(user, "start", _dateTime, user.clocked);
                  user.clocked += 1;
                  updateuser(user.name, 'clocked', user.clocked.toString());
                } else {
                  //already clocked in pop up
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text("already clocked in"),
                            content: const Text("you have already clocked in"),
                            actions: [
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ));
                }
              },
            ),
            //just space
            const SizedBox(height: 20),
            //clock out button
            ElevatedButton(
              child: const Text('Clock Out'),
              onPressed: () {
                if (user.checked == 'true') {
                  pressed = false;
                  user.name = name;
                  user.checked = 'false';
                  addEvent(user, "end", _dateTime, user.clocked);
                  updateuser(user.name, "checked", user.checked.toString());
                } else {
                  //you need to clock in first
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text("you need to clock in first"),
                            content: const Text("you have to clock in first"),
                            actions: [
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _getCurrentTime() {
    if (!pressed) {
      setState(() {
        _timeString =
            "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
      });
    } else {
      setState(() {
        _timeString =
            "${DateTime.now().hour - _dateTime.hour} : ${DateTime.now().minute - _dateTime.minute} :${DateTime.now().second}";
      });
    }
  }
}
