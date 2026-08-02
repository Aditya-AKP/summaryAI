// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'difficulty_set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DifficultySetAdapter extends TypeAdapter<DifficultySet> {
  @override
  final typeId = 1;

  @override
  DifficultySet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DifficultySet(
      mcqs: (fields[0] as List).cast<McqQuestion>(),
      msqs: (fields[1] as List).cast<MsqQuestion>(),
      questions: (fields[2] as List).cast<QuestionAnswer>(),
    );
  }

  @override
  void write(BinaryWriter writer, DifficultySet obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.mcqs)
      ..writeByte(1)
      ..write(obj.msqs)
      ..writeByte(2)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DifficultySetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DifficultySet _$DifficultySetFromJson(Map<String, dynamic> json) =>
    DifficultySet(
      mcqs:
          (json['mcqs'] as List<dynamic>?)
              ?.map((e) => McqQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      msqs:
          (json['msqs'] as List<dynamic>?)
              ?.map((e) => MsqQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((e) => QuestionAnswer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DifficultySetToJson(DifficultySet instance) =>
    <String, dynamic>{
      'mcqs': instance.mcqs,
      'msqs': instance.msqs,
      'questions': instance.questions,
    };
