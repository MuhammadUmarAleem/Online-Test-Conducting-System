import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Student/studentDashboard.dart';
import 'package:quiz_hub/Services/quizDatabase.dart';
import 'package:quiz_hub/localStorage/local_storage.dart';
import 'package:quiz_hub/models/constants.dart';

class SubmitExamResponse extends StatefulWidget {
  String quizTitle, quizId;
  int noOfQuestions, quizScore, quizTotalScore;
  SubmitExamResponse(
      {super.key,
      required this.quizId,
      required this.quizTitle,
      required this.noOfQuestions,
      required this.quizScore,
      required this.quizTotalScore});

  @override
  State<SubmitExamResponse> createState() => _SubmitExamResponseState();
}

class _SubmitExamResponseState extends State<SubmitExamResponse> {
  DB_Services dbServices = DB_Services();

  Constants constants = Constants();
  String response = "";
  TextEditingController _responseController = TextEditingController();

  DateTime? _responseValidationDate;

  //form validation
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  late String userRollNo, userEmail;

  //obtaining user logged in credentials
  localStorage localstorage = localStorage();
  Future<void> getUserName() async {
    var login_response = await localStorage().getUser();
    print("response: ${login_response}");

    userEmail = login_response.email.toString();
    userRollNo = login_response.rollNo.toString();
  }

  submitReponseAndScore() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> studentResultMap = {
        "quizId": widget.quizId,
        "quizTitle": widget.quizTitle,
        "StudentRollNo": userRollNo,
        "StudentEmail": userEmail,
        "QuizScore": widget.quizTotalScore,
        "StudentScore": widget.quizScore,
        "CreatedAt": DateTime.now(),
        "UpdatedAt": DateTime.now(),
        "Active": true,
        // "ValidationDate" : _responseValidationDate,
      };
      await dbServices
          .addStudentResultData(studentResultMap, userRollNo)
          .then((value) {
        setState(() {
          localstorage.setResultDataLocally(studentResultMap);
          _isLoading = false;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => studentDashboard()),
          );
        });
      });
    }
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            //Main Heading
            Center(
              child: Text(
                'EXAM',
                style: HeadingStyle2,
              ),
            ),
            Center(
              child: Text(
                'FEEDBACK',
                style: HeadingStyle2,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "How was the exam? Please submit your response",
              style: NormalTextStylePurple,
            ),
            SizedBox(
              height: 30,
            ),

            // Add a TextField for user input
            Form(
              key: _formKey,
              child: TextField(
                controller: _responseController,
                maxLines: 20, // Allows for multiline input
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Type your response here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Submit Response button
            GestureDetector(
              onTap: () {
                submitReponseAndScore();
              },
              child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff1640D6),
                  ),
                  child: Text(
                    'Submit Response',
                    style: TextStyle18,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
