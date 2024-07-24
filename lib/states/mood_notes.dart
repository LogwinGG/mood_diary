import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:mood_diary/models/mood_note.dart';

const _uuid = Uuid();


class MoodNotes extends Notifier<List<MoodNote>> {
  @override
  List<MoodNote> build() => [
    MoodNote(id:'0', data: DateTime(2024,07,18), emotions: {'радость': ['удовольствие','энергичность']}, stressLevel: 5, selfAssessment: 7, note: 'срубил сирень, принял контрасный душ'),
    MoodNote(id:'1', data: DateTime(2024,07,17), emotions: {'радость': ['удовольствие','энергичность']}, stressLevel: 5, selfAssessment: 7, note: 'кайфовал на самокате, польностью описал данное приложение, начал реализацию'),
    MoodNote(id:'2', data: DateTime(2024,07,16), emotions: {'Грусть': ['вялость']}, stressLevel: 8, selfAssessment: 6, note: 'прокрастинировал'),
  ];

  void add({
    required Map<String,List<String>> emotions,
    required int stressLevel,
    required int selfAssessment,
    required String note}){
    state = [
      ...state,
      MoodNote(id: _uuid.v4(), data: DateTime.now(), emotions: emotions, stressLevel: stressLevel, selfAssessment: selfAssessment, note: note)
    ];
  }
  void remove({required MoodNote moodNote}){
    state.remove(moodNote);
  }

  void edit( MoodNote moodNote, {
    Map<String,List<String>>? emotions,
    int? stressLevel,
    int? selfAssessment,
    String? note})
  {
    var index = state.indexOf(moodNote);
    state.insert(index ,moodNote.copyWith(
      emotions: emotions ?? moodNote.emotions,
      stressLevel: stressLevel ?? moodNote.stressLevel,
      selfAssessment: selfAssessment ?? moodNote.selfAssessment,
      note: note ?? moodNote.note
    ));
    state.remove(moodNote);
  }
}
