import 'package:flutter/material.dart';
import 'package:summary_ai_app/model/difficulty_set.dart';
import 'package:flutter/foundation.dart';
import 'package:summary_ai_app/model/performance_model.dart';

class QuestionScreen extends StatefulWidget {
  final String title;
  final String type;
  final DifficultySet difficulty;
  const QuestionScreen({super.key,required this.difficulty,required this.title,required this.type});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  late List<int?> _mcqSelected;
  late List<bool> _mcqAnswered;
  late List<Set<int>> _msqSelected;
  late List<bool> _msqAnswered;
  late List<TextEditingController> _answerControllers;
  late List<bool> _showModelAnswer;

  int _correctAnswers = 0;
  bool _scoreShown = false;

  int get totalObjectiveQuestions =>widget.difficulty.mcqs.length +widget.difficulty.msqs.length;
  int get answeredDescriptive =>_showModelAnswer.where((e) => e).length;
  int get _tabCount {
    int count = 0;
    if(widget.difficulty.mcqs.isNotEmpty) count++;
    if(widget.difficulty.msqs.isNotEmpty) count++;
    if(widget.difficulty.questions.isNotEmpty) count++;
    return count;
  }

  @override
  void initState() {
    super.initState();
    _mcqSelected = List.filled(widget.difficulty.mcqs.length,null,);
    _mcqAnswered = List.filled(widget.difficulty.mcqs.length,false,);
    _msqSelected = List.generate(widget.difficulty.msqs.length,(_) => <int>{},);
    _msqAnswered = List.filled(widget.difficulty.msqs.length,false,);
    _answerControllers = List.generate(widget.difficulty.questions.length,(_) => TextEditingController(),);
    _showModelAnswer = List.filled(widget.difficulty.questions.length,false,);
  }

