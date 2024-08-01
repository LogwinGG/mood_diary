import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mood_diary/pages/home_page/calendar.dart';
import 'mood_note_tab/mood_note_tab.dart';
import 'statistics_tab/statistics_tab.dart';


String date(DateTime? d) {
  d ??= DateTime.now();
  return DateFormat('E, d MMMM', 'ru').format(d);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;
  double heightP = 0.05;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, ref, child) {
          return Text(date(ref.watch(selectDateProvider)[0]) );
          },),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calendar())
                );
              },
              icon: const Icon(Icons.calendar_month),iconSize: 35,)
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Center( ///Tabs
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Container(
                  height: MediaQuery.of(context).size.height * heightP,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * heightP/2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: _selectedTabIndex==0? 60:55,
                          child: GestureDetector(
                            onTap: () => { if(_selectedTabIndex!=0) setState(() => _selectedTabIndex = 0) },
                            child: Container(
                              height: MediaQuery.of(context).size.height * heightP,
                              decoration: BoxDecoration(
                                color: _selectedTabIndex == 0 ? Theme.of(context).primaryColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * heightP/2),
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(Icons.book_outlined,color: _colorITS(0),size: _selectedTabIndex==0? 20:15 ),
                                Text('Дневник настроения', style: _selectedTabIndex == 0 ? _styleSelectedTab : _styleUnselectedTab
                                ),
                              ],),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: _selectedTabIndex==1? 45:40,
                          child: GestureDetector(
                            onTap: () => { if(_selectedTabIndex!=1) setState(() => _selectedTabIndex = 1) },
                            child: Container(
                              height: MediaQuery.of(context).size.height * heightP,
                              decoration: BoxDecoration(
                                color: _selectedTabIndex == 1 ? Theme.of(context).primaryColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * heightP/2),
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Icon(Icons.area_chart_outlined,color: _colorITS(1),size: _selectedTabIndex==1? 20:15),
                                Text('Статистика', style: _selectedTabIndex == 1 ? _styleSelectedTab : _styleUnselectedTab)
                              ],),
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            ),

            _selectedTabIndex == 0?
                const MoodNoteTab()
              : const StatisticsTab(),

          ],
        )
      ),
    );
  }
  final TextStyle _styleSelectedTab = const TextStyle(
      color: Color.fromRGBO(240, 240, 240, 1),
      fontSize: 13,
      fontWeight: FontWeight.w500);

  final TextStyle _styleUnselectedTab = const TextStyle(
      color: Colors.black38,
      fontSize: 12,
      fontWeight: FontWeight.w500);

  Color _colorITS(int tab) => tab== _selectedTabIndex ? const Color.fromRGBO(240, 240, 240, 1)
                                               :Colors.black38;

}
