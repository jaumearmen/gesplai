import 'package:flutter/material.dart';
import 'package:gesplai/models/event.dart';
import 'package:gesplai/screens/act_not/add_activity_screen.dart';
import 'package:gesplai/screens/act_not/event_detail_screen.dart';
import 'package:gesplai/services/events_service.dart';
import 'package:gesplai/globals.dart' as globals;
import 'package:provider/provider.dart';

class ActNotListScreen extends StatefulWidget {
  const ActNotListScreen({Key? key}) : super(key: key);

  @override
  State<ActNotListScreen> createState() => _ActNotListScreenState();
}

class _ActNotListScreenState extends State<ActNotListScreen> {
  @override
  Widget build(BuildContext context) {
    final eventsService = Provider.of<EventsService>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddActivityScreen()),
            );
          },
          backgroundColor: globals.COLOR_BLUE,
          child: const Icon(Icons.add),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder<List<Event>>(
            stream: EventsService.getEvents(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(
                        child: Text('Something Went Wrong Try later'));
                  } else {
                    final events = snapshot.data;

                    if (events!.isEmpty) {
                      return const Center(child: Text('No Users Found'));
                    } else {
                      return (ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          return SizedBox(
                            height: 75,
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EventDetailScreen(
                                      title: event.title,
                                      description: event.description,
                                    ),
                                  ),
                                );
                              },
                              title: Text(event.title),
                            ),
                          );
                        },
                      ));
                    }
                  }
              }
            },
          ),
          /*child: ListView.builder(
            itemCount: events.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  EventCard(
                    title: events[index].title,
                    description: events[index].description,
                  ),
                  addVerticalSpace(10),
                ],
              );
            }),
          ),
        ),*/
        ),
      ),
    );
  }
}
