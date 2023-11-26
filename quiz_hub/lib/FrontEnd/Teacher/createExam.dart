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

  DateTime? _validDate;

final _formKey = GlobalKey<FormState>();

  TextEditingController examTitle = TextEditingController();
  int? examDuration, noOfQuestion;
  // TextEditingController noOfQuestion = TextEditingController();
  TextEditingController addQuestion = TextEditingController();

  String? quizId;

  List<String> examTitleOptions = ["AI", "SE", "PPSD", "CN", "MAD"];
  String? selectedExamTitle;

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
        "quizTitle": selectedExamTitle,
        "quizDuration" : examDuration,
        "noOfQuestion": noOfQuestion,
        "CreatedAt": DateTime.now(),
        "UpdatedAt" : DateTime.now(),
        "Active" : true,
        "ValidationDate" : _validDate,
      };
      await dbServices.addQuizData(quizMap, quizId!).then((value){
      setState(() {
        _isLoading = false;
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddQuestion(quizId!, noOfQuestion!)),);
      });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      body: _isLoading ? Container(child: Center(child: CircularProgressIndicator()),)
          : Container(
            decoration: BoxDecoration(
              color: constants.backGroundColor,
              borderRadius: BorderRadius.circular(17),
            ),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
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

                          //Exam Title field
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonFormField(
                              value: selectedExamTitle,
                              onChanged: (value) {
                                setState(() {
                                  selectedExamTitle = value;
                                });
                              },
                              items: examTitleOptions.map((title) {
                                return DropdownMenuItem(
                                  value: title,
                                  child: Text(title),
                                );
                              }).toList(),
                              validator: (value) => value!.isEmpty ? "Select Exam Title" : null,
                              decoration: const InputDecoration(
                                hintText: "Exam Title",
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          //Exam Duration Field
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
                              decoration: const InputDecoration(
                                hintText: "Duration (in minutes)",
                              ),

                            ),
                          ),

                          const SizedBox(height: 10),

                          //No of Questions field
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              validator: (val) => val!.isEmpty ? "Enter No of Questions" : null,
                              onChanged: (totalQuestions){
                                noOfQuestion = int.parse(totalQuestions);
                              },
                              decoration: const InputDecoration(
                                hintText: "No of Questions",
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          //Validation Date
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_validDate == null ? 'no date selected' : _validDate.toString()),
                                IconButton(
                                    onPressed: () async {
                                     DateTime? dt =  await showDatePicker(context: context,
                                          initialDate:DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100));
                                     if(dt != null){

                                     setState(() {
                                       _validDate = dt!;
                                     });
                                     }
                                    },
                                    icon: Icon(Icons.calendar_today),
                                )
                              ],
                            )
                          ),

                          SizedBox(height: 100),

                          GestureDetector(
                            onTap: (){
                              CreateQuizOnline();
                            },
                        child:  Container(
                          alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(100),
                              color: constants.darkPurple,
                            ),
                            child: Text('Create Exam', style: TextStyle18,)
                            ),
                          ),
                          SizedBox(height: 10),
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
