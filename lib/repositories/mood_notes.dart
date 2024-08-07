import 'dart:collection';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:mood_diary/models/mood_note.dart';

import '../consts/fake_data.dart';


final moodNotesProvider = NotifierProvider<MoodNotes, LinkedHashMap<DateTime, MoodNote>>(MoodNotes.new);



const _uuid = Uuid();
bool isSameDay(DateTime d1, DateTime d2) => (d1.day == d2.day && d1.month == d2.month && d1.year == d2.year);


class MoodNotes extends Notifier<LinkedHashMap<DateTime, MoodNote>> {

  @override
  LinkedHashMap<DateTime, MoodNote> build() {
    final dataBox = Hive.box('mood_notes');
    final data = LinkedHashMap<DateTime, MoodNote>(equals: isSameDay);
    if (dataBox.isNotEmpty){
      final res = dataBox.toMap().map((k, v) => MapEntry(DateTime.parse(k), MoodNote.fromJson(jsonDecode(v))));
       data.addEntries(res.entries);
    }
    return data;
  }

  void add({
    required DateTime date,
    required Map<String,List<String>> emotions,
    required int stressLevel,
    required int selfAssessment,
    required String note}){
    final value = LinkedHashMap<DateTime,MoodNote>(equals: isSameDay);
    value.addEntries(state.entries);
    final  map0 = {
      date :
      MoodNote(id: _uuid.v4(),
          emotions: emotions,
          stressLevel: stressLevel,
          selfAssessment: selfAssessment,
          note: note)
    };
    value.addAll(map0);
    Hive.box('mood_notes').put(map0.keys.first.toString() , jsonEncode(map0.values.first) );
    state = value;
  }

  void remove({required DateTime dateKey}){
    final newS = state;
    newS.remove(dateKey);
    state = newS;
    Hive.box('mood_notes').delete(dateKey.toString());
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