  @override
  void dispose() {
    for (final controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabCount,
      child: Scaffold(
        backgroundColor: const Color(0xffF8FAFC),
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text("${widget.type} Questions",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),),
            ],
         ),
         bottom: TabBar(
            tabs: [
              if(widget.difficulty.mcqs.isNotEmpty)Tab(text:"MCQ (${widget.difficulty.mcqs.length})",),
              if(widget.difficulty.msqs.isNotEmpty)Tab(text:"MSQ (${widget.difficulty.msqs.length})",),
              if(widget.difficulty.questions.isNotEmpty)Tab(text:"Questions (${widget.difficulty.questions.length})",),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            if(widget.difficulty.mcqs.isNotEmpty)
              SingleChildScrollView(padding: const EdgeInsets.all(20),child: _buildMcqSection(),),
            if(widget.difficulty.msqs.isNotEmpty)
              SingleChildScrollView(padding: const EdgeInsets.all(20),child: _buildMsqSection(),),
            if(widget.difficulty.questions.isNotEmpty)
              SingleChildScrollView(padding: const EdgeInsets.all(20),child: _buildQuestionSection(),),
          ],
        ),
      ),
    );
  }

  void _checkQuizCompleted() {
    if(_scoreShown) return;
    final mcqDone =_mcqAnswered.every((e) => e);
    final msqDone =_msqAnswered.every((e) => e);
    final descriptiveDone =_showModelAnswer.every((e) => e);
    if(mcqDone && msqDone && descriptiveDone){
      _scoreShown = true;
      _onQuizCompleted();
    }
  }

  Widget _buildMcqSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Multiple Choice Questions",),
        const SizedBox(height: 18),
        ...List.generate(
          widget.difficulty.mcqs.length,
          (index)=>Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: _buildMcqCard(index),
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildMcqCard(int index){
    final question =widget.difficulty.mcqs[index];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Question ${index+1}",style: TextStyle(color: Colors.grey.shade700,),),
          const SizedBox(height: 10),
          Text(question.question,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,),),
          const SizedBox(height: 18),
          ...List.generate(
            question.options.length,
            (optionIndex){
              return RadioListTile<int>(
                value: optionIndex,
                groupValue: _mcqSelected[index],
                onChanged: _mcqAnswered[index]
                    ? null
                    : (value){
                        setState(() {
                          _mcqSelected[index]=value;
                        });
                    },
                title: Text(question.options[optionIndex],),
              );
            },
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _mcqAnswered[index]
                  ? null
                  : ()=>_checkMcq(index),
              child: const Text(
                "Check Answer",
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: _buildMcqExplanation(index),
            crossFadeState:
                _mcqAnswered[index]
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(
              milliseconds: 300,
            ),
          ),
        ],
      ),
    );
  }

  void _checkMcq(int index){
    if(_mcqSelected[index]==null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select an option.",),),);
      return;
    }
    final question =widget.difficulty.mcqs[index];
    final isCorrect =_mcqSelected[index]==question.correctAnswer;
    if(isCorrect){
      _correctAnswers++;
    }
    setState(() {
      _mcqAnswered[index]=true;
    });
    _checkQuizCompleted();
  }

  Widget _buildMcqExplanation(int index){
    final question =widget.difficulty.mcqs[index];
    final correct =_mcqSelected[index]==question.correctAnswer;
    return Container(
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: correct? Colors.green.shade50: Colors.red.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                correct? Icons.check_circle: Icons.cancel,
                color: correct? Colors.green: Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                correct? "Correct!": "Incorrect",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: correct? Colors.green: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text("Correct Answer:",style: const TextStyle(fontWeight: FontWeight.bold,),),
          Text(question.options[question.correctAnswer],),
          const SizedBox(height: 14),
          Text("Explanation",style: const TextStyle(fontWeight: FontWeight.bold,),),
          const SizedBox(height: 6),
          Text(question.explanation),
        ],
      ),
    );
  }

  Widget _buildMsqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Multiple Select Questions"),
        const SizedBox(height: 18),
        ...List.generate(
          widget.difficulty.msqs.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: _buildMsqCard(index),
          ),
        ),
        const SizedBox(height: 28),
      ],
    );
  }

  Widget _buildMsqCard(int index) {
    final question = widget.difficulty.msqs[index];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Question ${index + 1}",style: TextStyle(color: Colors.grey.shade700,),),
          const SizedBox(height: 10),
          Text(question.question,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18,),),
          const SizedBox(height: 18),
          ...List.generate(
            question.options.length,
            (optionIndex) {
              return CheckboxListTile(
                value: _msqSelected[index].contains(optionIndex),
                onChanged: _msqAnswered[index]
                    ? null
                    : (value) {
                        setState(() {
                          if (value!) {
                            _msqSelected[index].add(optionIndex);
                          } else {
                            _msqSelected[index].remove(optionIndex);
                          }
                        });
                    },
                title: Text(question.options[optionIndex]),
              );
            },
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _msqAnswered[index]
                  ? null
                  : () => _checkMsq(index),
              child: const Text("Check Answer"),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: _buildMsqExplanation(index),
            crossFadeState: _msqAnswered[index]? CrossFadeState.showSecond: CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          )
        ],
      ),
    );
  }

  void _checkMsq(int index) {
    if (_msqSelected[index].isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select at least one option.",),),);
      return;
    }
    final question = widget.difficulty.msqs[index];
    final isCorrect = setEquals(_msqSelected[index],question.correctAnswers.toSet(),);
    if (isCorrect) {
      _correctAnswers++;
    }
    setState(() {
      _msqAnswered[index] = true;
    });
    _checkQuizCompleted();
  }

  Widget _buildMsqExplanation(int index) {
    final question = widget.difficulty.msqs[index];
    final isCorrect = setEquals(_msqSelected[index],question.correctAnswers.toSet(),);
    return Container(
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect? Colors.green.shade50: Colors.red.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect? Icons.check_circle: Icons.cancel,
                color: isCorrect? Colors.green: Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect? "Correct!": "Incorrect",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCorrect? Colors.green: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text("Correct Answers",style: TextStyle(fontWeight: FontWeight.bold,),),
          const SizedBox(height: 6),
          ...question.correctAnswers.map(
            (index) => Text("• ${question.options[index]}",),
          ),
          const SizedBox(height: 16),
          const Text("Explanation",style: TextStyle(fontWeight: FontWeight.bold,),),
          const SizedBox(height: 6),
          Text(question.explanation),
        ],
      ),
    );
  }

  Widget _buildQuestionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Descriptive Questions"),
        const SizedBox(height: 18),
        ...List.generate(
          widget.difficulty.questions.length,
          (index)=>Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: _buildQuestionCard(index),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(int index) {
    final question = widget.difficulty.questions[index];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Question ${index + 1}",style: TextStyle(color: Colors.grey.shade700,),),
          const SizedBox(height: 10),
          Text(question.question,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 18,),),
          const SizedBox(height: 20),
          TextFormField(
            controller: _answerControllers[index],
            enabled: !_showModelAnswer[index],
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(
              hintText: "Write your answer here...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _showModelAnswer[index]? null: ()=>_showAnswer(index),
              child: const Text(
                "Reveal Model Answer",
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: _buildModelAnswer(index),
            crossFadeState: _showModelAnswer[index]
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          )
        ],
      ),
    );
  }

  void _showAnswer(int index) {
    if (_answerControllers[index].text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please write your answer first.",),),);
      return;
    }
    setState(() {
      _showModelAnswer[index] = true;
    });
    _checkQuizCompleted();
  }

  Widget _buildModelAnswer(int index) {
    final question = widget.difficulty.questions[index];
    return Container(
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb,color: Colors.blue,),
              SizedBox(width: 8),
              Text("Model Answer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),),
            ],
          ),
          const SizedBox(height: 12),
          SelectableText(question.answer,style: const TextStyle(height: 1.5,),),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(){
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(.05),blurRadius: 10,offset: const Offset(0,4),),
      ],
    );
  }

  Widget _sectionTitle(String title){
    return Text(title,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),);
  }

  void _onQuizCompleted() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _showScoreDialog();
  }

  void _showScoreDialog() {
    final accuracy = _correctAnswers / totalObjectiveQuestions;
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Score",
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) {
        return Center(
          child: _buildScoreDialog(accuracy),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          ),
          child: child,
        );
      },
    );
  }

  Widget _buildScoreDialog(double accuracy) {
    final performance = _performanceMessage(accuracy);
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: performance.color.withOpacity(.15),
              child: Icon(
                performance.icon,
                color: performance.color,
                size: 42,
              ),
            ),
            const SizedBox(height: 18),
            Text(performance.title,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
            const SizedBox(height: 8),
            Text(performance.message,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey.shade700,),),
            const SizedBox(height: 24),
            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: accuracy,
              ),
              duration: const Duration(milliseconds: 1200),
              builder: (_, value, __) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 10,
                        color: performance.color,
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ),
                    Text("${(value * 100).toInt()}%",style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),),
                  ],
                );
              },
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(child: _buildStatCard("Correct","$_correctAnswers",Colors.green,),),
                const SizedBox(width: 12),
                Expanded(child: _buildStatCard("Wrong","${totalObjectiveQuestions - _correctAnswers}",Colors.red,),),
              ],
            ),
            const SizedBox(height: 12),
            _buildStatCard(
              "Descriptive",
              "$answeredDescriptive / ${widget.difficulty.questions.length}",
              Colors.blue,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Review Answers"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title,String value,Color color,) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(value,style: TextStyle(fontSize: 22,color: color,fontWeight: FontWeight.bold,),),
          const SizedBox(height: 4),
          Text(title),
        ],
      ),
    );
  }

  PerformanceResult _performanceMessage(double accuracy) {
    final percent = accuracy * 100;
    if (percent >= 90) {
      return PerformanceResult(
        title: "Outstanding!",
        message: "Excellent work! You mastered this topic.",
        icon: Icons.workspace_premium,
        color: Colors.amber,
      );
    }
    if (percent >= 80) {
      return PerformanceResult(
        title: "Excellent!",
        message: "Great understanding of the material.",
        icon: Icons.emoji_events,
        color: Colors.orange,
      );
    }
    if (percent >= 70) {
      return PerformanceResult(
        title: "Great Job!",
        message: "You're doing really well.",
        icon: Icons.thumb_up,
        color: Colors.green,
      );
    }
    if (percent >= 50) {
      return PerformanceResult(
        title: "Nice Attempt!",
        message: "Review the explanations and try again.",
        icon: Icons.school,
        color: Colors.blue,
      );
    }
    return PerformanceResult(
      title: "Keep Practicing!",
      message: "Don't worry. Read the summary once more and retry.",
      icon: Icons.menu_book,
      color: Colors.red,
    );
  }

}