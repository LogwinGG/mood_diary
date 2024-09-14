import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_diary/pages/home_page/custom_calendar.dart';
import '../../consts/colors.dart';
import '../../repositories/mood_notes.dart';
import 'mood_note_tab/mood_note_tab.dart';


DateTime d = DateTime.now();
DateTime dateNow = DateTime(d.year, d.month, d.day);

final selectDateProvider = StateProvider<List<DateTime>>((ref) => [dateNow]);

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
        var selectDate = ref.watch(selectDateProvider);

        return PopScope(
          canPop: false,
          onPopInvoked: (_) {
            ref.read(selectDateProvider.notifier).state = [dateNow];
            var selectedDate = ref.read(selectDateProvider)[0];
            var isEditing = moodNotes.keys.contains(selectedDate);
            if( !isEditing ) clearData(ref);
            Navigator.pushNamedAndRemoveUntil(context,'/',(Route<dynamic> route) => false);
          },
          child: Scaffold(
              backgroundColor: appBackgroundColor,
              appBar: AppBar(
                backgroundColor: appBackgroundColor,
                surfaceTintColor: appBackgroundColor,
                leading: IconButton(iconSize:28, icon: const Icon(Icons.close_outlined,color: Color(0xffBCBCBF)),
                onPressed: () {
                  ref.read(selectDateProvider.notifier).state = [dateNow];
                  var selectedDate = ref.read(selectDateProvider)[0];
                  var isEditing = moodNotes.keys.contains(selectedDate);
                  if( !isEditing ) clearData(ref);
                  Navigator.pushNamedAndRemoveUntil(context,'/',(Route<dynamic> route) => false);
                },),
                actions: [
                  TextButton(
                      onPressed: (moodNotes.containsKey(selectDate[0]))? null:
                      (){
                        clearData(ref);
                        Navigator.pushNamedAndRemoveUntil(context,'/',(Route<dynamic> route) => false);
                      },
                      child: const Text('Добавить')),
                  TextButton(
                      onPressed: !(moodNotes.containsKey(selectDate[0]))? null:
                      (){
                        Navigator.pushNamedAndRemoveUntil(context,'/',(Route<dynamic> route) => false);
                      },
                      child: const Text('Подробнее')),
                  TextButton(
                      onPressed: !(moodNotes.containsKey(selectDate.first))? null:
                      () {
                        showDialog(context: context, builder: (context) => AlertDialog(
                          title: const Text('Запись будет удалена',textAlign: TextAlign.center),
                          actions: [
                          TextButton(onPressed: ()=> Navigator.pop(context),
                              child: const Text('Отмена',style: TextStyle(color:Colors.blueGrey),)),
                          TextButton(onPressed: (){
                            ref.read(moodNotesProvider.notifier).remove(dateKey: selectDate.first);
                            ref.invalidate(moodNotesProvider);
                            Navigator.pop(context);},
                              child: const Text('Ок')),],actionsAlignment: MainAxisAlignment.spaceBetween,)
                        );
                      },
                      child: const Text('Удалить')),

                  TextButton(
                      onPressed: () {
                        ref.read(selectDateProvider.notifier).state = [dateNow];
                        setState(() {
                          if (_scrollController.offset.abs() > 50) _scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                        });
                      },
                      child: const Text('Сегодня',style: TextStyle(fontSize: 17),))
                ],
              ),
              body: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarViewMode: CalendarDatePicker2Mode.scroll,

                  scrollViewController: _scrollController,
                  dynamicCalendarRows: false,
                  weekdayLabels: ['вс', 'пн', 'вт', 'ср', 'чт', 'пт', 'сб'],
                  weekdayLabelTextStyle: const TextStyle(fontSize: 18, color: Color(0xffBCBCBF)),
                  firstDayOfWeek: 1,
                  dayTextStyle: const TextStyle(fontSize: 20,color: Color(0xff4C4C69)),
                  selectedDayTextStyle: const TextStyle(fontSize: 20,color: Color(0xff4C4C69)),
                  selectedDayHighlightColor: const Color.fromRGBO(255, 135, 2, 0.25),
                  daySplashColor: null,
                  hideScrollViewTopHeaderDivider: true,
                  hideScrollViewMonthWeekHeader: true,
                  scrollViewMonthYearBuilder: <Widget>(date) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: GestureDetector(
                        onDoubleTap: (){
                          Navigator.push(context, MaterialPageRoute(fullscreenDialog: true,
                              builder: (context) => const CustomYearCalendar()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              DateFormat('y').format(date),
                              style: const TextStyle(
                                  fontSize: 16,fontWeight: FontWeight.w700, color: Color(0xffBCBCBF)),
                            ),
                            Text(
                              toBeginningOfSentenceCase(
                                  DateFormat('MMMM', 'ru').format(date)),
                              style: const TextStyle(
                                  fontSize: 24,fontWeight: FontWeight.w700, color: Color(0xff4C4C69)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  dayBuilder: ({
                    required date,
                    textStyle ,
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
                                        ? const Color(0xffFF8702)
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
                value: ref.read(selectDateProvider),
                onValueChanged: (date) {
                  ref.read(selectDateProvider.notifier).state = date;

                },
              )
          ),
        );
      },
    );
  }
}
