import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../consts/colors.dart';
import 'calendar.dart';

extension DateTimeExt on DateTime {
  DateTime get monthStart => DateTime(year, month);
  DateTime get dayStart => DateTime(year, month, day);

  DateTime addMonth(int count) {
    return DateTime(year, month + count, day);
  }

  bool isSameDate(DateTime date) {
    return year == date.year && month == date.month && day == date.day;
  }

  bool get isToday {
    return isSameDate(DateTime.now());
  }
}

class CustomYearCalendar extends StatefulWidget {
  const CustomYearCalendar({super.key});

  @override
  State<CustomYearCalendar> createState() => _CustomYearCalendarState();
}

class _CustomYearCalendarState extends State<CustomYearCalendar> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var selectDate = ref.watch(selectDateProvider)[0];

      return Scaffold(
          backgroundColor: appBackgroundColor,
          appBar: AppBar(
            backgroundColor: appBackgroundColor,
            surfaceTintColor: appBackgroundColor,
            leading: IconButton(iconSize:28, icon: const Icon(Icons.close_outlined,color: Color(0xffBCBCBF),),
              onPressed: () { Navigator.pop(context);},),
            actions: [
              TextButton(
                  onPressed: () {
                    ref.read(selectDateProvider.notifier).state = [dateNow];
                    // setState(() {
                    //   if (_scrollController.offset.abs() > 50) _scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                    // });
                  },
                  child: const Text('Сегодня',style: TextStyle(fontSize: 17)))
            ],
          ),
          body: Column(
            children: [
              Center(child: Text(selectDate.year.toString(), style: const TextStyle(fontSize: 26,color: Color(0xff4C4C69),fontWeight: FontWeight.w800),),),
              const SizedBox(height: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                      ),
                    itemCount: 12,
                    itemBuilder: (context,index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(toBeginningOfSentenceCase(DateFormat('MMMM', 'ru').format(DateTime(selectDate.year, index+1))),
                              style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w700, color: Color(0xff4C4C69)),),
                            const SizedBox(height: 10),
                            Expanded(
                                child: _BuildMouth(
                                  selectedMonth: DateTime(selectDate.year, index+1),
                                  selectedDate: selectDate,
                                  selectDate: (DateTime value) {  },
                                )
                            ),
                          ],
                        );
                    }

                  ),
                ),
              ),
            ],
          )
      );

    });
  }
}

class _BuildMouth extends StatelessWidget {
  const _BuildMouth({
    required this.selectedMonth,
    required this.selectedDate,
    required this.selectDate,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> selectDate;

  @override
  Widget build(BuildContext context) {
    var data = CalendarMonthData(
      year: selectedMonth.year,
      month: selectedMonth.month,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var week in data.weeks)
          Expanded(
            child: Row(
              children: week.map((d) {
                return Expanded(
                  child: _RowItem(
                    hasRightBorder: false,
                    date: d.date,
                    isActiveMonth: d.isActiveMonth,
                    onTap: () => selectDate(d.date),
                    isSelected: selectedDate != null &&
                        selectedDate!.isSameDate(d.date),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class _RowItem extends StatelessWidget {
  const _RowItem({
    required this.hasRightBorder,
    required this.isActiveMonth,
    required this.isSelected,
    required this.date,
    required this.onTap,
  });

  final bool hasRightBorder;
  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final int number = date.day;
    final isToday = date.isToday;
    final bool isPassed = date.isBefore(DateTime.now());

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        height: 35,
        decoration: isSelected
            ? const BoxDecoration(color: Color.fromRGBO(255, 135, 2, 0.25), shape: BoxShape.circle)
            : isToday
            ? BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
            color: const Color.fromRGBO(255, 135, 2, 0.25),
          ),
        )
            : null,
        child: Text(
          number.toString(),
          style: TextStyle(
              fontSize: 14,
              color: isPassed
                  ? isActiveMonth
                  ? const Color(0xff4C4C69)
                  : Colors.transparent
                  : isActiveMonth
                  ? const Color(0xff4C4C69)
                  : Colors.transparent),
        ),
      ),
    );
  }
}

class CalendarMonthData {
  final int year;
  final int month;

  int get daysInMonth => DateUtils.getDaysInMonth(year, month);
  int get firstDayOfWeekIndex => 0;

  int get weeksCount => 6;//((daysInMonth + firstDayOffset) / 7).ceil();

  const CalendarMonthData({
    required this.year,
    required this.month,
  });

  int get firstDayOffset {
    final int weekdayFromMonday = DateTime(year, month).weekday - 2; ///

    return (weekdayFromMonday - ((firstDayOfWeekIndex - 1) % 7)) % 7 ;
  }

  List<List<CalendarDayData>> get weeks {
    final res = <List<CalendarDayData>>[];
    var firstDayMonth = DateTime(year, month, 1);
    var firstDayOfWeek = firstDayMonth.subtract(Duration(days: firstDayOffset));

    for (var w = 0; w < weeksCount; w++) {
      final week = List<CalendarDayData>.generate(
        7,
            (index) {
          final date = firstDayOfWeek.add(Duration(days: index));

          final isActiveMonth = date.year == year && date.month == month;

          return CalendarDayData(
            date: date,
            isActiveMonth: isActiveMonth,
            isActiveDate: date.isToday,
          );
        },
      );
      res.add(week);
      firstDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    }
    return res;
  }
}

class CalendarDayData {
  final DateTime date;
  final bool isActiveMonth;
  final bool isActiveDate;

  const CalendarDayData({
    required this.date,
    required this.isActiveMonth,
    required this.isActiveDate,
  });
}
