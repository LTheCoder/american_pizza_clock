//login screen
import 'package:flutter/material.dart';

import 'Clock.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  _Login_Screen createState() => _Login_Screen();
}

class _Login_Screen extends State<Login_Screen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // name input
            //just space
            const SizedBox(height: 20),
            Center(
                child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) => _email = value,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return "worked!";
                      },
                    ))),
            // submit button (login)
            Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // open new screen
                  if (_email == "") {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text("name is empty"),
                              content: const Text("pleast type your name"),
                              actions: [
                                TextButton(
                                  child: const Text('Approve'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Clock(
                                name: _email,
                              )),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
