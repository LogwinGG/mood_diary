import 'dart:collection';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:mood_diary/models/mood_note.dart';


final moodNotesProvider = NotifierProvider<MoodNotes, LinkedHashMap<DateTime, MoodNote>>(MoodNotes.new);



const _uuid = Uuid();
bool isSameDay(DateTime d1, DateTime d2) => (d1.day == d2.day && d1.month == d2.month && d1.year == d2.year);


class MoodNotes extends Notifier<LinkedHashMap<DateTime, MoodNote>> {

  @override
  LinkedHashMap<DateTime, MoodNote> build() => LinkedHashMap<DateTime,MoodNote>(equals: isSameDay)
    ..addAll({
      DateTime(2024,07,16): MoodNote(id:'0', emotions: {'Грусть': ['вялость']},     stressLevel: 8,  selfAssessment: 6, note: 'прокрастинировал'),
      DateTime(2024,07,17): MoodNote(id:'1', emotions: {'Радость':['удовольствие']},stressLevel: 5,  selfAssessment: 7, note: 'кайфовал на самокате, польностью описал данное приложение, начал реализацию'),
      DateTime(2024,07,18): MoodNote(id:'2', emotions: {'Сила':  ['бодрость']},     stressLevel: 0,  selfAssessment: 10,note: 'принял контрасный душ'),
      DateTime(2024,07,19): MoodNote(id:'3', emotions: {'Грусть':    ['вялость']},  stressLevel: 10, selfAssessment: 9 ,note: 'a'),
      DateTime(2024,07,20): MoodNote(id:'4', emotions: {'Радость': ['смелость']},   stressLevel: 7 , selfAssessment: 5 ,note: 'a'),
      DateTime(2024,07,21): MoodNote(id:'5', emotions: {'Сила':    ['бодрость']},   stressLevel: 2 , selfAssessment: 8 ,note: 'a'),
      DateTime(2024,07,22): MoodNote(id:'6', emotions: {'Грусть':   ['вялость']},   stressLevel: 9 , selfAssessment: 5 ,note: 'a'),
      DateTime(2024,07,23): MoodNote(id:'7', emotions: {'Радость': ['смелость']},   stressLevel: 6 , selfAssessment: 9 ,note: 'a'),
      DateTime(2024,07,24): MoodNote(id:'8', emotions: {'Сила':    ['бодрость']},   stressLevel: 1 , selfAssessment: 10,note:'a'),
      DateTime(2024,07,25): MoodNote(id:'9', emotions: {'Грусть':   ['вялость']},   stressLevel: 5 , selfAssessment: 4 ,note: 'a'),
      DateTime(2024,07,26): MoodNote(id:'10', emotions: {'Радость': ['смелость']},  stressLevel: 4 , selfAssessment: 1 ,note: 'a'),
      DateTime(2024,07,27): MoodNote(id:'11', emotions: {'Сила':    ['бодрость']},  stressLevel: 3 , selfAssessment: 3 ,note: 'a'),
    });

  void add({
    required date,
    required Map<String,List<String>> emotions,
    required int stressLevel,
    required int selfAssessment,
    required String note}){
    var next = LinkedHashMap<DateTime,MoodNote>(equals: isSameDay);
    next.addEntries(state.entries);
    next.addAll({
      date :
      MoodNote(id: _uuid.v4(),
          emotions: emotions,
          stressLevel: stressLevel,
          selfAssessment: selfAssessment,
          note: note)
    });
    state = next;
  }

  void remove({required DateTime dateKey}){
    state.remove(dateKey);
  }

  void edit({dateKey,
    Map<String,List<String>>? emotions,
    int? stressLevel,
    int? selfAssessment,
    String? note})
  {
    state.update(dateKey, (moodNote)=> moodNote.copyWith(
      emotions: emotions ?? moodNote.emotions,
      stressLevel: stressLevel ?? moodNote.stressLevel,
      selfAssessment: selfAssessment ?? moodNote.selfAssessment,
      note: note ?? moodNote.note
    ));
  }
}
