import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mcq_question.g.dart';


@HiveType(typeId: 2)
@JsonSerializable()
class McqQuestion{
  @JsonKey(defaultValue: '')
  @HiveField(0)
  final String question;

  @JsonKey(defaultValue: [])
  @HiveField(1)
  final List<String> options;

  @JsonKey(defaultValue: 0)
  @HiveField(2)
  final int correctAnswer;

  @JsonKey(defaultValue: '')
  @HiveField(3)
  final String explanation;

  McqQuestion({
    required this.correctAnswer,
    required this.explanation,
    required this.options,
    required this.question
  });

  factory McqQuestion.fromJson(Map<String, dynamic> json) =>
      _$McqQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$McqQuestionToJson(this);

}