import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../providers/all_psyc_provider.dart';

class ReservationCalendar extends StatelessWidget {
  static const routeName = "/reservation_calendar";
  const ReservationCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final provider =
        Provider.of<All_Psychologists_Provider>(context).findById(args["id"]);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 65, left: 33, right: 33).r,
            child: const Header(),
          ),
          const CustomCalendar()
        ],
      ),
    );
  }
}

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21, right: 21).r,
      child: TableCalendar(
        enabledDayPredicate: (day) => !(day.weekday == 6 || day.weekday == 7),
        daysOfWeekVisible: true,
        headerStyle: HeaderStyle(
          leftChevronIcon: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffF4F5F7), width: 1)),
            child: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
          ),
          rightChevronIcon: Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xffF4F5F7), width: 1)),
            child: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
          ),
          formatButtonVisible: false,
          titleCentered: true,
        ),
        locale: 'tr_TR',
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.symmetric(horizontal: 11, vertical: 7).r,
          markerSize: 22,
          todayDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff6B337F).withOpacity(0.3),
          ),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xff6B337F),
            borderRadius: BorderRadius.circular(10),
          ),
          defaultDecoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          weekendDecoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          holidayDecoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          outsideDecoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          withinRangeDecoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          rangeStartDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(4),
          ),
          rangeEndDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(4),
          ),
          rangeHighlightColor: Colors.red,
          weekendTextStyle: Theme.of(context).textTheme.bodyText2!,
          defaultTextStyle: Theme.of(context).textTheme.bodyText2!,
        ),
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              print(_selectedDay);
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left),
        ),
        Text(
          "Randevu Detayları",
          style: TextStyle(fontSize: 15.sp),
        ),
        SizedBox(width: 42.w),
      ],
    );
  }
}
