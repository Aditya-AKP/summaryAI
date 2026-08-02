import 'package:summary_ai_app/core/service/hive_service.dart';
import 'package:summary_ai_app/model/a_i_response.dart';

class ResultController {
  final HiveService _hiveService = HiveService();
  AIResponse? aiResponse;

  void getData(String id){
    aiResponse = _hiveService.get(id);
  }
}