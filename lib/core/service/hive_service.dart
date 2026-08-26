import 'package:hive_ce/hive.dart';
import 'package:summary_ai_app/model/a_i_response.dart';
import 'package:summary_ai_app/model/difficulty_set.dart';

class HiveService {
  final Box<AIResponse> _box = Hive.box<AIResponse>("history");

  Future<void> save(AIResponse response) async {
    await _box.put(response.id, response);
  }

  AIResponse? get(String hash) {
    return _box.get(hash);
  }

  List<AIResponse> getAll() {
    return _box.values.toList();
  }

  Future<void> delete(String hash) async {
    await _box.delete(hash);
  }

  Future<void> clear() async {
    await _box.clear();
  }

  Future<void> updateDifficulty(String id,String difficulty,DifficultySet difficultySet) async {
    final existingResponse = _box.get(id);

    if (existingResponse == null) {
      throw Exception('Summary not found');
    }

    AIResponse updatedResponse;

    switch (difficulty.toLowerCase()) {
      case 'easy':
        updatedResponse = AIResponse(
          id: existingResponse.id,
          originalText: existingResponse.originalText,
          title: existingResponse.title,
          summary: existingResponse.summary,
          easy: difficultySet,
          medium: existingResponse.medium,
          hard: existingResponse.hard,
          createdAt: existingResponse.createdAt,
        );
        break;

      case 'medium':
        updatedResponse = AIResponse(
          id: existingResponse.id,
          originalText: existingResponse.originalText,
          title: existingResponse.title,
          summary: existingResponse.summary,
          easy: existingResponse.easy,
          medium: difficultySet,
          hard: existingResponse.hard,
          createdAt: existingResponse.createdAt,
        );
        break;

      case 'hard':
        updatedResponse = AIResponse(
          id: existingResponse.id,
          originalText: existingResponse.originalText,
          title: existingResponse.title,
          summary: existingResponse.summary,
          easy: existingResponse.easy,
          medium: existingResponse.medium,
          hard: difficultySet,
          createdAt: existingResponse.createdAt,
        );
        break;

      default:
        throw ArgumentError('Invalid difficulty: $difficulty');
    }

    await _box.put(id, updatedResponse);
  }
}