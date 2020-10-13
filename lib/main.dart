import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'quiz.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int current = 0;
  double totalScore = 0;

  Quiz Q = Quiz();

  List<Widget> scoreList = [];

  void chkAnswer(bool ans) {
    setState(() {
      if (ans == Q.question[current].answer) {
        scoreList.add(
          Icon(Icons.check, color: Colors.green),
        );
        totalScore += (100.0 / Q.question.length);
      } else
        scoreList.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      current += 1;
    });
  }

  void resetQuiz() {
    setState(() {
      current = 0;
      totalScore = 0;
      scoreList.clear();
    });
  }

  Row bottomRow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: scoreList,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: current < Q.question.length
          ? <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Question ${current + 1}: ${Q.question[current].question}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
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
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () {
                      chkAnswer(true);
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
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      chkAnswer(false);
                    },
                  ),
                ),
              ),
              bottomRow(),
            ]
          : <Widget>[
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Your score: ${totalScore.round()}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
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
                    color: Colors.yellow,
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      resetQuiz();
                    },
                  ),
                ),
              ),
              bottomRow(),
            ],
    );
  }
}
