import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/getResult.dart';
import 'package:quiz_hub/Services/quizDatabase.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/questionModel.dart';
import 'QuestionWidget.dart';
import 'dart:async';

class StartExam extends StatefulWidget {
  final  String quizId, quizTitle;
  final int noOfQuestions, quizDuration;
  const StartExam({super.key,
    required this.quizId, required this.quizTitle, required this.quizDuration, required this.noOfQuestions});

  @override
  State<StartExam> createState() => _StartExamState();
}


  int currentQuestionIndex = 0;
  int totalScore = 0;
int scoreValue = 0;
  Stream? infoStream;

class _StartExamState extends State<StartExam> {

  Constants constants = Constants();
  bool _isLoading = true; // Set to true initially to show a loading indicator
  List<Map<String, dynamic>> questions = [];
  DB_Services databaseServices = new DB_Services();
  QuerySnapshot? questionSnapshot;

  // Add more variables to store other quiz details if needed
  late Timer _timer;

  void nextQuestion(index, length){
    if(index < length){
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  //set time duration for quiz
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      int _remainingTimeInSeconds = widget.quizDuration;
      setState(() {
        if (_remainingTimeInSeconds > 0) {
          _remainingTimeInSeconds--;
        } else {
          // Time is over, automatically submit the quiz
          // submitQuiz();
        }
      });
    });
  }


  void loadQuizQuestions() async{
    // Fetch quiz questions from Firestore using quizId
    QuerySnapshot<Map<String, dynamic>> snapShot = await databaseServices.getQuizQuestions(widget.quizId);
    questions = snapShot.docs.map((doc) => doc.data()).toList();
    setState(() {

    });
    // print();
  }


  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  bool nextQuestionButtonDisabled = false;
  bool submitButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Image(image: AssetImage("assets/images/pen_on_paper.png"), height: 150,),
            SizedBox(height: 20,),
            Text("${widget.quizTitle} Exam", style: HeadingStyle2,),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: StreamBuilder(
                stream: databaseServices.getQuizQuestion(widget.quizId),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString(),),);
                  }else{

                    final String currentQuestion = snapshot.data!.docs[currentQuestionIndex]["Question"];
                    final String trueAnswer = snapshot.data!.docs[currentQuestionIndex]['trueAnswer'];
                    final options = snapshot.data!.docs;

                    return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      quizQuestion(question: currentQuestion,currentQuestionIndex: currentQuestionIndex, ),
                      trueOption(prefix: "a", text: options[currentQuestionIndex]['Option1'], index: currentQuestionIndex,onTap: (){if(trueAnswer == options[currentQuestionIndex]['Option1']){scoreValue = 1;}else{scoreValue = 0;} }),
                      trueOption(prefix: "b", text: options[currentQuestionIndex]['Option2'], index: currentQuestionIndex,onTap: (){if(trueAnswer == options[currentQuestionIndex]['Option2']){scoreValue = 1;}else{scoreValue = 0;} }),
                      trueOption(prefix: "c", text: options[currentQuestionIndex]['Option3'], index: currentQuestionIndex,onTap: (){if(trueAnswer == options[currentQuestionIndex]['Option3']){scoreValue = 1;}else{scoreValue = 0;} }),
                      trueOption(prefix: "d", text: options[currentQuestionIndex]['Option4'], index: currentQuestionIndex,onTap: (){if(trueAnswer == options[currentQuestionIndex]['Option4']){scoreValue = 1;}else{scoreValue = 0;} }),

                      SizedBox(height: 100,),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          //submit exam button
                          // if(nextQuestionButtonDisabled)
                         currentQuestionIndex < snapshot.data!.docs.length - 1 ?
                          //Next Question button
                          GestureDetector(
                            onTap: (){
                              totalScore = totalScore + scoreValue;
                              print("gesture index: $currentQuestionIndex");
                              print("total questions ${snapshot.data!.docs.length}");
                              print("Current Score is ${totalScore}");
                              nextQuestion(currentQuestionIndex, snapshot.data!.docs.length);
                            },
                            child:  Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(100),
                                  color: constants.darkPurple,
                                ),
                                child: Text('Next Question', style: TextStyle18,)
                            ),
                          )
                             :
                         GestureDetector(
                           onTap: (){
                             print('total Score is ${totalScore}');
                             Navigator.push(context, MaterialPageRoute(builder: (context) => GetResult(),),);
                           },
                           child:  Container(
                               alignment: Alignment.center,
                               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                               // width: double.infinity,
                               decoration: BoxDecoration(

                                 borderRadius: BorderRadius.circular(100),
                                 color: constants.darkPurple,
                               ),
                               child: Text('Submit Exam', style: TextStyle18,)
                           ),
                         )
                        ],
                      ),
                    ],
                  );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class quizQuestion extends StatelessWidget {
  final String question;
  final int currentQuestionIndex;
  const quizQuestion({super.key, required this.question, required this.currentQuestionIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        child: Text('Question${currentQuestionIndex + 1}: ${question}', style: QuestionTextStyle,));
  }
}

class trueOption extends StatelessWidget {
  final String prefix, text;
  final int index;
  final Function onTap;
  const trueOption({super.key, required this.prefix, required this.text, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Color(0xff8523D9),
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Text("${prefix}: ${text}", style: OptionTextStyle,),),
    );
  }
}
