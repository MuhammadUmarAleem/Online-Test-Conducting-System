import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Exam/getIndividualResult.dart';
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
int? _showQuizTimer;
late Timer _timer;
String showTimer = "";
  Stream? infoStream;

// Declare a StreamController to manage the stream
late StreamController<List<QueryDocumentSnapshot<Object?>>> _controller;

class _StartExamState extends State<StartExam> {

  Constants constants = Constants();
  bool _isLoading = true; // Set to true initially to show a loading indicator
  bool _isSeleted = false; // Set to true initially to show a loading indicator
  List<Map<String, dynamic>> questions = [];
  DB_Services databaseServices = new DB_Services();

  void nextQuestion(index, length){
    if(index < length){
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  Timer _startTimer(int _quizTimer) {
    // timer = (widget.quizDuration) * 60;
    const oneSec = Duration(seconds: 1);
    return Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (_quizTimer < 1) {
          t.cancel();
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => getIndResult(quizId: widget.quizId, quizTitle: widget.quizTitle, noOfQuestions: widget.noOfQuestions, trueAnswers: totalScore),),);
        }else{
          _quizTimer--;
          showTimer = "${_quizTimer}";
        }
      });
    });
  }

    void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  bool nextQuestionButtonDisabled = false;
  bool submitButtonDisabled = true;

  @override
  void initState() {
    int _quizTimer = widget.quizDuration;
    _quizTimer = _quizTimer * 60;
    _controller = StreamController<List<QueryDocumentSnapshot<Object?>>>();
    // Start listening to the stream when the widget is initialized
    databaseServices.getQuizQuestion(widget.quizId).listen((data) {
      _controller.add(data.docs);
    });

    // Start the timer when the widget is initialized
    _timer = _startTimer(_quizTimer);
    super.initState();
  }

  // Function to show logout confirmation dialog
  Future<void> _showSubmitConfirmationDialog(int sentTotalScore) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submit Confirmation'),
          content: const Text('Are you sure you want to submit the exam?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout logic here
                Navigator.of(context).pop(); // Close the dialog
                // Add your logout code here
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => getIndResult(quizId: widget.quizId, quizTitle: widget.quizTitle, noOfQuestions: widget.noOfQuestions, trueAnswers: sentTotalScore),),);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }


  @override
  void dispose() {
    _timer.cancel();
    // Close the StreamController when the widget is disposed
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Image(image: AssetImage("assets/images/pen_on_paper.png"), height: 150,),
                SizedBox(width: 20,),

                // Display remaining time
                Text('Time: ${showTimer}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text("${widget.quizTitle} Exam", style: HeadingStyle2,),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: _controller.stream,
                initialData: [], // Provide an initial empty snapshot
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString(),),);
                  }else{
                    final List<DocumentSnapshot<Object?>> documentList  = snapshot.data!;
                    if(documentList.isEmpty){
                      return Center(child: Text("No questions available."),);
                    }
                    final String currentQuestion = documentList[currentQuestionIndex]["Question"];
                    final String trueAnswer = documentList[currentQuestionIndex]['trueAnswer'];
                    final options = documentList;

                    return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      quizQuestion(question: currentQuestion,currentQuestionIndex: currentQuestionIndex, ),
                      trueOption(prefix: "a", text: options[currentQuestionIndex]['Option1'], index: currentQuestionIndex,onTap: (){ _isSeleted = true;  if(trueAnswer == options[currentQuestionIndex]['Option1']){scoreValue = 1;}else{scoreValue = 0;} }),
                      trueOption(prefix: "b", text: options[currentQuestionIndex]['Option2'], index: currentQuestionIndex,onTap: (){ _isSeleted = true; if(trueAnswer == options[currentQuestionIndex]['Option2']){scoreValue = 1;}else{scoreValue = 0;} }),
                      trueOption(prefix: "c", text: options[currentQuestionIndex]['Option3'], index: currentQuestionIndex,onTap: (){ _isSeleted = true; if(trueAnswer == options[currentQuestionIndex]['Option3']){scoreValue = 1;}else{scoreValue = 0;} }),
                      trueOption(prefix: "d", text: options[currentQuestionIndex]['Option4'], index: currentQuestionIndex,onTap: (){ _isSeleted = true; if(trueAnswer == options[currentQuestionIndex]['Option4']){scoreValue = 1;}else{scoreValue = 0;} }),

                      SizedBox(height: 100,),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          //submit exam button
                          // if(nextQuestionButtonDisabled)
                         currentQuestionIndex < documentList.length - 1 ?
                          //Next Question button
                          GestureDetector(
                            onTap: (){
                              if(_isSeleted == false){
                                showMessage(context,
                                    'Please select at least one option');
                              }else{
                              totalScore = totalScore + scoreValue;
                              _isSeleted = false;
                              print("gesture index: $currentQuestionIndex");
                              print("total questions ${documentList.length}");
                              print("Current Score is ${totalScore}");
                              nextQuestion(currentQuestionIndex, documentList.length);
                            }
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
                             if(_isSeleted == false){
                             showMessage(context,
                             'Please select at least one option');
                             }else{
                             _isSeleted = false;
                             print('total Score is ${totalScore}');
                             int sentTotalScore = totalScore;
                             totalScore = 0;
                             _showSubmitConfirmationDialog(sentTotalScore);
                             }
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
