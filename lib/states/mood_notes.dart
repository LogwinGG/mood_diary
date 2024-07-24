import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:mood_diary/models/mood_note.dart';

const _uuid = Uuid();
bool isSameDay(DateTime d1, DateTime d2) => (d1.day == d2.day && d1.month == d2.month && d1.year == d2.year);


class MoodNotes extends Notifier<LinkedHashMap<DateTime, MoodNote>> {

  @override
  LinkedHashMap<DateTime, MoodNote> build() => LinkedHashMap<DateTime,MoodNote>(equals: isSameDay)..addAll({
      DateTime(2024,07,18): MoodNote(id:'0', emotions: {'радость': ['удовольствие','энергичность']}, stressLevel: 5, selfAssessment: 7, note: 'срубил сирень, принял контрасный душ'),
      DateTime(2024,07,17): MoodNote(id:'1', emotions: {'радость': ['удовольствие','энергичность']}, stressLevel: 5, selfAssessment: 7, note: 'кайфовал на самокате, польностью описал данное приложение, начал реализацию'),
      DateTime(2024,07,16): MoodNote(id:'2', emotions: {'Грусть': ['вялость']}, stressLevel: 8, selfAssessment: 6, note: 'прокрастинировал'),
  });

  void add({
    required Map<String,List<String>> emotions,
    required int stressLevel,
    required int selfAssessment,
    required String note}){
    state.addAll({
      DateTime.now():
      MoodNote(id: _uuid.v4(),
          emotions: emotions,
          stressLevel: stressLevel,
          selfAssessment: selfAssessment,
          note: note)
    });

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
