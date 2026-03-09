import 'dart:math';

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

enum QuizCategory {
  histoire('Histoire'),
  geographie('Géographie'),
  svt('SVT'),
  mathematiques('Mathématiques');

  const QuizCategory(this.label);
  final String label;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuizCategory _selectedCategory = QuizCategory.histoire;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choisissez un domaine',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<QuizCategory>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Domaine',
              ),
              items: QuizCategory.values
                  .map(
                    (category) => DropdownMenuItem<QuizCategory>(
                      value: category,
                      child: Text(category.label),
                    ),
                  )
                  .toList(),
              onChanged: (category) {
                if (category == null) return;
                setState(() => _selectedCategory = category);
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(category: _selectedCategory),
                  ),
                );
              },
              child: const Text('Commencer le quiz'),
            ),
          ],
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

class QuizRepository {
  static const int maxQuestionsPerQuiz = 5;

  static const Map<QuizCategory, List<QuizQuestion>> _questionsByCategory = {
    QuizCategory.histoire: [
      QuizQuestion(
        question: 'En quelle année a débuté la Révolution française ?',
        choices: ['1789', '1492', '1914', '1960'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Qui était le premier président du Sénégal ?',
        choices: ['Léopold Sédar Senghor', 'Abdou Diouf', 'Macky Sall', 'Blaise Diagne'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel empire avait pour capitale Gao ?',
        choices: ['Empire songhaï', 'Empire romain', 'Empire ottoman', 'Empire byzantin'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Qui a découvert l\'Amérique en 1492 ?',
        choices: ['Christophe Colomb', 'Magellan', 'Vasco de Gama', 'Marco Polo'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quelle guerre a opposé le Nord et le Sud des États-Unis ?',
        choices: ['Guerre de Sécession', 'Première Guerre mondiale', 'Guerre de Corée', 'Guerre froide'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel pharaon est associé aux pyramides de Gizeh ?',
        choices: ['Khéops', 'Toutankhamon', 'Ramsès II', 'Akhenaton'],
        correctAnswerIndex: 0,
      ),
    ],
    QuizCategory.geographie: [
      QuizQuestion(
        question: 'Quelle est la capitale du Sénégal ?',
        choices: ['Dakar', 'Thiès', 'Kaolack', 'Touba'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel est le plus long fleuve d\'Afrique ?',
        choices: ['Nil', 'Congo', 'Niger', 'Zambèze'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Dans quel continent se trouve le Japon ?',
        choices: ['Asie', 'Europe', 'Océanie', 'Amérique du Sud'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel désert couvre une grande partie de l\'Afrique du Nord ?',
        choices: ['Sahara', 'Kalahari', 'Atacama', 'Gobi'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel pays est traversé par l\'équateur ET le méridien de Greenwich ?',
        choices: ['Gabon', 'Brésil', 'Algérie', 'Kenya'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quelle est la plus grande île du monde ?',
        choices: ['Groenland', 'Madagascar', 'Borneo', 'Nouvelle-Guinée'],
        correctAnswerIndex: 0,
      ),
    ],
    QuizCategory.svt: [
      QuizQuestion(
        question: 'Quelle est l\'unité de base du vivant ?',
        choices: ['Cellule', 'Atome', 'Molécule', 'Tissu'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel organe pompe le sang dans le corps humain ?',
        choices: ['Cœur', 'Foie', 'Poumon', 'Rein'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel gaz les plantes absorbent-elles principalement ?',
        choices: ['Dioxyde de carbone', 'Oxygène', 'Azote', 'Hydrogène'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Combien de chromosomes possède l\'être humain ?',
        choices: ['46', '44', '48', '23'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel est le principal pigment de la photosynthèse ?',
        choices: ['Chlorophylle', 'Hémoglobine', 'Mélanine', 'Carotène'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel système contrôle les réactions rapides du corps ?',
        choices: ['Système nerveux', 'Système digestif', 'Système osseux', 'Système lymphatique'],
        correctAnswerIndex: 0,
      ),
    ],
    QuizCategory.mathematiques: [
      QuizQuestion(
        question: '2 + 2 = ?',
        choices: ['3', '4', '5', '6'],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: 'Combien vaut 9 × 7 ?',
        choices: ['63', '56', '72', '49'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel est le résultat de 15 ÷ 3 ?',
        choices: ['5', '4', '6', '3'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quel est le nombre premier ?',
        choices: ['11', '12', '15', '21'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Quelle est la racine carrée de 81 ?',
        choices: ['9', '8', '7', '6'],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: 'Combien de degrés dans un angle droit ?',
        choices: ['90', '45', '60', '180'],
        correctAnswerIndex: 0,
      ),
    ],
  };

  static List<QuizQuestion> buildQuiz(QuizCategory category) {
    final random = Random();
    final questions = List<QuizQuestion>.from(_questionsByCategory[category] ?? const []);
    questions.shuffle(random);
    return questions.take(maxQuestionsPerQuiz).toList();
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.category});

  final QuizCategory category;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<QuizQuestion> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizFinished = false;
  String? _feedback;

  @override
  void initState() {
    super.initState();
    _questions = QuizRepository.buildQuiz(widget.category);
  }

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
      _questions = QuizRepository.buildQuiz(widget.category);
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
        title: Text('Quiz - ${widget.category.label}'),
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
          'Question ${_currentQuestionIndex + 1} / ${_questions.length}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
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
