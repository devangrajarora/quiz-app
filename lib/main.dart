import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'question.dart';

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

  int n = questions.length;
  int qno = 0;

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
                if (userAns == questions[qno].ans)
                  addCheck();
                else
                  addCross();

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 12,
          child: Center(
            child: Text(
              questions[qno].text,
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

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
