import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_diary/pages/home_page/home_page.dart';
import 'package:mood_diary/pages/home_page/mood_note_tab/slider_component.dart';
import '../../../repositories/mood_notes.dart';
import '../calendar.dart';
import 'emotions_piker.dart';
import 'feelings_piker.dart';


final stressLevelProvider = StateProvider<int>((ref) => 5);
final selfAssessmentProvider = StateProvider<int>((ref) => 5);
final feelingsProvider = StateProvider<List<String>>((ref) => []);
final noteControler = TextEditingController();

class MoodNoteTab extends ConsumerStatefulWidget {
  const MoodNoteTab({super.key});

  @override
  ConsumerState<MoodNoteTab> createState() => _MoodNoteTabState();
}

class _MoodNoteTabState extends ConsumerState<MoodNoteTab> {

  @override
  Widget build(BuildContext context) {
    ref.listen(moodNotesProvider, (previous, current) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Запись добавленна ${date(current.keys.last) } ')),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        padding (const Text('Что чувствуешь?', style: _textStyle)),
        const EmotionsPiker(),

        ref.watch(emotionProvider)!=null?
          const FeelingsPiker() : const SizedBox(),

        padding(const Text('Уровень стресса', style: _textStyle,)),
        SliderComponent(provider: stressLevelProvider,lableLeft: 'Низкий',lableRight: 'Высокий'),

        padding(const Text('Самооценка', style: _textStyle,)),
        SliderComponent(provider: selfAssessmentProvider,lableLeft: 'Неувереность',lableRight: 'Увереннось'),

        padding(const Text('Заметки', style: _textStyle,)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(210, 210, 210, 1.0),
                  blurRadius: 10.0,
                  spreadRadius: -8.0,
                  offset: Offset(10, 10), // shadow direction: bottom
                )
              ],
            ),
            child: TextField(
              controller: noteControler,
              decoration: const InputDecoration(
                hintText: 'Напишите заметку',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(10.0)) )
              ),
              minLines: 3,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              onChanged: (value)=> Timer(const Duration(milliseconds: 500),()=> setState(() {}) ),


            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
          child: FilledButton(
              onPressed:
                ref.watch(emotionProvider)!=null && ref.watch(feelingsProvider).isNotEmpty && noteControler.text.trim().isNotEmpty?
                  ()=>_save(ref) : null,
              child: const Text(
                'Сохранить',
                style: TextStyle(fontSize: 19),
              )),
        ),
      ],
    );
  }



  _save(WidgetRef ref) {
    ref.read(moodNotesProvider.notifier).add(
      date: ref.read(selectDateProvider)[0],
      emotions: {ref.read(emotionProvider)!: ref.read(feelingsProvider)!},
      stressLevel: ref.read(stressLevelProvider),
      selfAssessment: ref.read(selfAssessmentProvider),
      note: noteControler.text);

    ref.read(emotionProvider.notifier).state = null;
    ref.read(feelingsProvider.notifier).state = [];
    ref.read(stressLevelProvider.notifier).state = 5;
    ref.read(selfAssessmentProvider.notifier).state = 5;
    noteControler.text = '';
  }

  static const TextStyle _textStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

  static Widget padding(Widget child) => Padding(padding: const EdgeInsets.only(left: 10,top: 30,bottom: 15),child: child,);
}
