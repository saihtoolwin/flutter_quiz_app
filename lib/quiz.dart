import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers=[];
  String activeScreen = "start-screen";

  void chooseAnswer(String answer)
  {
    selectedAnswers.add(answer);  

    if(selectedAnswers.length == questions.length)
    {
      setState(() {
        // selectedAnswers=[];
        activeScreen = "results-screen";
      });
    }
  }

  void restartQuize(){
    setState(() {
      selectedAnswers=[];
      activeScreen="question-screen";
    });
  }

  @override
  void initState() {
    activeScreen ="start-screen";
    super.initState();
  }

  void switchScreen() {
    setState(() {
      // activeScreen = QuestionsScreen();
      activeScreen = "question-screen";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == "question-screen") {
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
    }

    if(activeScreen == "results-screen"){
      screenWidget = ResultScreen(chosenAnswers: selectedAnswers,onRestart: restartQuize,);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 62, 34, 121),
                const Color.fromARGB(255, 42, 20, 90),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
