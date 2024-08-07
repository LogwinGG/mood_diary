import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mood_diary/pages/home_page/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  await Hive.initFlutter();

  await Hive.openBox('mood_notes');
  runApp(const ProviderScope(child: MyApp()));
  initializeDateFormatting('ru');

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple.shade900,
          primary: Colors.lightBlue[800],
          //brightness: Brightness.light
        ),
        useMaterial3: true,

      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

