import 'package:hive_ce/hive.dart';
import 'package:summary_ai_app/model/mcq_question.dart';
import 'package:summary_ai_app/model/msq_question.dart';
import 'package:summary_ai_app/model/question_answer.dart';

import 'package:json_annotation/json_annotation.dart';

part 'difficulty_set.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class DifficultySet {
  @JsonKey(defaultValue: [])
  @HiveField(0)
  final List<McqQuestion> mcqs;

  @JsonKey(defaultValue: [])
  @HiveField(1)
  final List<MsqQuestion> msqs;
  
  @JsonKey(defaultValue: [])
  @HiveField(2)
  final List<QuestionAnswer> questions;

  DifficultySet({
    required this.mcqs,
    required this.msqs,
    required this.questions
  });

  factory DifficultySet.fromJson(Map<String, dynamic> json) =>
      _$DifficultySetFromJson(json);

  Map<String, dynamic> toJson() => _$DifficultySetToJson(this);

}