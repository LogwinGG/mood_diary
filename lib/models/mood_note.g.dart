// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoodNoteImpl _$$MoodNoteImplFromJson(Map<String, dynamic> json) =>
    _$MoodNoteImpl(
      id: json['id'] as String,
      data: DateTime.parse(json['data'] as String),
      emotions: (json['emotions'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      stressLevel: (json['stressLevel'] as num).toInt(),
      selfAssessment: (json['selfAssessment'] as num).toInt(),
      note: json['note'] as String,
    );

Map<String, dynamic> _$$MoodNoteImplToJson(_$MoodNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data.toIso8601String(),
      'emotions': instance.emotions,
      'stressLevel': instance.stressLevel,
      'selfAssessment': instance.selfAssessment,
      'note': instance.note,
    };
