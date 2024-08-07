import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../models/mood_note.dart';
import '../../../repositories/mood_notes.dart';

final dMin = DateTime.now().subtract(const Duration(days: 3));
final dMax = DateTime.now().add(const Duration(days: 1));

final minDateProvider = StateProvider<DateTime>((ref) => dMin);
final maxDateProvider = StateProvider<DateTime>((ref) => dMax);


class StatisticsTab extends ConsumerStatefulWidget {
  const StatisticsTab({super.key});

  @override
  ConsumerState<StatisticsTab> createState() => _StatisticsTabState();
}

class _StatisticsTabState extends ConsumerState<StatisticsTab> {
  late TrackballBehavior _trackballBehavior;

  DateTime? minDate;
  DateTime? maxDate;

  bool _isFilterDate = false ;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(enable: true,activationMode: ActivationMode.singleTap);
    super.initState();
  }
@override
  Widget build(BuildContext context) {
    List<MapEntry<DateTime, MoodNote>> moodNotes = ref.watch(moodNotesProvider).entries.toList()
      ..sort((a,b)=> a.key.compareTo(b.key));

    if (moodNotes.length >= 2 && moodNotes.length < 30 ) {
      minDate = moodNotes.first.key ;
      maxDate = moodNotes.last.key ;
    } else {
      minDate = dMin;
      maxDate = dMax;
    }
    if (_isFilterDate) {
      minDate = ref.watch(minDateProvider) ;
      maxDate = ref.watch(maxDateProvider) ;
    }

    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.only(top: 30,left: 0,right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    const Text("фильтр"),
                    Switch(value: _isFilterDate, onChanged: (v) {
                      setState(() {
                        _isFilterDate = v;
                        ref.read(minDateProvider.notifier).state = dMin.subtract(const Duration(days: 30))  ;
                        ref.read(maxDateProvider.notifier).state = moodNotes.lastOrNull?.key ?? dMax;

                      });
                    }),
                  ],
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
                    splineType: SplineType.cardinal,
                    animationDuration: 1500,
                    markerSettings: const MarkerSettings( isVisible:  true, borderWidth: 0),
                  )
                ],
                primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.days,
                  minimum: minDate, maximum: maxDate,
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
