import 'package:flutter/material.dart';
import 'package:mosaico/help/help_page.dart';
import 'package:mosaico/home/drawer_home_page.dart';
import 'package:mosaico/utils/usertype_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);

  Size get preferredSize => const Size.fromHeight(80);
  final UserType user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: preferredSize.height,
        centerTitle: true,
        title: const Text(
          'Espaço Mosaico',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.question_mark, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HelpPage()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: _body(context)),
      endDrawer: DrawerHomePage(user: user),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(
            'Agenda',
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.grey,
        ),
        SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ),
      ],
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
