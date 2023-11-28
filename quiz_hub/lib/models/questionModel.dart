import 'package:flutter/material.dart';
import 'package:quiz_hub/models/constants.dart';

class QuestionModelNew{
  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? correctOption;
  bool? answered;
}

class Question{
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
});

  @override
  String toString(){
    return 'Question(id: $id, title: $title, options: $options )';
  }
}

class QuestionModel extends StatelessWidget {
  const QuestionModel(
      {super.key,
      required this.indexAction,
        required this.question,
        required this.totalQuestions
      });

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Question ${indexAction + 1}: $question', style: QuestionTextStyle,),
    );
  }
}
