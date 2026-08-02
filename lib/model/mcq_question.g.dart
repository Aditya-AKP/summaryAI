// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcq_question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class McqQuestionAdapter extends TypeAdapter<McqQuestion> {
  @override
  final typeId = 2;

  @override
  McqQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return McqQuestion(
      correctAnswer: (fields[2] as num).toInt(),
      explanation: fields[3] as String,
      options: (fields[1] as List).cast<String>(),
      question: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, McqQuestion obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.options)
      ..writeByte(2)
      ..write(obj.correctAnswer)
      ..writeByte(3)
      ..write(obj.explanation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is McqQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

McqQuestion _$McqQuestionFromJson(Map<String, dynamic> json) => McqQuestion(
  correctAnswer: (json['correctAnswer'] as num?)?.toInt() ?? 0,
  explanation: json['explanation'] as String? ?? '',
  options:
      (json['options'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  question: json['question'] as String? ?? '',
);

Map<String, dynamic> _$McqQuestionToJson(McqQuestion instance) =>
    <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
      'explanation': instance.explanation,
    };
