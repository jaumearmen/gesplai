import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:gesplai/models/user.dart';
import 'package:gesplai/screens/attendance/attendance_screen.dart';
import 'package:gesplai/screens/widgets/no_esplai_screen.dart';
import 'package:gesplai/services/user_service.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  final String userId;
  const CalendarScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var selectedDay;
  var selectedEvent;
  String _idEsplai = '';
  bool teEsplai = false;
  bool esEsplai = false;

  Future<void> getUser() async {
    User? aux = await UserService.getUser();
    if (aux!.isEsplai) {
      setState(() {
        _idEsplai = aux.userId;
        esEsplai = true;
      });
    } else if (aux.idEsplai == '') {
      setState(() {
        _idEsplai = '';
        teEsplai = false;
      });
    } else {
      setState(() {
        _idEsplai = aux.idEsplai!;
        teEsplai = true;
      });
    }
  }

  final Map<DateTime, List<CleanCalendarEvent>> events = {
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

  final List<CleanCalendarEvent> _selectedEvents = [
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
  ];

  void _handleData(date) {
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }

  @override
  void initState() {
    getUser();
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
        title: Text('Calendar'),
        centerTitle: true,
      ),*/
        body: teEsplai || esEsplai
            ? SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Calendar(
                    startOnMonday: true,
                    selectedColor: Colors.blue,
                    todayColor: Colors.red,
                    eventColor: Colors.green,
                    eventDoneColor: Colors.amber,
                    bottomBarColor: Colors.deepOrange,
                    onRangeSelected: (range) {
                      print('selected Day ${range.from},${range.to}');
                    },
                    onDateSelected: (date) {
                      return _handleData(date);
                    },
                    events: events,
                    isExpandable: true,
                    isExpanded: true,
                    dayOfWeekStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.black12,
                      fontWeight: FontWeight.w100,
                    ),
                    bottomBarTextStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    hideBottomBar: false,
                    hideArrows: false,
                    weekDays: const [
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat',
                      'Sun'
                    ],
                    onEventSelected: (_selectedEvents) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AttendanceScreen(),
                        ),
                      );
                    },
                  ),
                ),
              )
            : const NoEsplaiScreen());
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (BuildContext context, int index) {
          final CleanCalendarEvent event = _selectedEvents[index];
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
        itemCount: _selectedEvents.length,
      ),
    );
  }
}
