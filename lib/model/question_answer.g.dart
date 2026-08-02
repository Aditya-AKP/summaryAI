// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_answer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAnswerAdapter extends TypeAdapter<QuestionAnswer> {
  @override
  final typeId = 4;

  @override
  QuestionAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionAnswer(
      answer: fields[1] as String,
      question: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionAnswer obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAnswer _$QuestionAnswerFromJson(Map<String, dynamic> json) =>
    QuestionAnswer(
      answer: json['answer'] as String? ?? '',
      question: json['question'] as String? ?? '',
    );

Map<String, dynamic> _$QuestionAnswerToJson(QuestionAnswer instance) =>
    <String, dynamic>{'question': instance.question, 'answer': instance.answer};
