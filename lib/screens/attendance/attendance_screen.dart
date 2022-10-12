import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<CleanCalendarEvent>? _selectedEvents = [
    CleanCalendarEvent('Event A',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 12, 0),
        description: 'A special event',
        color: Colors.blue),
  ];

  final Map<DateTime, List<CleanCalendarEvent>> _events = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue),
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
        [
      CleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],
  };

  @override
  void initState() {
    super.initState();
    // Force selection of today on first load, so that the list of today's events gets shown.
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  void _handleNewDate(DateTime date) {
    //_selectedEvents = _events[date];
    setState(() {
      _selectedEvents = _events[date];
    });
    print('Date selected: $date');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: Calendar(
            startOnMonday: true,
            weekDays: const ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'],
            events: _events,
            onRangeSelected: (range) =>
                print('Range is ${range.from}, ${range.to}'),
            onDateSelected: (date) => _handleNewDate(date),
            isExpandable: true,
            eventDoneColor: Colors.green,
            selectedColor: Colors.pink,
            todayColor: Colors.blue,
            eventColor: Colors.grey,
            locale: 'de_DE',
            todayButtonText: 'Heute',
            expandableDateFormat: 'EEEE, dd. MMMM yyyy',
            dayOfWeekStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
          ),
        ),
        Expanded(
          child: _buildEventList(),
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (BuildContext context, int index) {
          final CleanCalendarEvent event = _selectedEvents![index];
          final String start =
              DateFormat('HH:mm').format(event.startTime).toString();
          final String end =
              DateFormat('HH:mm').format(event.endTime).toString();
          return ListTile(
            contentPadding: const EdgeInsets.only(
                left: 2.0, right: 8.0, top: 2.0, bottom: 2.0),
            leading: Container(
              width: 10.0,
              color: event.color,
            ),
            title: Text(event.summary),
            subtitle:
                event.description.isNotEmpty ? Text(event.description) : null,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(start), Text(end)],
            ),
            onTap: () {},
          );
        },
        itemCount: _selectedEvents?.length,
      ),
    );
  }
}
