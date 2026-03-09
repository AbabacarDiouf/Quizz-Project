import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuizPage()),
            );
          },
          child: const Text('Commencer le quiz'),
        ),
      ),
    );
  }
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.choices,
    required this.correctAnswerIndex,
  });

  final String question;
  final List<String> choices;
  final int correctAnswerIndex;
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<QuizQuestion> _questions = const [
    QuizQuestion(
      question: 'Quel langage est utilisé pour développer des apps Flutter ?',
      choices: ['Java', 'Dart', 'Kotlin', 'Swift'],
      correctAnswerIndex: 1,
    ),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizFinished = false;
  String? _feedback;

  void _selectAnswer(int selectedIndex) {
    if (_quizFinished) return;

    final currentQuestion = _questions[_currentQuestionIndex];
    final isCorrect = selectedIndex == currentQuestion.correctAnswerIndex;

    setState(() {
      if (isCorrect) {
        _score++;
        _feedback = '✅ Bonne réponse !';
      } else {
        _feedback = '❌ Mauvaise réponse.';
      }
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _currentQuestionIndex++;
        _feedback = null;
        if (_currentQuestionIndex >= _questions.length) {
          _quizFinished = true;
        }
      });
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizFinished = false;
      _feedback = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _quizFinished ? _buildResult() : _buildQuestion(),
      ),
    );
  }

  Widget _buildQuestion() {
    final question = _questions[_currentQuestionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Score : $_score / ${_questions.length}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 24),
        Text(
          question.question,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        ...List.generate(question.choices.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ElevatedButton(
              onPressed: () => _selectAnswer(index),
              child: Text(question.choices[index]),
            ),
          );
        }),
        const SizedBox(height: 8),
        if (_feedback != null)
          Text(
            _feedback!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
      ],
    );
  }

  Widget _buildResult() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quiz terminé !',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Votre score final : $_score / ${_questions.length}',
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _restartQuiz,
            child: const Text('Recommencer'),
          ),
        ],
      ),
    );
  }
}
