import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mood_diary/pages/home_page/calendar.dart';
import '../../consts/colors.dart';
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
  double heightP = 0.04;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body:  CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBackgroundColor,
            pinned: false,
            snap: false,
            floating: false,
            centerTitle: true,
            title: Consumer(builder: (context, ref, child) {
              return Text(date(ref.watch(selectDateProvider)[0]), style: const TextStyle(color: Color(0xffBCBCBF),fontSize: 22,fontWeight: FontWeight.w700), );
            },),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(fullscreenDialog: true, builder: (context) => const Calendar())
                  );
                },
                icon: const Icon(Icons.calendar_month,color: Color(0xffBCBCBF),),iconSize: 35,)
            ],
            bottom: PreferredSize(preferredSize: const Size.fromHeight(34),
            child:
                  Center( ///Tabs
                    child: Padding(
                      padding: const EdgeInsets.only(left: 38,right: 38),
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
                                      Image.asset('assets/icons/diary.png',color: _colorITS(0),scale: _selectedTabIndex==0? 1.69 : 1.75,),
                                      const SizedBox(width: 5),
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
                                      Image.asset('assets/icons/stat.png',color: _colorITS(1),scale: _selectedTabIndex==0? 1.69 : 1.75,),
                                      const SizedBox(width: 5),
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
              ),
          ),
          SliverList.list(children: [
            _selectedTabIndex == 0?
              const MoodNoteTab()
              :const StatisticsTab(),
          ])],
      ),
    );
  }

  final TextStyle _styleSelectedTab = const TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.w500);

  final TextStyle _styleUnselectedTab = const TextStyle(
      color: Color(0xffBCBCBF),
      fontSize: 12,
      fontWeight: FontWeight.w500);

  Color _colorITS(int tab) => tab == _selectedTabIndex ? Colors.white
                                               :const Color(0xffBCBCBF);
}

