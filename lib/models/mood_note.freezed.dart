// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mood_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MoodNote _$MoodNoteFromJson(Map<String, dynamic> json) {
  return _MoodNote.fromJson(json);
}

/// @nodoc
mixin _$MoodNote {
  String get id => throw _privateConstructorUsedError;
  DateTime get data => throw _privateConstructorUsedError;
  Map<String, List<String>> get emotions => throw _privateConstructorUsedError;
  int get stressLevel => throw _privateConstructorUsedError;
  int get selfAssessment => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoodNoteCopyWith<MoodNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodNoteCopyWith<$Res> {
  factory $MoodNoteCopyWith(MoodNote value, $Res Function(MoodNote) then) =
      _$MoodNoteCopyWithImpl<$Res, MoodNote>;
  @useResult
  $Res call(
      {String id,
      DateTime data,
      Map<String, List<String>> emotions,
      int stressLevel,
      int selfAssessment,
      String note});
}

/// @nodoc
class _$MoodNoteCopyWithImpl<$Res, $Val extends MoodNote>
    implements $MoodNoteCopyWith<$Res> {
  _$MoodNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? emotions = null,
    Object? stressLevel = null,
    Object? selfAssessment = null,
    Object? note = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emotions: null == emotions
          ? _value.emotions
          : emotions // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      stressLevel: null == stressLevel
          ? _value.stressLevel
          : stressLevel // ignore: cast_nullable_to_non_nullable
              as int,
      selfAssessment: null == selfAssessment
          ? _value.selfAssessment
          : selfAssessment // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoodNoteImplCopyWith<$Res>
    implements $MoodNoteCopyWith<$Res> {
  factory _$$MoodNoteImplCopyWith(
          _$MoodNoteImpl value, $Res Function(_$MoodNoteImpl) then) =
      __$$MoodNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime data,
      Map<String, List<String>> emotions,
      int stressLevel,
      int selfAssessment,
      String note});
}

/// @nodoc
class __$$MoodNoteImplCopyWithImpl<$Res>
    extends _$MoodNoteCopyWithImpl<$Res, _$MoodNoteImpl>
    implements _$$MoodNoteImplCopyWith<$Res> {
  __$$MoodNoteImplCopyWithImpl(
      _$MoodNoteImpl _value, $Res Function(_$MoodNoteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = null,
    Object? emotions = null,
    Object? stressLevel = null,
    Object? selfAssessment = null,
    Object? note = null,
  }) {
    return _then(_$MoodNoteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emotions: null == emotions
          ? _value._emotions
          : emotions // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      stressLevel: null == stressLevel
          ? _value.stressLevel
          : stressLevel // ignore: cast_nullable_to_non_nullable
              as int,
      selfAssessment: null == selfAssessment
          ? _value.selfAssessment
          : selfAssessment // ignore: cast_nullable_to_non_nullable
              as int,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoodNoteImpl with DiagnosticableTreeMixin implements _MoodNote {
  _$MoodNoteImpl(
      {required this.id,
      required this.data,
      required final Map<String, List<String>> emotions,
      required this.stressLevel,
      required this.selfAssessment,
      required this.note})
      : _emotions = emotions;

  factory _$MoodNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoodNoteImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime data;
  final Map<String, List<String>> _emotions;
  @override
  Map<String, List<String>> get emotions {
    if (_emotions is EqualUnmodifiableMapView) return _emotions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_emotions);
  }

  @override
  final int stressLevel;
  @override
  final int selfAssessment;
  @override
  final String note;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MoodNote(id: $id, data: $data, emotions: $emotions, stressLevel: $stressLevel, selfAssessment: $selfAssessment, note: $note)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MoodNote'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('emotions', emotions))
      ..add(DiagnosticsProperty('stressLevel', stressLevel))
      ..add(DiagnosticsProperty('selfAssessment', selfAssessment))
      ..add(DiagnosticsProperty('note', note));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoodNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.data, data) || other.data == data) &&
            const DeepCollectionEquality().equals(other._emotions, _emotions) &&
            (identical(other.stressLevel, stressLevel) ||
                other.stressLevel == stressLevel) &&
            (identical(other.selfAssessment, selfAssessment) ||
                other.selfAssessment == selfAssessment) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      data,
      const DeepCollectionEquality().hash(_emotions),
      stressLevel,
      selfAssessment,
      note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoodNoteImplCopyWith<_$MoodNoteImpl> get copyWith =>
      __$$MoodNoteImplCopyWithImpl<_$MoodNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoodNoteImplToJson(
      this,
    );
  }
}

abstract class _MoodNote implements MoodNote {
  factory _MoodNote(
      {required final String id,
      required final DateTime data,
      required final Map<String, List<String>> emotions,
      required final int stressLevel,
      required final int selfAssessment,
      required final String note}) = _$MoodNoteImpl;

  factory _MoodNote.fromJson(Map<String, dynamic> json) =
      _$MoodNoteImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get data;
  @override
  Map<String, List<String>> get emotions;
  @override
  int get stressLevel;
  @override
  int get selfAssessment;
  @override
  String get note;
  @override
  @JsonKey(ignore: true)
  _$$MoodNoteImplCopyWith<_$MoodNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
