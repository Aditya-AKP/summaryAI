import 'package:summary_ai_app/core/service/groq_service.dart';
import 'package:summary_ai_app/core/service/hive_service.dart';
import 'package:summary_ai_app/model/a_i_response.dart';
import 'package:summary_ai_app/utils/hash.dart';
import 'package:intl/intl.dart';


class DashboardController {

  final GroqService _groqService = GroqService();
  final HiveService _hiveService = HiveService();

  Future<String> generateSummary(String text)async{
    final hash = Hash.generateHash(text);
    if(_hiveService.get(hash)!=null){
      return hash;
    }
    AIResponse response =  await _groqService.generateSummary(text);
    await _hiveService.save(response);
    return response.id;
  }


  Map<String, List<AIResponse>> getAllAIResponse() {
    List<AIResponse> history = _hiveService.getAll();
    if(history.isEmpty)return {};
    final Map<String, List<AIResponse>> grouped = {};

    history.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    final now = DateTime.now();

    for (final item in history) {
      final date = item.createdAt;

      String key;

      final today = DateTime(now.year, now.month, now.day);
      final itemDate = DateTime(date.year, date.month, date.day);

      final difference = today.difference(itemDate).inDays;

      if (difference == 0) {
        key = "Today";
      } else if (difference == 1) {
        key = "Yesterday";
      } else {
        key = DateFormat("dd MMM yyyy").format(date);
      }

      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(item);
    }

    return grouped;
  }


}