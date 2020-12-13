import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: QuizPage(),
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
  List<Icon> scoreList = [];

  QuestionBank questionBank = QuestionBank();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                questionBank
                    .questionList[questionBank.getQuestionNum()].question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              onPressed: () {
                reviewQuestion(true);
              },
              child: Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              color: Colors.green,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              onPressed: () {
                reviewQuestion(false);
              },
              child: Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              color: Colors.red,
            ),
          ),
        ),
        Row(children: scoreList),
      ],
    );
  }

  void reviewQuestion(bool res) {
    setState(() {
      if (res ==
          questionBank.questionList[questionBank.getQuestionNum()].answer) {
        correctScore();
      } else {
        incorrectScore();
      }

      if (questionBank.getQuestionNum() ==
          questionBank.questionList.length - 1) {
        Alert(
                context: context,
                title: 'ALERT',
                desc:
                    'You have reached the last question. Do you want to reset the questions?')
            .show();
        questionBank.setQuestionNum(0);
        scoreList = [];
      } else {
        questionBank.setQuestionNum(questionBank.getQuestionNum() + 1);
      }
    });
  }

  void correctScore() {
    scoreList.add(
      Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }

  void incorrectScore() {
    scoreList.add(
      Icon(
        Icons.close,
        color: Colors.red,
      ),
    );
  }
}
