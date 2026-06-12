import 'package:flutter/material.dart';
import './main.dart'; // To access quizQuestions.length

class Result extends StatelessWidget {
  final int score;
  final VoidCallback resetHandler;
  
  // The total number of questions is derived from the main file
  final int totalQuestions = quizQuestions.length; 

   Result(this.score, this.resetHandler, {super.key});

  // Determines the congratulatory phrase based on the score
  String get resultPhrase {
    final double percentage = (score / totalQuestions) * 100;

    if (percentage >= 90) {
      return 'Exceptional! You are a quiz master! 🥇';
    } else if (percentage >= 70) {
      return 'Great Job! You know your stuff. 👏';
    } else if (percentage >= 50) {
      return 'Well Done! A solid pass. 👍';
    } else {
      return 'Keep Practicing! You\'ll get there. 🧠';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
          const SizedBox(height: 20),
          Text(
            resultPhrase,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(
            'Final Score: $score/$totalQuestions',
            style: const TextStyle(fontSize: 22, color: Colors.black87),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: resetHandler,
            icon: const Icon(Icons.refresh),
            label: const Text(
              'Restart Quiz',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
            ),
          ),
        ],
     ),
);
}
}