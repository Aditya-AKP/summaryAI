import 'package:hive_ce/hive.dart';
import 'package:summary_ai_app/model/a_i_response.dart';

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
}