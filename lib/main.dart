import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'question.dart';

QuestionBank qb = QuestionBank();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
  List<Icon> scorekeeper = [];

  int n = qb.len();
  int qno = 0;
  int correct = 0;

  void addCheck() => scorekeeper.add(Icon(
        Icons.check,
        color: Colors.green,
      ));

  void addCross() => scorekeeper.add(Icon(
        Icons.close,
        color: Colors.red,
      ));

  Expanded button({String option, Color color, bool first}) {
    if (qno == n - 1) {
      if (first) {
        option = 'Retry';
      } else {
        option = 'Quit';
      }
    }

    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          color: color,
          child: Text(
            '$option',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {
            setState(() {
              bool userAns;

              if (option == 'Retry') {
                qno = 0;
                scorekeeper.clear();
              } else if (option == 'Quit') {
                SystemNavigator.pop();
              } else {
                if (option == 'True') {
                  userAns = true;
                } else if (option == 'False') {
                  userAns = false;
                }
                if (userAns == qb.getAnswer(qno)) {
                  correct++;
                  addCheck();
                } else {
                  addCross();
                }

                qno++;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String text = qb.getQuestion(qno);
    if (qno == n - 1) {
      text = 'You got $correct/$qno answers correct!';
      correct = 0;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 12,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        button(option: 'True', color: Colors.green, first: true),
        button(option: 'False', color: Colors.red, first: false),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: scorekeeper,
            ),
          ),
        ),
      ],
    );
  }
}
