import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Exam/playQuiz.dart';
import 'package:quiz_hub/Services/quizDatabase.dart';
import 'package:quiz_hub/localStorage/local_storage.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:quiz_hub/models/NavBar.dart';

class AccessExam extends StatefulWidget {
  const AccessExam({super.key});

  @override
  State<AccessExam> createState() => _AccessExamState();
}

class _AccessExamState extends State<AccessExam> {

  Constants constants = Constants();
    localStorage localResult = localStorage();

    bool isQuizTaken = false;

  //function for checking if the student has already attempted the quiz
  Future<bool> checkIfQuizTaken(BuildContext context, String quizTitle) async {

    //obtaining student roll number from local storage
    var login_response = await localStorage().getUser();
    String _userRollNo = login_response.rollNo.toString();

    String? subjectName;

    //obtaining quiz details to see whether the student has given the quiz
    // Obtain quiz details to see whether the student has given the quiz
    final resultSnap = await FirebaseFirestore.instance
        .collection('Quiz Result')
        .doc('${quizTitle} result')
        .collection("Student Results")
        .doc(_userRollNo)
        .get();

    final data = resultSnap.data();

    // Checking if the quiz is already taken
     data != null && data["quizTitle"] == quizTitle;

    //checking if the quiz is alreeady taken
    if(subjectName == quizTitle){
        return true;
      }else{
        return false;
      }
    }

  DB_Services databaseServices = new DB_Services();

  Widget QuizList(){
    return Expanded(
      child: StreamBuilder(
        stream: databaseServices.getQuizData(),
        builder: (context, snapshot){
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final doc = snapshot.data!.docs;
             return ListView.builder(
                itemCount: doc.length,
                  itemBuilder: (context, index){
                  print("This is doc : ${doc[index]["quizDuration"]}");
                  //     print("length of doc is: ${doc.length}");
                    return GestureDetector(
                        onTap: () async{
                          print('on tap working correctly');
                          print('quiz TItle: ${doc[index]["quizTitle"]}');
                          bool isQuizTaken = await checkIfQuizTaken(context, doc[index]['quizTitle']);
                          print('quiz taken: ${isQuizTaken}');
                          if(isQuizTaken){
                            // User has already taken the quiz
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Quiz Already Taken"),
                                content: Text("You've already attempted the quiz"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              StartExam(
                                  quizId: doc[index]['quizId'],
                                quizTitle: doc[index]['quizTitle'],
                                quizDuration: doc[index]['quizDuration'],
                                noOfQuestions: doc[index]['noOfQuestion'],
                              ),), );
                        }
                          },
                        child: QuizTile(examTitle: doc[index]['quizTitle']),
                        );
                  });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1,
            ),
            Image(image: AssetImage('assets/images/QuizHub_Logo.png'), height: 45),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/person.png'),
              backgroundColor: Colors.white,
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),

      ),

      body: Column(
        children: [
          Container(
              height: 120,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RichText(
                    text: const TextSpan(
                      text: 'Access \n',
                      style: HeadingStyle,
                      children: <TextSpan>[
                        TextSpan(text: '  Exam',
                            style: HeadingStyle
                        ),
                      ],
                    ),
                  ),
              ),


          //Menu Options (Access Exam)
          QuizList(),


          //link to go to next screen
          Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child:  const Text('Go Back', style: NormalTextStyleWhite,),
            ),
          ),

        ],
      ),

    );
  }
}

class QuizTile extends StatelessWidget {
  final String examTitle;

  QuizTile({super.key, required this.examTitle});

  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            constants.darkPurple,
            constants.darkPurple,
            constants.darkPurple,
            Colors.white.withOpacity(0.0),
          ],
        ),
        border: Border.all(
            width: 2,
            color: Colors.grey.withOpacity(0.5)
        ),

        color: constants.whiteBackgroundBorder,
        borderRadius: BorderRadius.circular(17),

      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),


      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text("$examTitle Exam", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 25, fontWeight: FontWeight.w600)),
          ),

        ],
      ),

    );
  }
}




