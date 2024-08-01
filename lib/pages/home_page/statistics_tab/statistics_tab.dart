import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../models/mood_note.dart';
import '../../../states/mood_notes.dart';

class StatisticsTab extends ConsumerStatefulWidget {
  const StatisticsTab({super.key});

  @override
  ConsumerState<StatisticsTab> createState() => _StatisticsTabState();
}

class _StatisticsTabState extends ConsumerState<StatisticsTab> {
  late TrackballBehavior _trackballBehavior;

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
      child: Padding(padding: const EdgeInsets.only(top: 30,left: 15,right: 15),
        child: Column(
            children: [
              SfCartesianChart(
                series: [
                  SplineAreaSeries<MapEntry<DateTime, MoodNote>, dynamic>(
                    dataSource: moodNotes,
                    xValueMapper: (item , i) => item.key,
                    yValueMapper: (item , i) => evaluate(item.value),
                    gradient: const LinearGradient(
                      colors: [ Color.fromRGBO(255, 197, 93,1), Color.fromRGBO(250, 217, 86, 0.95)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    splineType: SplineType.cardinal
                    ,
                  )
                ],
                primaryXAxis: const DateTimeAxis(
                  interval: 1,
                  intervalType: DateTimeIntervalType.days,
                  title: AxisTitle(text: 'Дни'),
                  majorGridLines: MajorGridLines(width: 0),
                  minorGridLines: MinorGridLines(width: 0),
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
                // ChartTitle title = const ChartTitle(),
                // List<ChartAxis> axes = const <ChartAxis>[],
                // List<TechnicalIndicator<dynamic, dynamic>> indicators = const <TechnicalIndicator>[]

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
