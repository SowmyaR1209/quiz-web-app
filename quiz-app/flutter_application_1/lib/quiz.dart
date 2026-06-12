import 'package:flutter/material.dart';
import './main.dart'; // To access the Question class

class Quiz extends StatelessWidget {
  final Question question;
  final Function(int) answerHandler; 

  const Quiz({
    super.key,
    required this.question,
    required this.answerHandler,
  });

  @override
  Widget build(BuildContext context) {
    // Maps the list of answers to a list of ElevatedButton widgets
    final answerWidgets = question.answers.asMap().entries.map((entry) {
      int index = entry.key;
      String answerText = entry.value;

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.deepPurple.shade400,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            shadowColor: Colors.deepPurple.shade100,
          ),
          onPressed: () => answerHandler(index), // Passes the index back to main.dart
          child: Text(
            answerText, 
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Display the question text
        Container(
          padding: const EdgeInsets.only(bottom: 40.0, top: 20),
          child: Text(
            question.questionText,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        
        // Display the answer buttons
        ...answerWidgets,
     ],
);
}
}