import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'msq_question.g.dart';


@HiveType(typeId: 3)
@JsonSerializable()
class MsqQuestion {
  @JsonKey(defaultValue: '')
  @HiveField(0)
  final String question;

  @JsonKey(defaultValue: [])
  @HiveField(1)
  final List<String> options;

  @JsonKey(defaultValue: [])
  @HiveField(2)
  final List<int> correctAnswers;

  @JsonKey(defaultValue: '')
  @HiveField(3)
  final String explanation;

  MsqQuestion({
    required this.correctAnswers,
    required this.explanation,
    required this.options,
    required this.question
  });

  factory MsqQuestion.fromJson(Map<String, dynamic> json) =>
      _$MsqQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$MsqQuestionToJson(this);
}