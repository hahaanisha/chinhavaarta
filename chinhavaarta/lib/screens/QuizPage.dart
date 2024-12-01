import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/formData.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, String>> quizData = [];
  List<Map<String, String>> selectedQuestions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  String? selectedOption;
  bool isAnswered = false;

  @override
  void initState() {
    super.initState();
    loadQuizData();
  }

  Future<void> loadQuizData() async {
    final String response = await rootBundle.loadString('isl_quiz_dataset.csv');
    List<String> rows = response.split('\n');
    quizData = rows
        .skip(1)
        .map((row) {
      List<String> values = row.split(',');
      if (values.length >= 5) {
        return {
          "id": values[0].trim(),
          "sign_url": values[1].trim(),
          "correct_option": values[2].trim(),
          "option_1": values[3].trim(),
          "option_2": values[4].trim(),
        };
      }
      return null; // Filter out invalid rows
    })
        .where((element) => element != null) // Remove null entries
        .cast<Map<String, String>>()
        .toList();

    // Shuffle and pick 5 random questions
    quizData.shuffle(Random());
    selectedQuestions = quizData.take(5).toList();

    setState(() {});
  }

  void checkAnswer() {
    if (selectedOption == null) return;

    String correctOption = selectedQuestions[currentQuestionIndex]["correct_option"]!;
    if (selectedOption == correctOption) {
      score++;
    }

    setState(() {
      isAnswered = true;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < 4) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = null;
        isAnswered = false;
      });
    } else {
      // Navigate to the results page after 5 questions
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(score: score),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedQuestions.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = selectedQuestions[currentQuestionIndex];
    double progress = (currentQuestionIndex + 1) / 5;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chinhvarta',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            Text(
              '${currentQuestionIndex + 1}/5',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Image.asset(
              question["sign_url"]!,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              "What does this sign mean?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Column(
              children: [
                optionButton(question["option_1"]!),
                SizedBox(height: 10),
                optionButton(question["option_2"]!),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isAnswered ? nextQuestion : checkAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: isAnswered ? Colors.blue : Colors.green,
              ),
              child: Text(
                isAnswered ? "Next" : "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget optionButton(String option) {
    Color backgroundColor = Colors.white;

    if (isAnswered) {
      String correctOption = selectedQuestions[currentQuestionIndex]["correct_option"]!;
      if (option == selectedOption) {
        backgroundColor = option == correctOption ? Colors.green : Colors.red;
      }
    }

    return GestureDetector(
      onTap: () {
        if (!isAnswered) {
          setState(() {
            selectedOption = option;
          });
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedOption == option ? Colors.blue : Colors.grey,
            width: 2,
          ),
        ),
        child: Text(
          option,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  final int score;

  ResultPage({required this.score});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Your score: ${widget.score} / 5',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Enter your email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String email = emailController.text;
                if (email.isNotEmpty) {
                  sendQuizResults(email, widget.score);
                  Navigator.pop(context); // Replace with actual user data
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid email.")),
                  );
                }
              },
              child: Text("Resume Chinhavarta"),
            ),
          ],
        ),
      ),
    );
  }
}
