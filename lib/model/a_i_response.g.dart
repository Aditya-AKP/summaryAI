// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'a_i_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AIResponseAdapter extends TypeAdapter<AIResponse> {
  @override
  final typeId = 0;

  @override
  AIResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AIResponse(
      originalText: fields[1] as String,
      easy: fields[3] as DifficultySet?,
      hard: fields[5] as DifficultySet?,
      medium: fields[4] as DifficultySet?,
      summary: fields[2] as String,
      createdAt: fields[6] as DateTime,
      id: fields[0] as String,
      title: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AIResponse obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.originalText)
      ..writeByte(2)
      ..write(obj.summary)
      ..writeByte(3)
      ..write(obj.easy)
      ..writeByte(4)
      ..write(obj.medium)
      ..writeByte(5)
      ..write(obj.hard)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AIResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIResponse _$AIResponseFromJson(Map<String, dynamic> json) => AIResponse(
  originalText: json['originalText'] as String? ?? '',
  easy: json['easy'] == null
      ? null
      : DifficultySet.fromJson(json['easy'] as Map<String, dynamic>),
  hard: json['hard'] == null
      ? null
      : DifficultySet.fromJson(json['hard'] as Map<String, dynamic>),
  medium: json['medium'] == null
      ? null
      : DifficultySet.fromJson(json['medium'] as Map<String, dynamic>),
  summary: json['summary'] as String? ?? '',
  createdAt: json['createdAt'] == null
      ? DateTime.now()
      : DateTime.parse(json['createdAt'] as String),
  id: json['id'] as String? ?? '',
  title: json['title'] as String? ?? '',
);

Map<String, dynamic> _$AIResponseToJson(AIResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originalText': instance.originalText,
      'summary': instance.summary,
      'easy': instance.easy,
      'medium': instance.medium,
      'hard': instance.hard,
      'createdAt': instance.createdAt.toIso8601String(),
      'title': instance.title,
    };
