import 'package:flutter/material.dart';

class AttendanceCard extends StatefulWidget {
  final String name;
  /*final String idEsplai;*/
  final bool vaEsplai;
  final int index;
  const AttendanceCard(
      {Key? key,
      required this.name,
      required this.vaEsplai,
      /*required this.idEsplai,*/
      required this.index})
      : super(key: key);

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: 75,
          child: Row(
            children: [
              const SizedBox(width: 20),
              const Icon(
                Icons.photo,
                color: Colors.grey,
                size: 35,
              ),
              const SizedBox(width: 20),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Switch(
          value: widget.vaEsplai,
          onChanged: (value) {
            setState(() {});
            /*AttendanceService.updateAttendance(
                widget.idEsplai, widget.vaEsplai, widget.index);*/
          },
        )
      ],
    );
  }
}
