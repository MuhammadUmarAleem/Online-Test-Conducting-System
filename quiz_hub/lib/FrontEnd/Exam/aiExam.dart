import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/WelcomePage.dart';
import 'package:quiz_hub/FrontEnd/subjectResult/aIResult.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/NavBar.dart';
import 'package:quiz_hub/models/nextButton.dart';
import 'package:quiz_hub/models/optionCard.dart';
import 'package:quiz_hub/models/questionModel.dart';
import 'package:quiz_hub/FrontEnd/Student/getResult.dart';

class AIExam extends StatefulWidget {
  const AIExam({super.key});

  @override
  State<AIExam> createState() => _AIExamState();
}

class _AIExamState extends State<AIExam> {

  Constants constants = Constants();

  final List<Question> _questions = [
    Question(
        id: '10',
        title: 'Who is the inventor of Artificial Intelligenece?',
        options: {'Geoffrey Hinton': false, 'Andrew Ng': false, 'John McCarthy': true, 'Jurgen Schmidhuber': false} ),
    Question(
        id: '11',
        title: 'Which of the following is the branch of Artificial Intelligence??',
        options: {'Machine Learning': true, 'Cyber forensics': false, 'Full-Stack Developer': false, 'Network Design': false} ),
    Question(
        id: '12',
        title: 'What is the goal of Artificial Intelligence?',
        options: {'To solve artificial problems': false, 'To extract scientific causes': false, 'To explain various sorts of intelligence': true, 'To solve real-world problems': false} ),

  ];
int index = 0;

//score of the student
int score = 0;
bool isPressed = false;
bool isAlreadySelected = false;

void nextQuestion(){

  if(index == _questions.length - 1){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AIResult(subject: 'AI Exam', score: score),
      ),
    );
  }else{
    if(isPressed){

  setState(() {
    index++;
    isPressed = false;
    isAlreadySelected = false;
  });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select any option'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(vertical: 20.0),
      ));
    }
}
  }
  void checkAnswerAndUpdate(bool value){
  if(isAlreadySelected){
   return;
  } else{
  if(value){
    score++;
  setState(() {
    isPressed = true;
    isAlreadySelected = true;
  });
  }else{
    setState(() {
      isPressed = true;
      isAlreadySelected = true;
    });
  }
  }
  }

  // Define correct and incorrect colors
  Color correctColor = Colors.green.shade800; // You can change this to the color you want
  Color incorrectColor = Colors.red.shade800; // You can change this to the color you want

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 1,
            ),
            Image(image: AssetImage('assets/images/QuizHub_Logo.png'), height: 45),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        actions: [
          Padding(padding: const EdgeInsets.all(18.0),
          child: Text("Marks: $score", style: scoreTextStyle,),),
        ],

      ),

      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Image(image: AssetImage("assets/images/pen_on_paper.png"), height: 150,),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text("AI Exam", style: HeadingStyle2,),
            ),

            QuestionModel(
                indexAction: index, question: _questions[index].title, totalQuestions: _questions.length),
SizedBox(height: 10,),

            for(int i =0; i < _questions[index].options.length; i++ )
  GestureDetector(
    onTap: () => checkAnswerAndUpdate(_questions[index].options.values.toList()[i]),
    child: OptionCard(
        option: _questions[index].options.keys.toList()[i],
        onTap: () => checkAnswerAndUpdate(_questions[index].options.values.toList()[i]),
        isSelected: isPressed,
        isCorrect: _questions[index].options.values.toList()[i],
        // color: isPressed ? _questions[index].options.values.toList()[i] == true
        //     ? correctColor
        //     : incorrectColor : Colors.purple,
    ),
  ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(nextQuestion: nextQuestion,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
