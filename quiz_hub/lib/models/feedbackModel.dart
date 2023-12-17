import 'package:flutter/material.dart';

class FeedbackModel{
  // final int? id;
  final String teacherName;
  final String title;
  final String description;

  FeedbackModel({
    required this.teacherName, required this.title, required this.description
  });

  FeedbackModel.fromMap(Map<String, dynamic> res):

        // id          = res['id'],
        teacherName = res['teacherName'],
        title       = res['title'],
        description = res['description'];

  Map<String, Object?> toMap(){
    return {
      // 'id': id,
      'teacherName': teacherName,
      'title': title,
      'description': description,
    };
  }
}