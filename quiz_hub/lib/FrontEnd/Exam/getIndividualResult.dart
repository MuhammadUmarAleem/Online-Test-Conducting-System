import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Exam/playQuiz.dart';
import 'package:quiz_hub/FrontEnd/Exam/submitResponse.dart';
import 'package:quiz_hub/FrontEnd/Student/getResult.dart';
import 'package:quiz_hub/models/constants.dart';

class getIndResult extends StatefulWidget {
  String quizTitle, quizId;
  int noOfQuestions, trueAnswers;
  getIndResult({super.key, required this.quizId, required this.quizTitle, required this.noOfQuestions, required this.trueAnswers});

  @override
  State<getIndResult> createState() => _getIndResultState();
}

class _getIndResultState extends State<getIndResult> {

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              //quiz title
              Text("     ${widget.quizTitle} \nResult", style: HeadingStyle2,),

              //spacing
              SizedBox(height: 109),

              //showing scrore
              Text("Your score was", style: NormalTextStyle,),

              Text('${(widget.trueAnswers) * 10}', style: HeadingStyle,),

              Text('out of ${(widget.noOfQuestions) * 10}', style: NormalTextStyle,),

              SizedBox(height: 150),

              RichText(
                  text: TextSpan(
                    style: NormalTextStyle,
                    children: [
                      TextSpan(text: "You have attempted ${widget.noOfQuestions} questions out of ${widget.noOfQuestions}."),
                      TextSpan(text: " ${widget.trueAnswers} questions are true"),
                      TextSpan(text: " Which you have attempted.")
                    ]
                  ),),
              SizedBox(height: 30),

              //Back button
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubmitExamResponse(
                     quizId: widget.quizId, quizTitle: widget.quizTitle, noOfQuestions: widget.noOfQuestions, quizScore: widget.trueAnswers * 10, quizTotalScore: widget.noOfQuestions * 10),),);
                },
                child:  Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xff1640D6),
                    ),
                    child: Text('Submit Response', style: TextStyle18,)
                ),
              )
    ],
    ),
        ),
    ),
    );
  }
}
