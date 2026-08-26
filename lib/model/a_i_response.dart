import 'package:hive_ce/hive.dart';
import 'package:summary_ai_app/model/difficulty_set.dart';

import 'package:json_annotation/json_annotation.dart';

part 'a_i_response.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class AIResponse {

  @JsonKey(defaultValue: '')
  @HiveField(0)
  final String id;

  @JsonKey(defaultValue: '')
  @HiveField(1)         
  final String originalText;

  @JsonKey(defaultValue: '')
  @HiveField(2)
  final String summary;
  @HiveField(3)
  final DifficultySet? easy;
  @HiveField(4)
  final DifficultySet? medium;
  @HiveField(5)
  final DifficultySet? hard;

  @JsonKey(defaultValue: DateTime.now)
  @HiveField(6)
  final DateTime createdAt;

  @JsonKey(defaultValue: '')
  @HiveField(7)
  final String title;

  AIResponse({
    required this.originalText,
    required this.easy,
    required this.hard,
    required this.medium,
    required this.summary,
    required this.createdAt,
    required this.id,
    required this.title
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) =>
      _$AIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AIResponseToJson(this);
}