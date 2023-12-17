import 'package:flutter/material.dart';

class SubmitExam extends StatefulWidget {
  const SubmitExam({super.key});

  @override
  State<SubmitExam> createState() => _SubmitExamState();
}

class _SubmitExamState extends State<SubmitExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Image(image: AssetImage("assets/images/submit_exam_icon.png"), height: 150,),
        ],
      ),
    );
  }
}
