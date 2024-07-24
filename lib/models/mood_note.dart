import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'mood_note.freezed.dart';
part 'mood_note.g.dart';

@freezed
class MoodNote with _$MoodNote {
  factory MoodNote ({
    required String id,
    required Map<String,List<String>> emotions,
    required int stressLevel,
    required int selfAssessment,
    required String note
  }) = _MoodNote;

  factory MoodNote.fromJson(Map<String, Object?> json)
    => _$MoodNoteFromJson(json);
}
