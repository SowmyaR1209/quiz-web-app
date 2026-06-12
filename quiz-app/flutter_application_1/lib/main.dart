import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

// --- Data Model ---
class Question {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;

  const Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

// --- Mock Data (15 Questions) ---
const List<Question> quizQuestions = [
  Question(
    questionText: 'What is the capital of France?',
    answers: ['Berlin', 'Madrid', 'Paris', 'Rome'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which planet is known as the "Red Planet"?',
    answers: ['Jupiter', 'Mars', 'Venus', 'Saturn'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'The main building block of Flutter UIs is a...',
    answers: ['Component', 'Block', 'Widget', 'Module'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What element has the chemical symbol "O"?',
    answers: ['Gold', 'Oxygen', 'Osmium', 'Iron'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What year did the Titanic sink?',
    answers: ['1912', '1905', '1918', '1923'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What programming language is Flutter built with?',
    answers: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Who wrote "Romeo and Juliet"?',
    answers: ['Charles Dickens', 'Jane Austen', 'William Shakespeare', 'Mark Twain'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the largest ocean on Earth?',
    answers: ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What company developed the Android operating system?',
    answers: ['Apple', 'Microsoft', 'Google', 'Samsung'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'How many sides does a hexagon have?',
    answers: ['Five', 'Six', 'Seven', 'Eight'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'The process of a solid turning directly into a gas is called what?',
    answers: ['Condensation', 'Evaporation', 'Sublimation', 'Deposition'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'In what country would you find the Eiffel Tower?',
    answers: ['Italy', 'Germany', 'France', 'Spain'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the currency of Japan?',
    answers: ['Yuan', 'Won', 'Dollar', 'Yen'],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'Which CSS property controls the text size?',
    answers: ['font-style', 'text-size', 'font-family', 'font-size'],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What gas makes up the majority of Earth\'s atmosphere?',
    answers: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Argon'],
    correctAnswerIndex: 2,
  ),
];

void main() => runApp(const QuizApp());

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  // Navigation State: 0=Home, 1=Quiz, 2=Settings
  int _selectedPageIndex = 0; 

  // Quiz State
  var _questionIndex = 0;
  var _totalScore = 0;
  
  // Placeholder for a setting managed by the app
  bool _isDarkMode = false; 

  // --- Quiz Logic ---
  void _answerQuestion(int selectedIndex) {
    var isCorrect = selectedIndex == quizQuestions[_questionIndex].correctAnswerIndex;

    setState(() {
      if (isCorrect) {
        _totalScore += 1;
      }
      _questionIndex = _questionIndex + 1;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _selectedPageIndex = 1; // Return to the Quiz tab
    });
  }

  // --- Navigation Logic ---
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
    // If navigating to the Quiz tab (index 1) after finishing the quiz, reset it.
    if (index == 1 && _questionIndex >= quizQuestions.length) {
      _resetQuiz();
    }
  }

  // New function to start the quiz from the Home screen button
  void _startQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _selectedPageIndex = 1; // Navigate to the Quiz page
    });
  }

  // Widget for the Home Page (Index 0)
  Widget _buildHomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.psychology, size: 80, color: Colors.teal),
          const SizedBox(height: 20),
          const Text(
            'Welcome to the Flutter Quiz!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Test your general knowledge with ${quizQuestions.length} questions.',
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _startQuiz,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Quiz Now', style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }

  // Widget for the Settings Page (Index 2)
  Widget _buildSettingsPage() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'App Preferences',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700),
          ),
        ),
        // Theme Setting
        ListTile(
          leading: const Icon(Icons.color_lens, color: Colors.deepPurple),
          title: const Text('Dark Mode'),
          subtitle: Text(_isDarkMode ? 'Current: Dark' : 'Current: Light'),
          trailing: Switch(
            value: _isDarkMode, 
            onChanged: (val) {
              setState(() {
                _isDarkMode = val;
                // In a real app, this would change the MaterialApp theme
              });
            },
            activeColor: Colors.deepPurple,
          ), 
        ),
        const Divider(),
        // Notifications Setting
        ListTile(
          leading: const Icon(Icons.notifications_active, color: Colors.deepPurple),
          title: const Text('Enable Daily Quiz Reminders'),
          trailing: Switch(value: true, onChanged: (val) {}), // Placeholder switch
        ),
        const Divider(),
        // Reset Scores Action
        ListTile(
          leading: const Icon(Icons.restore, color: Colors.red),
          title: const Text('Reset All Scores'),
          subtitle: const Text('Warning: This action cannot be undone.'),
          onTap: () { 
            // Implement a confirmation modal here before calling _resetQuiz()
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Scores would be reset here!')),
            );
          },
        ),
        const Divider(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'About',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700),
          ),
        ),
        // About App
        const AboutListTile(
          icon: Icon(Icons.info_outline, color: Colors.deepPurple),
          applicationName: 'Flutter Quiz App',
          applicationVersion: '1.0.0',
          applicationLegalese: '© 2024 QuizMaster Development',
          child: Text('App Information'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the content for the Quiz tab (Page 1)
    final Widget quizContent = _questionIndex >= quizQuestions.length
        ? Result(_totalScore, _resetQuiz)
        : Quiz(
            question: quizQuestions[_questionIndex],
            answerHandler: _answerQuestion,
          );

    final List<Widget> pages = [
      // Page 0: Home
      Padding(padding: const EdgeInsets.all(16.0), child: _buildHomePage()),
      // Page 1: Quiz/Result
      Padding(padding: const EdgeInsets.all(16.0), child: quizContent),
      // Page 2: Settings
      _buildSettingsPage(),
    ];

    // Determine AppBar Title dynamically
    String appBarTitle = 'Quiz Home';
    if (_selectedPageIndex == 1) {
      appBarTitle = (_questionIndex < quizQuestions.length) ? 'Quiz in Progress' : 'Quiz Results';
    } else if (_selectedPageIndex == 2) {
      appBarTitle = 'App Settings';
    }


    return MaterialApp(
      title: 'Advanced Quiz App',
      // Apply dark mode conditionally based on state (placeholder logic)
      theme: _isDarkMode ? ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        useMaterial3: true,
      ) : ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 4,
        ),
        
        body: pages[_selectedPageIndex],

        // --- Bottom Navigation Bar ---
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz),
              label: 'Quiz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
     ),
);
}
}