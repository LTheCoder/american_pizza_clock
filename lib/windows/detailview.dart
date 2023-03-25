// ignore_for_file: avoid_print
import 'package:american_pizza_clock/Helper/Employee.dart';
import 'package:american_pizza_clock/windows/Clock.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Helper/DB.dart';

DateTime t = DateTime.now();

class Calendar extends StatefulWidget {
  final Employee user;
  const Calendar({Key? key, required this.user}) : super(key: key);

  // ignore: empty_constructor_bodies, annotate_overrides
  Third_Screen createState() {
    // ignore: no_logic_in_create_state
    return Third_Screen(user: user);
  }
}

// ignore: camel_case_types
class Third_Screen extends State<Calendar> {
  late ValueNotifier<List<DateTime>> timerange;
  ValueNotifier<List<String>> _selectedEvents = ValueNotifier(['_value']);
  var _calendarFormat = CalendarFormat.month;
  Third_Screen({required this.user});
  final Employee user;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String what = '';

  @override
  void initState() {
    super.initState();
    selectedDay = focusedDay;
    _selectedEvents = getEventsForDay(selectedDay, user);
  }

  @override
  Widget build(BuildContext context) {
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
              title: const Text('Home Page'),
              // onTap: () async {
              //   await Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => First_Screen(email: user.email)));
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Clock(
                              name: user.name,
                            )));
              },
            ),
          ],
        )),
        appBar: AppBar(
          title: const Text('need to think of a name'),
        ),
        body: Column(children: [
          TableCalendar(
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  if (day.weekday == DateTime.sunday) {
                    const text = "Sun";
                    return const Center(
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return null;
                },
              ),
              locale: 'en_US',
              // eventLoader: (day) {
              //   return getEventsForDay(day);
              // },
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: focusedDay,
              // ignore: no_leading_underscores_for_local_identifiers
              onPageChanged: (_focusedDay) {
                focusedDay = _focusedDay;
              },
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              // ignore: no_leading_underscores_for_local_identifiers
              onDaySelected: (_selectedDay, _focusedDay) {
                setState(() {
                  selectedDay = _selectedDay;
                  focusedDay = _focusedDay;
                  // Important to clean those
                });
                _selectedEvents = getEventsForDay(selectedDay, user);
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              }),
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    if (value[index] != 'null') {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          //onTap: ,
                          title: Text(value[index]),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Add Event'),
                            content: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                    child:
                                        ValueListenableBuilder<List<DateTime>>(
                                      valueListenable: timerange,
                                      builder: (context, value, _) {
                                        return SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: value.length,
                                              itemBuilder: (context, index) {
                                                // ignore: unrelated_type_equality_checks
                                                if (value[index] != 'null') {
                                                  return Container(
                                                    padding: EdgeInsets.zero,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 12.0,
                                                      vertical: 4.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: ListTile(
                                                      //onTap: ,
                                                      onTap: () async {
                                                        t = DateTime(
                                                            selectedDay.year,
                                                            selectedDay.month,
                                                            selectedDay.day,
                                                            value[index].hour,
                                                            value[index]
                                                                .minute);
                                                      },
                                                      title: Text(
                                                          '${value[index].hour}:${value[index].minute}0'),
                                                    ),
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              },
                                            ));
                                      },
                                    ),
                                  ),
                                  // FloatingActionButton.extended(
                                  //     label: const Text('Pick Time'),
                                  //     onPressed: () async {
                                  //       final TimeOfDay? newTime =
                                  //           await showTimePicker(
                                  //         context: context,
                                  //         initialTime: TimeOfDay(
                                  //             hour: DateTime.now().hour,
                                  //             minute: DateTime.now().minute),
                                  //         initialEntryMode:
                                  //             TimePickerEntryMode.input,
                                  //       );
                                  //       if (newTime?.hour != null &&
                                  //           newTime?.minute != null) {
                                  //         t = DateTime(
                                  //             selectedDay.year,
                                  //             selectedDay.month,
                                  //             selectedDay.day,
                                  //             newTime!.hour,
                                  //             newTime.minute);
                                  //       } else {

                                  //       }
                                  //     }),
                                  TextField(
                                    onChanged: (value) => what = value,
                                    decoration:
                                        const InputDecoration(hintText: 'Name'),
                                  )
                                ]),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (user != null) {
                                    //what += ' ${t.hour.toString()}:${t.minute.toString()}';
                                    //addEvent(user, what, t);
                                    Navigator.pop(context, 'Cancel');
                                  } else {
                                    print('Error!');
                                  }
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ));
                },
                backgroundColor: Colors.lightBlue[500],
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 11),
            ],
          ),
        ]));
  }
}
