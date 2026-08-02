import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:summary_ai_app/model/a_i_response.dart';
import 'package:summary_ai_app/model/difficulty_set.dart';
import 'package:summary_ai_app/model/mcq_question.dart';
import 'package:summary_ai_app/model/msq_question.dart';
import 'package:summary_ai_app/model/question_answer.dart';
import 'package:summary_ai_app/screen/dashboard.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  Hive.registerAdapter(AIResponseAdapter());
  Hive.registerAdapter(DifficultySetAdapter());
  Hive.registerAdapter(McqQuestionAdapter());
  Hive.registerAdapter(MsqQuestionAdapter());
  Hive.registerAdapter(QuestionAnswerAdapter());
  await Hive.openBox<AIResponse>("history");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Dashboard(),
    );
  }
}
