import 'package:flutter/material.dart';
import 'package:quiz_hub/FrontEnd/Teacher/TeacherDashboard.dart';
import 'package:quiz_hub/Services/Feedback_Handler_Sqflite.dart';
import 'package:quiz_hub/models/constants.dart';

import '../../models/feedbackModel.dart';

class TeacherFeedback extends StatefulWidget {
  String? teacherName;
  TeacherFeedback({super.key, required this.teacherName});

  @override
  State<TeacherFeedback> createState() => _TeacherFeedbackState();
}

class _TeacherFeedbackState extends State<TeacherFeedback> {
  TextEditingController _feedbackController = TextEditingController();

  //form validation
  final _formKey = GlobalKey<FormState>();

  //feedback subject selection
  List<String> examTitleOptions = ["AI", "SE", "PPSD", "CN", "MAD"];
  String? selectedExamTitle;

  FeedbackHandlerSQLite? feedbackHandler;

  @override
  void initState() {
    super.initState();
    feedbackHandler = FeedbackHandlerSQLite();
  }

  Constants constants = Constants();

  // Function to show the success popup
  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feedback Submitted'),
          content: Text('Your feedback has been submitted successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add your logout code here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TeacherDashboard()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backGroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            //Main Heading
            Center(
              child: Text(
                'RESULT',
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
              height: 20,
            ),
            Text(
              "Please share result feedback with the students",
              style: feedbackTextStyle,
            ),
            SizedBox(
              height: 20,
            ),

            // Add a TextField for user input
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Feedback Subject Title field
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
                        validator: (value) =>
                        value!.isEmpty ? "Select Exam Title" : null,
                        decoration: const InputDecoration(
                          hintText: "Exam Title",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: _feedbackController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter feedback';
                        }
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Type here...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          )),
                      maxLines: 15,
                      // ...
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            //Submit Response button
            GestureDetector(
              onTap: () {
                feedbackHandler!
                    .insert(
                  FeedbackModel(
                      teacherName: '${widget.teacherName}',
                      title: selectedExamTitle.toString(),
                      description: _feedbackController.text),
                )
                    .then((value) {
                  print('data added in sqlite successfully');
                  // Show success popup
                  _showSuccessPopup(context);
                }).onError((error, stackTrace) {
                  print(error.toString());
                });
                // Navigator.push(context);
              },
              child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff1640D6),
                  ),
                  child: Text(
                    'Submit Feedback',
                    style: TextStyle18,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
