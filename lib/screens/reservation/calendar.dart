import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../providers/all_psyc_provider.dart';
import 'package:http/http.dart' as http;

import '../forgot_pass/email_OTP.dart';

class ReservationCalendar extends StatelessWidget {
  static const routeName = "/reservation_calendar";
  const ReservationCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final client = Provider.of<ClientProvider>(context).get_client;
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
          CustomCalendar(
            psycId: args["id"],
            clientToken: client.token.toString(),
          ),
        ],
      ),
    );
  }
}

class CustomCalendar extends StatefulWidget {
  final String psycId;
  final String clientToken;

  const CustomCalendar({
    Key? key,
    required this.psycId,
    required this.clientToken,
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? day;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21, right: 21).r,
      child: Column(
        children: [
          TableCalendar(
            enabledDayPredicate: (day) =>
                !(day.weekday == 6 || day.weekday == 7),
            daysOfWeekVisible: true,
            headerStyle: HeaderStyle(
              leftChevronIcon: Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xffF4F5F7), width: 1)),
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
                    border:
                        Border.all(color: const Color(0xffF4F5F7), width: 1)),
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
              cellMargin:
                  const EdgeInsets.symmetric(horizontal: 11, vertical: 7).r,
              markerSize: 22,
              todayDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffA950C9).withOpacity(0.3),
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xffA950C9),
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

                  String formattedDate =
                      DateFormat('dd.MM.yyyy').format(_selectedDay!);

                  day = formattedDate;
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
          FutureBuilder(
            future: getData(widget.psycId, widget.clientToken),
            builder: (context, snapshot) {
              var daySpecificTimeList = snapshot.data as List<String>;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(25).r,
                  child: Container(
                    width: 360.w,
                    height: 235.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8).r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TimeButton(
                                time1: '09.00',
                                time2: '10.00',
                                timeList: daySpecificTimeList,
                              ),
                              TimeButton(
                                time1: '10.00',
                                time2: '11.00',
                                timeList: daySpecificTimeList,
                              ),
                              TimeButton(
                                time1: '11.00',
                                time2: '12.00',
                                timeList: daySpecificTimeList,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TimeButton(
                                time1: '12.00',
                                time2: '13.00',
                                timeList: daySpecificTimeList,
                              ),
                              TimeButton(
                                time1: '13.00',
                                time2: '14.00',
                                timeList: daySpecificTimeList,
                              ),
                              TimeButton(
                                time1: '14.00',
                                time2: '15.00',
                                timeList: daySpecificTimeList,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TimeButton(
                                time1: '15.00',
                                time2: '16.00',
                                timeList: daySpecificTimeList,
                              ),
                              TimeButton(
                                time1: '16.00',
                                time2: '17.00',
                                timeList: daySpecificTimeList,
                              ),
                              TimeButton(
                                time1: '17.00',
                                time2: '18.00',
                                timeList: daySpecificTimeList,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<List<String>> getData(String id, String clientToken) async {
    List<String> resTimes = [];
    var response = await http.post(
        Uri.parse("$root/reservation/reservation/lookup_doktor/${id}"),
        headers: {
          "x-access-token": clientToken,
        },
        body: {
          "day": day,
        });
    var data = jsonDecode(response.body);

    for (int i = 0; i < data.length; i++) {
      resTimes.add(data[i]["time"]);
    }
    print(resTimes);
    return resTimes;
  }
}

class TimeButton extends StatelessWidget {
  final String time1;
  final String time2;
  final List<String> timeList;
  const TimeButton({
    Key? key,
    required this.time1,
    required this.time2,
    required this.timeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: timeList.contains(time1) ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: FittedBox(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 20, bottom: 20, right: 15),
            child: Text(
              "${time1} - ${time2}",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
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
