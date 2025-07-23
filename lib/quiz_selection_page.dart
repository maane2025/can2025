import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'quiz_models.dart';
import 'multiple_choice_quiz.dart';
import 'matching_quiz.dart';
import 'timeline_quiz.dart';
import 'base_page.dart';

class QuizSelectionPage extends StatefulWidget {
  const QuizSelectionPage({Key? key}) : super(key: key);

  @override
  State<QuizSelectionPage> createState() => _QuizSelectionPageState();
}

class _QuizSelectionPageState extends State<QuizSelectionPage> {
  List<Quiz> quizzes = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8081/api/quizzes'),
      );

      if (mounted) {
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          setState(() {
            quizzes = data.map((json) => Quiz.fromJson(json)).toList();
            isLoading = false;
          });
        } else {
          setState(() {
            error = 'Failed to load quizzes: ${response.statusCode}';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        // If backend is not available, use default quiz data
        setState(() {
          quizzes = _getDefaultQuizzes();
          isLoading = false;
        });
      }
    }
  }

  List<Quiz> _getDefaultQuizzes() {
    return [
      Quiz(
        id: 'can-history',
        title: 'CAN History Challenge',
        type: QuizType.multipleChoice,
        description: 'Test your knowledge of the rich history of the Africa Cup of Nations.',
        multipleChoiceQuestions: [
          MultipleChoiceQuestion(
            id: 'q1',
            question: 'When was the first Africa Cup of Nations held?',
            options: ['1957', '1960', '1955', '1962'],
            answer: '1957',
          ),
          MultipleChoiceQuestion(
            id: 'q2',
            question: 'Which country has won the most CAN titles?',
            options: ['Cameroon', 'Ghana', 'Nigeria', 'Egypt'],
            answer: 'Egypt',
          ),
          MultipleChoiceQuestion(
            id: 'q3',
            question: 'Who is the all-time top scorer in the history of the CAN?',
            options: ['Didier Drogba', 'Samuel Eto\'o', 'Laurent Pokou', 'Rashidi Yekini'],
            answer: 'Samuel Eto\'o',
          ),
        ],
      ),
      Quiz(
        id: 'stadium-city-matching',
        title: 'Stadium & City Match-Up',
        type: QuizType.matching,
        description: 'Match the CAN 2025 stadiums to their host cities.',
        matchingQuestions: [
          MatchingQuestion(
            id: 'match1',
            instruction: 'Match each stadium to the correct host city.',
            pairs: [
              MatchingPair(id: 'p1', item1: 'Grand Stade de Tanger', item2: 'Tanger'),
              MatchingPair(id: 'p2', item1: 'Stade Mohammed V', item2: 'Casablanca'),
              MatchingPair(id: 'p3', item1: 'Complexe Moulay Abdellah', item2: 'Rabat'),
            ],
          ),
        ],
      ),
      Quiz(
        id: 'can-timeline',
        title: 'CAN Historical Timeline',
        type: QuizType.timeline,
        description: 'Place these key moments in CAN history in the correct chronological order.',
        timelineQuestions: [
          TimelineQuestion(
            id: 'timeline1',
            instruction: 'Drag and drop the events to arrange them from the earliest to the most recent.',
            events: [
              TimelineEvent(
                id: 'e1',
                year: 1957,
                description: 'The first-ever CAN tournament is held in Sudan.',
                correctOrder: 0,
              ),
              TimelineEvent(
                id: 'e2',
                year: 1976,
                description: 'Morocco wins its only CAN title to date.',
                correctOrder: 1,
              ),
              TimelineEvent(
                id: 'e3',
                year: 1990,
                description: 'Algeria wins its first title, hosting the tournament.',
                correctOrder: 2,
              ),
            ],
          ),
        ],
      ),
      Quiz(
        id: 'moroccan-culture',
        title: 'Moroccan Culture Quiz',
        type: QuizType.multipleChoice,
        description: 'Explore the rich culture of the host nation, Morocco.',
        multipleChoiceQuestions: [
          MultipleChoiceQuestion(
            id: 'c1',
            question: 'What is the famous Moroccan stew cooked slowly in a conical pot called?',
            options: ['Couscous', 'Pastilla', 'Tagine', 'Harira'],
            answer: 'Tagine',
          ),
          MultipleChoiceQuestion(
            id: 'c2',
            question: 'The intricate tilework famous in Moroccan architecture is known as...?',
            options: ['Tadelakt', 'Zellij', 'Mashrabiya', 'Gebs'],
            answer: 'Zellij',
          ),
          MultipleChoiceQuestion(
            id: 'c3',
            question: 'Which city is famous for its blue-painted streets and buildings?',
            options: ['Marrakech', 'Fès', 'Chefchaouen', 'Casablanca'],
            answer: 'Chefchaouen',
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Quiz',
      child: const Center(
        child: Text('La fonctionnalité quiz interactif est temporairement désactivée.'),
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context, Quiz quiz) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // Désactive l'interactivité car _navigateToQuiz n'existe plus
      // child: InkWell(
      //   onTap: () => _navigateToQuiz(context, quiz),
      //   borderRadius: BorderRadius.circular(20),
      //   child: Container(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quiz Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getQuizColor(quiz.type).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getQuizIcon(quiz.type),
                  color: _getQuizColor(quiz.type),
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              // Quiz Title
              Text(
                quiz.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Quiz Description
              Expanded(
                child: Text(
                  quiz.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 8),
              // Quiz Type Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getQuizColor(quiz.type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getQuizColor(quiz.type).withOpacity(0.3),
                  ),
                ),
                child: Text(
                  _getQuizTypeText(quiz.type),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getQuizColor(quiz.type),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  IconData _getQuizIcon(QuizType type) {
    switch (type) {
      case QuizType.multipleChoice:
        return Icons.check_circle_outline;
      case QuizType.matching:
        return Icons.extension;
      case QuizType.timeline:
        return Icons.timeline;
    }
  }

  Color _getQuizColor(QuizType type) {
    switch (type) {
      case QuizType.multipleChoice:
        return Colors.green;
      case QuizType.matching:
        return Colors.orange;
      case QuizType.timeline:
        return Colors.purple;
    }
  }

  String _getQuizTypeText(QuizType type) {
    switch (type) {
      case QuizType.multipleChoice:
        return 'QCM';
      case QuizType.matching:
        return 'Matching';
      case QuizType.timeline:
        return 'Timeline';
    }
  }

  // void _navigateToQuiz(BuildContext context, Quiz quiz) {
  //   Widget quizPage;
  //   switch (quiz.type) {
  //     case QuizType.multipleChoice:
  //       quizPage = MultipleChoiceQuiz(quiz: quiz);
  //       break;
  //     case QuizType.matching:
  //       quizPage = MatchingQuiz(quiz: quiz);
  //       break;
  //     case QuizType.timeline:
  //       quizPage = TimelineQuiz(quiz: quiz);
  //       break;
  //   }
  //   Navigator.push(
  //     context,
  //     PageRouteBuilder(
  //       pageBuilder: (context, animation, secondaryAnimation) => quizPage,
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //         return SlideTransition(
  //           position: Tween<Offset>(
  //             begin: const Offset(1.0, 0.0),
  //             end: Offset.zero,
  //           ).animate(CurvedAnimation(
  //             parent: animation,
  //             curve: Curves.easeInOut,
  //           )),
  //           child: child,
  //         );
  //       },
  //       transitionDuration: const Duration(milliseconds: 300),
  //     ),
  //   );
  // }
}

 