import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:mood_diary/pages/home_page/calendar.dart';

import 'mood_diary_tab/mood_diary_tab.dart';
import 'statistics_tab/statistics_tab.dart';

String date({DateTime? d}) => DateFormat('E, d MMMM H:m','ru').format(d?? DateTime.now());

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(date() ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calendar())
                );
              },
              icon: const Icon(Icons.calendar_month))
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: FlutterToggleTab(
                width: 80, // width in percent
                borderRadius: 17,
                height: 34,
                selectedIndex: _selectedTabIndex,
                selectedBackgroundColors: [Colors.orange.shade600, Colors.orange.shade600],
                selectedTextStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
                unSelectedTextStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
                labels: const ['Дневник настроения','Статистика'],
                icons: const [Icons.book_outlined, Icons.area_chart_outlined],
                iconSize: 15,
                selectedLabelIndex: (i) => setState(() {_selectedTabIndex = i;}),
                isScroll:false,
                isShadowEnable: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
              child: _selectedTabIndex == 0?
                const MoodDiaryTab()
              : const StatisticsTab(),
            ),

          ],
        )
      ),
    );
  }
}
