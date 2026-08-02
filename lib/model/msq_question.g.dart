// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'msq_question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MsqQuestionAdapter extends TypeAdapter<MsqQuestion> {
  @override
  final typeId = 3;

  @override
  MsqQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MsqQuestion(
      correctAnswers: (fields[2] as List).cast<int>(),
      explanation: fields[3] as String,
      options: (fields[1] as List).cast<String>(),
      question: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MsqQuestion obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.options)
      ..writeByte(2)
      ..write(obj.correctAnswers)
      ..writeByte(3)
      ..write(obj.explanation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MsqQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MsqQuestion _$MsqQuestionFromJson(Map<String, dynamic> json) => MsqQuestion(
  correctAnswers:
      (json['correctAnswers'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
  explanation: json['explanation'] as String? ?? '',
  options:
      (json['options'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  question: json['question'] as String? ?? '',
);

Map<String, dynamic> _$MsqQuestionToJson(MsqQuestion instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'correctAnswers': instance.correctAnswers,
      'explanation': instance.explanation,
    };
