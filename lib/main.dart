import 'package:flutter/material.dart';
import 'package:quiz/QuizBank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBank _quizBank = QuizBank();

void main() => runApp(Quiz());

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> score = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = _quizBank.getCorrectAnswer();
    setState(() {
      if (_quizBank.isFinished() == true) {
        Alert(
                context: context,
                title: 'finished',
                desc: 'you\'ve reached the end')
            .show();
        _quizBank.reset();
        score = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          score.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          score.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        _quizBank.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _quizBank.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                'true',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'false',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: score,
        ),
      ],
    );
  }
}
