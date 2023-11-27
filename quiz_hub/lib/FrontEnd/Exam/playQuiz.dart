import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_hub/Services/quizDatabase.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/questionModel.dart';

class StartExam extends StatefulWidget {
  final String quizId;
  const StartExam({super.key, required this.quizId});

  @override
  State<StartExam> createState() => _StartExamState();
}


  int _correct = 0;
  int _incorrect = 0;
  int _notAttempted = 0;
  int total = 0;

  /// Stream
  Stream? infoStream;
class _StartExamState extends State<StartExam> {

  QuerySnapshot? questionSnaphot;
  DB_Services databaseService = new DB_Services();

  bool isLoading = true;

  @override
  void initState() {
  databaseService.getQuizQuestions(widget.quizId).then((value) {
  questionSnaphot = value;
  _notAttempted = questionSnaphot!.docs.length;
  _correct = 0;
  _incorrect = 0;
  isLoading = false;
  total = questionSnaphot!.docs.length;
  setState(() {});
  print("init don $total ${widget.quizId} ");
  });

  if(infoStream == null){
  infoStream = Stream<List<int>>.periodic(
  Duration(milliseconds: 100), (x){
  print("this is x $x");
  return [_correct, _incorrect] ;
  });
  }

  super.initState();
  }


  QuestionModel getQuestionModelFromDatasnapshot(
  DocumentSnapshot questionSnapshot) {
  QuestionModel questionModel = new QuestionModel(indexAction: indexAction, question: question, totalQuestions: totalQuestions);

  questionModel.question = questionSnapshot.data["question"];

  /// shuffling the options
  List<String> options = [
  questionSnapshot.data["option1"],
  questionSnapshot.data["option2"],
  questionSnapshot.data["option3"],
  questionSnapshot.data["option4"]
  ];
  options.shuffle();

  questionModel.option1 = options[0];
  questionModel.option2 = options[1];
  questionModel.option3 = options[2];
  questionModel.option4 = options[3];
  questionModel.correctOption = questionSnapshot.data["option1"];
  questionModel.answered = false;

  print(questionModel.correctOption.toLowerCase());

  return questionModel;
  }

  @override
  void dispose() {
  infoStream = null;
  super.dispose();
  }

  Constants constants = Constants();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: constants.backGroundColor,
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
