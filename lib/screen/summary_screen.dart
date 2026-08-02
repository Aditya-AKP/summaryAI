import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:summary_ai_app/controller/result_controller.dart';
import 'package:summary_ai_app/model/difficulty_set.dart';
import 'package:summary_ai_app/screen/question_screen.dart';

class SummaryScreen extends StatefulWidget {
  final String id;
  const SummaryScreen({super.key,required this.id});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {

  ResultController controller = ResultController();


  @override
  void initState() {
    controller.getData(widget.id);
    if(controller.aiResponse==null){
      Navigator.pop(context);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        centerTitle:true,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: SizedBox(
          height: 24,
          child: Marquee(
            text: controller.aiResponse!.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            blankSpace: 40,
            velocity: 35,
            startPadding: 10,
            pauseAfterRound: const Duration(seconds: 2),
            accelerationDuration: const Duration(milliseconds: 600),
            decelerationDuration: const Duration(milliseconds: 600),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard(),
              const SizedBox(height: 24),
              _buildOriginalTextCard(),
              const SizedBox(height: 32),
              _buildDifficultySection(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            Icons.auto_awesome,
            "Generated Summary",
          ),
          const SizedBox(height: 16),
          Text(
            controller.aiResponse!.summary,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOriginalTextCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            Icons.article_outlined,
            "Original Text",
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 250,
            ),
            child: SingleChildScrollView(
              child: Text(
                controller.aiResponse!.originalText,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Test Your Understanding",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "Choose a difficulty level",
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 18),

        _difficultyTile(
          context,
          title: "Easy",
          subtitle: "Perfect for quick revision",
          icon: Icons.sentiment_satisfied_alt,
          color: Colors.green,
          difficulty: controller.aiResponse!.easy,
        ),

        const SizedBox(height: 12),

        _difficultyTile(
          context,
          title: "Medium",
          subtitle: "Test your understanding",
          icon: Icons.psychology_alt_outlined,
          color: Colors.orange,
          difficulty: controller.aiResponse!.medium,
        ),

        const SizedBox(height: 12),

        _difficultyTile(
          context,
          title: "Hard",
          subtitle: "Challenge yourself",
          icon: Icons.emoji_events_outlined,
          color: Colors.red,
          difficulty: controller.aiResponse!.hard,
        ),
      ],
    );
  }

  Widget _difficultyTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required DifficultySet difficulty,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuestionScreen(
              title: controller.aiResponse!.title,
              type: title,
              difficulty: difficulty,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: color.withOpacity(.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon,String title,) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 22,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}