import 'package:flutter/material.dart';
import 'package:gesplai/models/event.dart';
import 'package:gesplai/screens/act_not/add_activity_screen.dart';
import 'package:gesplai/screens/act_not/widgets/event_card.dart';
import 'package:gesplai/screens/widgets/no_esplai_screen.dart';
import 'package:gesplai/screens/widgets/no_not_act_screen.dart';
import 'package:gesplai/services/events_service.dart';
import 'package:gesplai/services/user_service.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class ActNotListScreen extends StatefulWidget {
  final String userId;
  const ActNotListScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ActNotListScreen> createState() => _ActNotListScreenState();
}

class _ActNotListScreenState extends State<ActNotListScreen> {
  late String _idEsplai;
  bool displayEvents = false;
  bool isEsplai = false;

  Future<void> getIdEsplai() async {
    User _user = (await UserService.getUser())!;
    if (_user.isEsplai) {
      setState(() {
        _idEsplai = _user.userId;
        displayEvents = true;
        isEsplai = true;
      });
    } else if (_user.idEsplai == '') {
      setState(() {
        displayEvents = false;
        _idEsplai = '';
        isEsplai = false;
      });
    } else {
      setState(() {
        _idEsplai = _user.idEsplai!;
        displayEvents = true;
        isEsplai = false;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getIdEsplai();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventsService = Provider.of<EventsService>(context);
    return SafeArea(
      child: displayEvents
          ? Scaffold(
              /*floatingActionButton: Visibility(
                visible: isEsplai,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddActivityScreen(),
                      ),
                    );
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.add),
                ),
              ),*/
              appBar: AppBar(
                title: const Text('Esdeveniments'),
                actions: [
                  Visibility(
                    visible: isEsplai,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddActivityScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(
                padding: const EdgeInsets.all(10),
                child: StreamBuilder<List<Event>>(
                  stream: EventsService.getEvents(_idEsplai),
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
                            return const NoNotActScreen();
                          } else {
                            return (ListView.builder(
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                final event = events[index];
                                return SizedBox(
                                  child: EventCard(
                                    title: event.title,
                                    description: event.description,
                                    idEsplai: _idEsplai,
                                    isEsplai: isEsplai,
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
            )
          : const NoEsplaiScreen(),
    );
  }
}
