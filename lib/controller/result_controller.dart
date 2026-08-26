import 'package:summary_ai_app/core/service/groq_service.dart';
import 'package:summary_ai_app/core/service/hive_service.dart';
import 'package:summary_ai_app/model/a_i_response.dart';
import 'package:summary_ai_app/model/difficulty_set.dart';
import 'package:summary_ai_app/utils/question_count.dart';

class ResultController {
  final HiveService _hiveService = HiveService();
  final GroqService _groqService = GroqService();
  AIResponse? aiResponse;

  void getData(String id){
    aiResponse = _hiveService.get(id);
  }

  Future<void> generateQuestion(String difficulty)async{
    if(aiResponse==null)return;
    DifficultySet set = await _groqService.generateQuestions(aiResponse!.originalText, aiResponse!.summary, difficulty, QuestionCount.getCount(aiResponse!.originalText));
    await _hiveService.updateDifficulty(aiResponse!.id,difficulty,set);
    aiResponse = _hiveService.get(aiResponse!.id);
  }
}