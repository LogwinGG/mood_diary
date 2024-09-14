import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_diary/models/mood_note.dart';

import '../../../repositories/mood_notes.dart';
import '../calendar.dart';
import '../home_page.dart';
import 'emotions_piker.dart';
import 'feelings_piker.dart';
import 'slider_component.dart';


final stressLevelProvider = StateProvider<int>((ref) => 5);
final selfAssessmentProvider = StateProvider<int>((ref) => 5);
final feelingsProvider = StateProvider<List<String>>((ref) => []);
final noteControler = TextEditingController();

void clearData (WidgetRef ref) {
  ref.read(emotionProvider.notifier).state = null;
  ref.read(feelingsProvider.notifier).state = [];
  ref.read(stressLevelProvider.notifier).state = 5;
  ref.read(selfAssessmentProvider.notifier).state = 5;
  noteControler.text = '';
}

class MoodNoteTab extends ConsumerStatefulWidget {

  const MoodNoteTab({super.key});

  @override
  ConsumerState<MoodNoteTab> createState() => _MoodNoteTabState();
}

class _MoodNoteTabState extends ConsumerState<MoodNoteTab> {
  late bool isEditing;
  MoodNote? moodNote;
  getDitails(ref) async{
    await Future((){
      if(isEditing){
        moodNote = ref.read(moodNotesProvider).entries.where((el) => el.key == ref.watch(selectDateProvider)[0]).first.value;
        ref.read(emotionProvider.notifier).state = moodNote!.emotions.keys.first;
        ref.read(feelingsProvider.notifier).state = moodNote!.emotions.values.first;
        ref.read(stressLevelProvider.notifier).state = moodNote!.stressLevel;
        ref.read(selfAssessmentProvider.notifier).state = moodNote!.selfAssessment;
        noteControler.text = moodNote!.note;
      }
    });
  }

  @override
  void initState() {
    isEditing = ref.read(moodNotesProvider).keys.contains(dateNow);
    getDitails(ref);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var selectedDate = ref.read(selectDateProvider)[0];
    bool isEditing = ref.read(moodNotesProvider).keys.contains(selectedDate);

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
                hintText: 'Введите заметку',
                hintStyle: TextStyle(color: Color(0xffBCBCBF)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(10.0)) )
              ),
              minLines: 4,
              maxLines: 8,
              textInputAction: TextInputAction.done,
              onChanged: (v)=> Timer(const Duration(milliseconds: 500), () => setState(() {})),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
          child: isEditing?
              FilledButton( onPressed:_validate(ref) && _isCanUpdate(ref)? ()=>_update(ref) : null,
                child: const Text('Сохранить изменения',style: TextStyle(fontSize: 19),))
              :FilledButton(onPressed: _validate(ref)? ()=>_save(ref) : null,
                child: const Text('Сохранить', style: TextStyle(fontSize: 19),)),
        ),
      ],
    );
  }

  bool _validate(WidgetRef ref) => ref.watch(emotionProvider)!=null && ref.watch(feelingsProvider).isNotEmpty && noteControler.text.trim().isNotEmpty;

  bool _isCanUpdate(WidgetRef ref) {
      if(moodNote==null) {return false;}
      else { return
          ref.watch(emotionProvider) != moodNote!.emotions.keys.first ||
          ref.watch(feelingsProvider) != moodNote!.emotions.values.first ||
          ref.watch(stressLevelProvider) != moodNote!.stressLevel ||
          ref.watch(selfAssessmentProvider) != moodNote!.selfAssessment ||
          noteControler.text != moodNote!.note;
      }
  }

  void _save(WidgetRef ref) {
    var sDate = ref.read(selectDateProvider)[0];
    ref.read(moodNotesProvider.notifier).add(
      date: sDate,
      emotions: {ref.read(emotionProvider)!: ref.read(feelingsProvider)!},
      stressLevel: ref.read(stressLevelProvider),
      selfAssessment: ref.read(selfAssessmentProvider),
      note: noteControler.text
    );
    clearData(ref);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Запись добавленна ${date(sDate)} ')),
    );
  }

  void _update(WidgetRef ref) {
    var sDate = ref.read(selectDateProvider)[0];
    ref.read(moodNotesProvider.notifier).update(
        dateKey: sDate,
        emotions: {ref.read(emotionProvider)!: ref.read(feelingsProvider)!},
        stressLevel: ref.read(stressLevelProvider),
        selfAssessment: ref.read(selfAssessmentProvider),
        note: noteControler.text
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Запись обновленна ${date(sDate)} ')),
    );
  }

  static const TextStyle _textStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w800,color: Color(0xFF4c4c69) );

  static Widget padding(Widget child) => Padding(padding: const EdgeInsets.only(left: 10,top: 30,bottom: 15),child: child,);


}

