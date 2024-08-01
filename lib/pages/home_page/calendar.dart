import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../states/mood_notes.dart';


DateTime d = DateTime.now();
DateTime dateNow = DateTime(d.year, d.month, d.day);

final selectDateProvider = StateProvider<List<DateTime?>>((ref) => [dateNow]);

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var moodNotes = ref.watch(moodNotesProvider);
        return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      ref.read(selectDateProvider.notifier).state = [dateNow];
                      setState(() {
                        if (_scrollController.offset.abs() > 200) _scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                      });
                    },
                    child: const Text('Сегодня'))
              ],
              backgroundColor: Colors.white,
            ),
            body: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarViewMode: CalendarDatePicker2Mode.scroll,
                scrollViewController: _scrollController,
                dynamicCalendarRows: false,
                weekdayLabels: ['вс', 'пн', 'вт', 'ср', 'чт', 'пт', 'сб'],
                weekdayLabelTextStyle:
                    const TextStyle(fontSize: 16, color: Colors.black38),
                firstDayOfWeek: 1,
                dayTextStyle: const TextStyle(fontSize: 16),
                selectedDayTextStyle: const TextStyle(fontSize: 16),
                selectedDayHighlightColor: Colors.orange[200],
                daySplashColor: Colors.orange[100],
                hideScrollViewTopHeaderDivider: true,
                hideScrollViewMonthWeekHeader: true,
                scrollViewMonthYearBuilder: <Widget>(date) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          DateFormat('y').format(date),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black38),
                        ),
                        Text(
                          toBeginningOfSentenceCase(
                              DateFormat('MMMM', 'ru').format(date)),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
                dayBuilder: ({
                  required date,
                  textStyle,
                  decoration,
                  isSelected,
                  isDisabled,
                  isToday,
                }) {
                  Widget? dayWidget;

                  if (moodNotes[date] != null ) {
                    dayWidget = Container(
                      decoration: decoration,
                      child: Center(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Text(
                              MaterialLocalizations.of(context)
                                  .formatDecimal(date.day),
                              style: textStyle,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 27.5),
                              child: Container(
                                height: 6,
                                width: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: isSelected == true
                                      ? Colors.red
                                      : Colors.grey[500],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return dayWidget;
                },
              ),
              value: ref.watch(selectDateProvider),
              onValueChanged: (date) {
                ref.read(selectDateProvider.notifier).state = date;
              },
            ));
      },
    );
  }
}
