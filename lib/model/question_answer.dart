import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_answer.g.dart';


@HiveType(typeId: 4)
@JsonSerializable()
class QuestionAnswer {

  @JsonKey(defaultValue: '')
  @HiveField(0)
  final String question;

  @JsonKey(defaultValue: '')
  @HiveField(1)
  final String answer;

  QuestionAnswer({
    required this.answer,
    required this.question
  });

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuestionAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionAnswerToJson(this);

}