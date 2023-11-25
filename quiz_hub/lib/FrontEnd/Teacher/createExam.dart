import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Teacher/addQuestion.dart';
import 'package:quiz_hub/Services/quizDatabase.dart';
import 'package:quiz_hub/models/constants.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

class CreateExam extends StatefulWidget {
  const CreateExam({super.key});

  @override
  State<CreateExam> createState() => _CreateExamState();
}

class _CreateExamState extends State<CreateExam> {

  Constants constants = Constants();
final _formKey = GlobalKey<FormState>();

  TextEditingController examTitle = TextEditingController();
  int? examDuration;
  TextEditingController noOfQuestion = TextEditingController();
  TextEditingController addQuestion = TextEditingController();

  String? quizId;

  DB_Services dbServices = new DB_Services();

  bool _isLoading = false;
  CreateQuizOnline() async {
    if(_formKey.currentState!.validate()){

      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);
      Map<String, dynamic> quizMap = {
        "quizId" : quizId!,
        "quizTitle": examTitle,
        "quizDuration" : examDuration,
        "noOfQuestion": noOfQuestion,
      };
      await dbServices.addQuizData(quizMap, quizId!).then((value){
      setState(() {
        _isLoading = false;
        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AddQuestion()),);
      });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: constants.whiteBackgroundBorder,
      body: _isLoading ? Container(child: CircularProgressIndicator(),)
          : SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: constants.backGroundColor,
            borderRadius: BorderRadius.circular(17),
          ),
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [

              const Text('QuizHub',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Color(0xff8523D9)),
              ),

              const SizedBox(height: 30),

              //Create Exam
          Form(
            key: _formKey,
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //email input field
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),

                        child: TextFormField(
                          validator: (val) => val!.isEmpty ? "Enter Exam Title" : null,
                          decoration: const InputDecoration(
                            hintText: "Exam Title",
                          ),
                          controller: examTitle,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          validator: (val) => val!.isEmpty ? "Enter Exam Duration" : null,
                          onChanged: (duration){
                            examDuration = int.parse(duration);
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Duration (in minutes)",
                          ),

                        ),
                      ),

                      const SizedBox(height: 10),

                      //confirm password field
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          validator: (val) => val!.isEmpty ? "Enter No of Questions" : null,
                          controller: noOfQuestion,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "No of Questions",
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: (){
                          CreateQuizOnline();
                        },
                    child:  Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: constants.darkPurple,
                        ),
                        child: Text('Create Exam', style: TextStyle18,)
                        ),
                      ),
                    ],
                  ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
