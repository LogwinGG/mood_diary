import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../models/mood_note.dart';
import '../../../repositories/mood_notes.dart';
import '../calendar.dart';

enum TimePeriod { week, week2, month, all }

final dMin = dateNow.subtract(const Duration(days: 3));
final dMax = dateNow.add(const Duration(days: 4));

final minDateProvider = StateProvider<DateTime>((ref) => dMin);
final maxDateProvider = StateProvider<DateTime>((ref) => dMax);


class StatisticsTab extends ConsumerStatefulWidget {
  const StatisticsTab({super.key});

  @override
  ConsumerState<StatisticsTab> createState() => _StatisticsTabState();
}

class _StatisticsTabState extends ConsumerState<StatisticsTab> {
  late TrackballBehavior _trackballBehavior;


  Set<TimePeriod?> _selectTP = {};

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(enable: true,activationMode: ActivationMode.singleTap);
    super.initState();
  }
@override
  Widget build(BuildContext context) {
    List<MapEntry<DateTime, MoodNote>> moodNotes = ref.watch(moodNotesProvider).entries.toList()
      ..sort((a,b)=> a.key.compareTo(b.key));

    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.only(top: 20,left: 0,right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 10.0,right:2, bottom: 15),
                child: SegmentedButton(
                  emptySelectionAllowed: true,
                    segments:  const [
                      ButtonSegment(
                        icon: Icon(Icons.calendar_view_day_outlined,size: 12,),
                        label: Text('Неделя',style: TextStyle(fontSize: 13),softWrap: false, overflow: TextOverflow.visible,),
                        value: TimePeriod.week
                      ),
                      ButtonSegment(
                          icon: Icon(Icons.calendar_view_week,size: 12,),
                          label: Text('2 Недели',style: TextStyle(fontSize: 13),softWrap: false, overflow: TextOverflow.visible,),
                          value: TimePeriod.week2
                      ),
                      ButtonSegment(
                          icon: Icon(Icons.calendar_view_month,size: 12,),
                          label: Text('Месяц',style: TextStyle(fontSize: 13),softWrap: false, overflow: TextOverflow.visible,),
                          value: TimePeriod.month
                      ),
                      ButtonSegment(
                          icon: Icon(Icons.width_full,size: 12,),
                          label: Text('Все',style: TextStyle(fontSize: 13),softWrap: false, overflow: TextOverflow.visible,),
                          value: TimePeriod.all
                      ),
                    ],
                    selected: _selectTP,
                    onSelectionChanged: (v){
                        _selectTP = v;
                        if(v.isEmpty) {
                          ref.read(minDateProvider.notifier).state =  dMin;
                          ref.read(maxDateProvider.notifier).state =  dMax;
                        }
                        else {
                          switch (v.first) {
                            case TimePeriod.week:
                              ref.read(minDateProvider.notifier).state = dateNow.subtract(const Duration(days: 7));
                              ref.read(maxDateProvider.notifier).state = dateNow;
                              break;
                            case TimePeriod.week2:
                              ref.read(minDateProvider.notifier).state = dateNow.subtract(const Duration(days: 14));
                              ref.read(maxDateProvider.notifier).state = dateNow;
                              break;
                            case TimePeriod.month:
                              ref.read(minDateProvider.notifier).state = dateNow.subtract(const Duration(days: 31));
                              ref.read(maxDateProvider.notifier).state = dateNow;
                              break;
                            case TimePeriod.all:
                              ref.read(minDateProvider.notifier).state = moodNotes.firstOrNull?.key ?? dMin;
                              ref.read(maxDateProvider.notifier).state = moodNotes.lastOrNull?.key ?? dMax;
                              break;
                            default:
                          }
                        }
                    },
                    selectedIcon: const Icon(Icons.check_outlined,size: 11,)
                ),
              ),
              SfCartesianChart(
                series: [
                  SplineAreaSeries<MapEntry<DateTime, MoodNote>, dynamic>(
                    dataSource: moodNotes,
                    xValueMapper: (item , i) => item.key,
                    yValueMapper: (item , i) => evaluate(item.value),
                    gradient: const LinearGradient(
                      colors: [ Color.fromRGBO(255, 197, 93, 0.1), Color.fromRGBO(250, 217, 86, 0.4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    splineType: SplineType.monotonic,
                    animationDuration: 1500,
                    //markerSettings: const MarkerSettings( isVisible:  true, borderWidth: 0),
                  )
                ],
                primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.days,
                  minimum: ref.watch(minDateProvider), maximum: ref.watch(maxDateProvider),
                  interval: 1,
                  title: const AxisTitle(text: 'Дни'),
                  majorGridLines: const MajorGridLines(width: 0),
                  minorGridLines: const MinorGridLines(width: 0),
                ),
                primaryYAxis: const NumericAxis(
                  minimum: 0, maximum: 31,interval: 5,
                   title: AxisTitle(text: 'Oценка настроения'),
                  majorGridLines: MajorGridLines(width: 0),
                  minorGridLines: MinorGridLines(width: 0),
                ),
                plotAreaBackgroundImage: const AssetImage('assets/images/background_chart.png'),
                margin: const EdgeInsets.all(0),
                trackballBehavior: _trackballBehavior,

              ),
            ],
       )),
    );
  }

  int evaluate(MoodNote item) {
    int emotionA = 0;
    switch( item.emotions.keys.first) {
      case'Сила':emotionA = 10;break;
      case'Радость': emotionA = 8;break;
      case'Спокойствие':emotionA = 6;break;
      case'Грусть': emotionA = 4;break;
      case'Бешенство': emotionA = 2;break;
      case'Страх': emotionA = 0;break;
    }

    return emotionA + (10 - item.stressLevel) + item.selfAssessment;
  }
}
