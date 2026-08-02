import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:summary_ai_app/core/constants.dart';
import 'package:summary_ai_app/model/a_i_response.dart';
import 'package:summary_ai_app/utils/hash.dart';


class GroqService {

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      headers: {
        "Authorization": "Bearer ${dotenv.env['GROQ_API_KEY']}",
        "Content-Type": "application/json",
      }
    )
  );

 
  Future<AIResponse> generateSummary(String text)async{
    try{
      final response = await _dio.post(
        "/chat/completions",
        data:{
          "model":"openai/gpt-oss-20b",
          "response_format": {
            "type": "json_object"
          },
          "messages":[
            {
              "role":"system",
              "content":Constants.systemPrompt
            },
            {
              "role":"user",
              "content":text
            }
          ],
          "temperature":0.2,
          "max_completion_tokens":6000,
        }
      );
      print("PRINT RESPONSE: $response");
      String jsonString = response.data["choices"][0]["message"]["content"];
      String cleaned = jsonString.replaceAll("```json", "").replaceAll("```", "").trim();
      Map<String,dynamic> json = jsonDecode(cleaned);
      AIResponse aiResponse =  AIResponse.fromJson(_sanitizeMsq(json));
      return AIResponse(
        originalText: text, 
        easy: aiResponse.easy, 
        hard: aiResponse.hard, 
        medium: aiResponse.medium, 
        summary: aiResponse.summary, 
        title: aiResponse.title,
        createdAt: DateTime.now(), 
        id: Hash.generateHash(text),
      );
    }on DioException catch(e){
      throw Exception(e.response?.data??"Something Went wrong");
    }
  }

  Map<String, dynamic> _sanitizeMsq(Map<String, dynamic> json) {
    for (final level in ['easy', 'medium', 'hard']) {
      final msqs = json[level]?['msqs'];

      if (msqs is List) {
        for (final msq in msqs) {
          final answers = msq['correctAnswers'];

          if (answers is List &&
            answers.length == 1 &&
            answers.first is String) {

            final value = answers.first as String;

            if (RegExp(r'^\d+$').hasMatch(value)) {
              msq['correctAnswers'] = value.split('').map(int.parse).toList();
            }
          }
        }
      }
    }

    return json;
  }

}