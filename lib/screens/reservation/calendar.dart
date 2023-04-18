import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logos/providers/client_provider.dart';
import 'package:logos/screens/reservation/checkout.dart';
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
  DateTime? _selectedDay = DateTime.now();
  String? day;
  String saat = DateFormat('HH:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 21, right: 21).r,
      child: Column(
        children: [
          TableCalendar(
            /*  enabledDayPredicate: (day) =>
                !(day.weekday == 6 || day.weekday == 7),*/
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
                      DateFormat('yyyy.MM.dd').format(_selectedDay!);

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
              var daySpecificTimeList = snapshot.data as List<String>?;
              String today = DateFormat('yyyy.MM.dd').format(DateTime.now());

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(daySpecificTimeList.toString()),
                              Text(
                                day ??
                                    DateFormat('dd.MM.yyyy')
                                        .format(DateTime.now())
                                        .toString(),
                              ),
                              SizedBox(width: 5.w),
                              Text(saat),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TimeButton(
                                time1: '09.00',
                                time2: '10.00',
                                timeList: daySpecificTimeList,
                                psycid: widget.psycId,
                                resDate: day ?? today,
                                currentTime: saat,
                              ),
                              TimeButton(
                                time1: '10.00',
                                time2: '11.00',
                                timeList: daySpecificTimeList,
                                psycid: widget.psycId,
                                resDate: day ?? today,
                                currentTime: saat,
                              ),
                              TimeButton(
                                time1: '11.00',
                                time2: '12.00',
                                timeList: daySpecificTimeList,
                                psycid: widget.psycId,
                                resDate: day ?? today,
                                currentTime: saat,
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
                                psycid: widget.psycId,
                                resDate: day ?? today,
                                currentTime: saat,
                              ),
                              TimeButton(
                                time1: '13.00',
                                time2: '14.00',
                                timeList: daySpecificTimeList,
                                psycid: widget.psycId,
                                resDate: day ?? today,
                                currentTime: saat,
                              ),
                              TimeButton(
                                time1: '14.00',
                                time2: '15.00',
                                timeList: daySpecificTimeList,
                                psycid: widget.psycId,
                                resDate: day ?? today,
                                currentTime: saat,
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
                                psycid: widget.psycId,
                                resDate: day ?? today,
                                currentTime: saat,
                              ),
                              TimeButton(
                                time1: '16.00',
                                time2: '17.00',
                                timeList: daySpecificTimeList,
                                psycid: widget.psycId,
                                resDate: day ?? today,
                                currentTime: saat,
                              ),
                              TimeButton(
                                time1: '17.00',
                                time2: '18.00',
                                timeList: daySpecificTimeList,
                                psycid: widget.psycId,
                                resDate: day ?? today,
                                currentTime: saat,
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
    String today = DateFormat('yyyy.MM.dd').format(DateTime.now());
    List<String> empty = [];
    List<String> resTimes = [];
    var response = await http
        .post(Uri.parse("$root/reservation/lookup_doktor/${id}"), headers: {
      "x-access-token": clientToken,
    }, body: {
      "day": day ?? today,
    });
    print(response.body);
    var data = jsonDecode(response.body);
    if (data["status"] == false) {
      return empty;
    }
    for (int i = 0; i < data["result"].length; i++) {
      resTimes.add(data["result"][i]["time"]);
    }
    return resTimes;
  }
}

class TimeButton extends StatefulWidget {
  final String resDate;
  final String time1;
  final String time2;
  final String psycid;
  final String currentTime;

  final List<String>? timeList;
  const TimeButton({
    Key? key,
    required this.time1,
    required this.time2,
    required this.timeList,
    required this.psycid,
    required this.resDate,
    required this.currentTime,
  }) : super(key: key);

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  String today = DateFormat('yyyy.MM.dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    DateTime date1 = DateTime.parse(widget.resDate.replaceAll(".", "-"));
    String formattedDate1 = DateFormat("yyyy-MM-dd").format(date1);
    DateTime date2 = DateTime.parse(today.replaceAll(".", "-"));
    String formattedDate2 = DateFormat("yyyy-MM-dd").format(date2);
    DateTime date1formatted =
        DateTime.parse(formattedDate1.replaceAll(".", "-"));
    DateTime date2formatted =
        DateTime.parse(formattedDate2.replaceAll(".", "-"));
    List<String> parts = widget.currentTime.split(":");
    String formatted = "${parts[0]}.${parts[1]}";
    double currentTime = double.parse(formatted);
    double saat1 = double.parse(widget.time1);

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.timeList!.contains(widget.time1)
              ? null
              : Navigator.of(context)
                  .pushNamed(CheckoutScreen.routeName, arguments: {
                  "time1": widget.time1,
                  "time2": widget.time2,
                  "psyc": widget.psycid,
                  "date": widget.resDate,
                });
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.timeList!.contains(widget.time1) ||
                    date1formatted.isAtSameMomentAs(date2formatted) &&
                        currentTime > saat1
                ? Colors.black.withOpacity(0.35)
                : Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: FittedBox(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 20, bottom: 20, right: 15),
              child: Text(
                "${widget.time1} - ${widget.time2}",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500),
              ),
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
